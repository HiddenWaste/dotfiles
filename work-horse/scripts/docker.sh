yay -S --needed --noconfirm docker docker-compose

# start service / set to start at boot
sudo systemctl enable --now docker.service
