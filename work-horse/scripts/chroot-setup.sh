#!/usr/bin/env bash
set -euo pipefail

# This is the first to be ran on the system, while in chroot. Handles everything needed at that point.
# once booted in, be sure to run the other install script

USERNAME="carter"
HOSTNAME="coder"

# Detect CPU vendor and select microcode
CPU_VENDOR=$(grep -m1 'vendor_id' /proc/cpuinfo | awk '{print $3}')
UCODE=""
[[ "$CPU_VENDOR" == "AuthenticAMD" ]] && UCODE="amd-ucode"
[[ "$CPU_VENDOR" == "GenuineIntel" ]] && UCODE="intel-ucode"

# Most of my machines are intel!

# Install base networking, bootloader, and user tools
pacman -Syu --noconfirm --needed \
  networkmanager sudo git base-devel grub efibootmgr vim $UCODE 

## 3.3 Time

# Set the Timezone
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime

# Generate /etc/adjtime
hwclock --systohc

## 3.4 Localization
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

## 3.5 Network Configuration

# Set hostname & create user
echo "$HOSTNAME" > /etc/hostname

if ! id "$USERNAME" &>/dev/null; then
    useradd -m -G wheel -s /bin/bash "$USERNAME"
    echo "Set password for $USERNAME:"
    passwd "$USERNAME"
fi

echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel


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


# Install & configure GRUB (assumes EFI is mounted at /boot)
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Inside chroot-setup.sh (adjust timezone if needed)
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

## MAJOR INSTALL BEGINS!!!
# Temporarily allow passwordless sudo for automated AUR/pacman installs
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

# Run orchestrated-install.sh as carter (-H sets HOME=/home/carter)
sudo -u "$USERNAME" -H bash -c '
    REPO_URL="https://github.com/HiddenWaste/dotfiles.git"
    DOTFILES_DIR="$HOME/code/dotfiles"

    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone "$REPO_URL" "$DOTFILES_DIR"
    bash "$DOTFILES_DIR/work-horse/scripts/orchestrated-install.sh"
'

# Restore normal password-prompted sudo before rebooting
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel
