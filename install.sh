#!/bin/bash
set -e

echo "=== [0] NetworkManager servisi etkinleştiriliyor... ==="
sudo systemctl enable --now NetworkManager.service

echo "=== [0] Wi-Fi ağına bağlanılıyor... ==="
read -rp "Wi-Fi SSID: " ssid
read -rsp "Wi-Fi Password: " password
echo
sudo nmcli device wifi connect "$ssid" password "$password"

echo "=== [1/7] Sistem güncelleniyor... ==="
sudo pacman -Syu --noconfirm

echo "=== [2/7] Temel sistem paketleri kuruluyor... ==="
sudo pacman -S --noconfirm \
    base-devel linux-headers sudo git wget curl unzip man-db earlyoom \
    xdg-user-dirs xdg-utils libinput nano rsync reflector zram-generator \
    zsh starship btop htop timeshift openssh gvfs gvfs-smb udisks2 socat

echo "=== [Extra] zram yapılandırması oluşturuluyor... ==="
sudo tee /etc/systemd/zram-generator.conf >/dev/null <<EOF
[zram0]
zram-size = ram
compression-algorithm = zstd
EOF

echo "=== [3/7] Donanım sürücüleri ve ses/video bileşenleri kuruluyor... ==="
sudo pacman -S --noconfirm \
    intel-ucode mesa vulkan-intel libva-intel-driver intel-media-driver \
    sof-firmware alsa-utils pipewire wireplumber pipewire-pulse

echo "=== [4/7] Sistem hizmetleri kuruluyor... ==="
sudo pacman -S --noconfirm \
    bluez bluez-utils power-profiles-daemon thermald fwupd \
    avahi nss-mdns firewalld flatpak

echo "=== [5/7] Wayland/Hyprland ortamı kuruluyor... ==="
sudo pacman -S --noconfirm \
    hyprland waybar wofi rofi swaylock swayidle hyprpaper grim slurp \
    xdg-desktop-portal xdg-desktop-portal-gtk \
    xdg-desktop-portal-hyprland \
    polkit-gnome gnome-keyring libsecret

echo "=== [6/7] Uygulamalar ve yardımcı araçlar kuruluyor... ==="
sudo pacman -S --noconfirm \
    nautilus gnome-disk-utility gnome-system-monitor file-roller \
    evince eog firefox vlc gimp kitty

echo "=== [7/7] Yazı tipleri ve geliştirme ortamı kuruluyor... ==="
sudo pacman -S --noconfirm \
    ttf-font-awesome ttf-jetbrains-mono ttf-jetbrains-mono-nerd \
    ttf-dejavu ttf-liberation noto-fonts ttf-noto-nerd \
    ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols \
    ttf-roboto-mono-nerd ttf-ubuntu-mono-nerd ttf-ubuntu-nerd \
    jdk21-openjdk maven tk tcl \
    python python-pip python-virtualenv python-setuptools python-wheel \
    cloudflared

echo "=== Kullanıcı dizinleri güncelleniyor... ==="
xdg-user-dirs-update

echo "=== /etc/nsswitch.conf için mdns yapılandırması kontrol ediliyor... ==="
if ! grep -q "mdns" /etc/nsswitch.conf; then
    sudo sed -i '/^hosts:/ s/$/ mdns/' /etc/nsswitch.conf
    echo "mdns desteği eklendi."
else
    echo "mdns zaten etkin."
fi

echo "=== Sistem servisleri etkinleştiriliyor... ==="
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now power-profiles-daemon.service
sudo systemctl enable --now thermald.service
sudo systemctl enable --now fwupd.service
sudo systemctl enable --now avahi-daemon.service
sudo systemctl enable --now firewalld.service
sudo systemctl enable --now udisks2.service
sudo systemctl enable --now earlyoom.service

echo "=== Flatpak deposu ekleniyor ve uygulamalar yükleniyor... ==="
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y flathub org.onlyoffice.desktopeditors
flatpak install -y flathub com.gluonhq.SceneBuilder
flatpak install -y flathub de.haeckerfelix.Shortwave
flatpak install -y flathub io.github.yuki_iptv.yuki-iptv
flatpak install -y flathub org.fedoraproject.MediaWriter
flatpak install -y flathub com.obsproject.Studio

echo "=== ✅ Kurulum tamamlandı. Lütfen sistemi yeniden başlatın. ==="
