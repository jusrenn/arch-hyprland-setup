#!/bin/bash
set -e

echo "=== [0] NetworkManager servisi etkinleştiriliyor... ==="
sudo systemctl enable --now NetworkManager.service

echo ">> Sistem güncelleniyor..."
sudo pacman -Syu --noconfirm

echo ">> Tüm temel, sistemsel ve donanımsal paketler kuruluyor..."
sudo pacman -S --noconfirm \
    base-devel linux-headers rsync socat intel-ucode sof-firmware \
    earlyoom thermald fwupd firewalld alsa-utils \
    bluez bluez-utils power-profiles-daemon \
    pipewire pipewire-pulse wireplumber \
    mesa vulkan-intel intel-media-driver libva-intel-driver \
    libinput git curl wget unzip \
    xdg-user-dirs xdg-utils gvfs gvfs-mtp gvfs-smb gvfs-gphoto2 \
    polkit-gnome gnome-disk-utility nautilus \
    kitty zsh sddm hyprland waybar rofi-wayland hyprpaper \
    flatpak xdg-desktop-portal xdg-desktop-portal-hyprland \
    cups cups-pdf system-config-printer ghostscript gsfonts \
    foomatic-db foomatic-db-engine foomatic-db-ppds gutenprint \
    avahi nss-mdns jdk21-openjdk maven tk \
    gnome-keyring gcr evince file-roller gnome-system-monitor \
    swww grim slurp swaylock swayidle vlc xdg-user-dirs-gtk \
    python python-pip python-virtualenv python-setuptools python-wheel \
    cloudflared loupe libsecret firefox pinta \
    systemd-zram-generator noto-fonts noto-fonts-emoji ttf-font-awesome \
    ttf-nerd-fonts-symbols ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-common fonts-gnu-free-fonts

echo ">> Sistem servisleri etkinleştiriliyor..."
sudo systemctl enable --now sddm.service
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now cups.service
sudo systemctl enable --now avahi-daemon.service
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now firewalld.service
sudo systemctl enable --now fwupd.service
sudo systemctl enable --now earlyoom.service
sudo systemctl enable --now thermald.service

echo ">> Yazıcı ağ keşfi yapılandırılıyor..."
sudo sed -i 's/^hosts:.*/hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4/' /etc/nsswitch.conf

echo ">> ZRAM yapılandırılıyor..."
sudo tee /etc/systemd/zram-generator.conf > /dev/null <<EOF
[zram0]
zram-size = ram
compression-algorithm = zstd
EOF
sudo systemctl daemon-reexec
sudo systemctl restart systemd-zram-setup@zram0

echo ">> Flatpak kurulumu tamamlanıyor..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo ">> Varsayılan kabuk ZSH olarak ayarlanıyor..."
chsh -s $(which zsh)

echo ">> Kullanıcı dizinleri oluşturuluyor..."
xdg-user-dirs-update

echo "✅ Sistem eksiksiz kuruldu. Yeniden başlatıp SDDM üzerinden Hyprland oturumuna geçebilirsin."
