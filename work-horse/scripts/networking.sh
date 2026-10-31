yay -Sy tailscale openssh

# Start/Enable necessary system services
sudo systemctl enable --now systemd-resolved
sudo systemctl enable --now tailscaled
sudo systemctl enable --now sshd

echo "Run ```tailscale login``` to connect to network"
