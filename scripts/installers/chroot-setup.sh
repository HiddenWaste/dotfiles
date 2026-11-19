#!/usr/bin/env bash
set -euo pipefail

# This is the first script to be ran on the new system, while in chroot. Handles everything needed at that point.
#
# BEFORE THIS (done by hand from the live ISO):
#   partition, format, mount (root on /mnt, ESP on /mnt/boot)
#   pacstrap -K /mnt base linux linux-firmware
#   genfstab -U /mnt >> /mnt/etc/fstab
#   copy this script to /mnt/root/ and run:  arch-chroot /mnt bash /root/chroot-setup.sh
#
# PHASE 1 (this script): bootable system + user + sudo + networking + GRUB, and clone dotfiles.
# PHASE 2 (after reboot, as the user):
#   bash ~/code/dotfiles/work-horse/scripts/orchestrated-install.sh
#
# Set RUN_ORCHESTRATOR=true to run phase 2 here, inside the chroot, instead.
# That is less safe: a failure leaves you mid-install (the trap below still restores sudo).

USERNAME="carter"
HOSTNAME="coder"
TIMEZONE="America/Chicago"
REPO_URL="https://github.com/HiddenWaste/dotfiles.git"
RUN_ORCHESTRATOR=false

## SANITY CHECKS

if [[ $EUID -ne 0 ]]; then
    echo "Run as root (inside arch-chroot)." >&2
    exit 1
fi

# Refuse to run outside a chroot, otherwise this would modify the live ISO
if [[ "$(stat -c '%d:%i' /)" == "$(stat -c '%d:%i' /proc/1/root/.)" ]]; then
    echo "Not inside a chroot. Run: arch-chroot /mnt bash /root/chroot-setup.sh" >&2
    exit 1
fi

# GRUB (EFI) install below needs UEFI boot mode and the ESP mounted at /boot
[[ -d /sys/firmware/efi/efivars ]] || { echo "Not booted in UEFI mode." >&2; exit 1; }
mountpoint -q /boot || { echo "/boot (EFI system partition) is not mounted." >&2; exit 1; }

# Detect CPU vendor and select microcode
CPU_VENDOR=$(grep -m1 'vendor_id' /proc/cpuinfo | awk '{print $3}')
UCODE_PKGS=()
[[ "$CPU_VENDOR" == "AuthenticAMD" ]] && UCODE_PKGS+=(amd-ucode)
[[ "$CPU_VENDOR" == "GenuineIntel" ]] && UCODE_PKGS+=(intel-ucode)

# Most of my machines are intel!

# Helpers for the wheel sudo rule
set_sudoers_normal() {
    echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
    chmod 440 /etc/sudoers.d/wheel
}

set_sudoers_nopasswd() {
    echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
    chmod 440 /etc/sudoers.d/wheel
}


## 3.3 Time

# Set the Timezone
ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime

# Generate /etc/adjtime (can fail in some VMs, not worth aborting over)
hwclock --systohc || echo "WARNING: hwclock --systohc failed (ok in some VMs)"

## 3.4 Localization

# Uncomment the locale BEFORE generating it
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

## 3.5 Network Configuration

# Set hostname
echo "$HOSTNAME" > /etc/hostname

# Install base networking, bootloader, and user tools
# (this must come BEFORE the user/sudo section: sudo provides /etc/sudoers.d)
pacman -Syu --noconfirm --needed \
  networkmanager sudo git base-devel grub efibootmgr vim "${UCODE_PKGS[@]}"

# networkmanager - provides internet service capabilities and nmtui as a utility
# sudo - run commands as root with elevated permissions
# git - clone, pull, push, and do whatever youd like with code
# base-devel - (dependency for yay and hyprland???)
# grub - bootloader of choice
# efibootmgr - service that handles booting into the OS and routing to grub in failure
# vim - text editor of choice
# ucode - helps with optimizations for specific architectures

# Enable NetworkManager so first boot has Wi-Fi/Ethernet ready
systemctl enable NetworkManager

## 3.7 Initramfs
# Not needed: mkinitcpio already ran when the kernel was installed by pacstrap
# (only required for LVM / encryption / RAID)

## 3.8 Root password + user

echo "Set password for root:"
passwd
# To lock root instead (carter has sudo), replace the line above with: passwd -l root

# Create user
if ! id "$USERNAME" &>/dev/null; then
    useradd -m -G wheel -s /bin/bash "$USERNAME"
    echo "Set password for $USERNAME:"
    passwd "$USERNAME"
fi

set_sudoers_normal

## 3.9 Boot loader

# Install & configure GRUB (EFI system partition is mounted at /boot, checked above)
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
# If the firmware refuses the boot entry on some machine, retry with --removable added
grub-mkconfig -o /boot/grub/grub.cfg

## DOTFILES

# Clone (or update) dotfiles as the new user so the files are owned correctly
sudo -u "$USERNAME" -H env REPO_URL="$REPO_URL" bash -c '
    DOTFILES_DIR="$HOME/code/dotfiles"

    mkdir -p "$(dirname "$DOTFILES_DIR")"
    if [ ! -d "$DOTFILES_DIR" ]; then
        git clone "$REPO_URL" "$DOTFILES_DIR"
    else
        git -C "$DOTFILES_DIR" pull
    fi
'

## MAJOR INSTALL (optional, see RUN_ORCHESTRATOR at the top)

if [[ "$RUN_ORCHESTRATOR" == true ]]; then
    # Always restore normal password-prompted sudo on exit, even if the install fails
    trap set_sudoers_normal EXIT

    # Temporarily allow passwordless sudo for automated AUR/pacman installs
    set_sudoers_nopasswd

    # Run orchestrated-install.sh as the user (-H sets HOME=/home/$USERNAME)
    sudo -u "$USERNAME" -H bash "/home/$USERNAME/code/dotfiles/work-horse/scripts/orchestrated-install.sh"
fi

echo
echo "Chroot setup complete."
echo "Next: exit, umount -R /mnt, reboot, then log in as $USERNAME."
if [[ "$RUN_ORCHESTRATOR" != true ]]; then
    echo "Wi-Fi? Run nmtui first. Then run:"
    echo "  bash ~/code/dotfiles/work-horse/scripts/orchestrated-install.sh"
fi
echo "After that, run secrets.sh and work-repos.sh manually, then: tailscale login"
