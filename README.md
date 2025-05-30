# Archlinux + Hyprland Kurulum Scripti

Bu script, Lenovo ThinkBook laptoplarda Arch Linux'un minimal kurulumundan sonra kullanıcının Hyprland tabanlı, GNOME uyumlu, tam teşekküllü bir masaüstü ortamına hızla geçiş yapabilmesi için hazırlanmıştır. Kullanım kolaylığı, donanım desteği ve sistem kararlılığı göz önünde bulundurularak yapılandırılmıştır.

## ✈ Amaç
- Wayland tabanlı Hyprland pencere yöneticisi ile modern bir masaüstü
- GNOME uygulamalarıyla uyumlu bir ortam
- Donanım sürücülerinin otomatik kurulumu
- Flatpak uygulama desteği
- ZRAM ve earlyoom ile bellek optimizasyonu

## ⚡ Gereksinimler
- Daha önceden kurulu ve çalışır durumdaki minimal Arch Linux sistemi
- root yetkisine sahip bir kullanıcı
- Aktif internet bağlantısı

## 🔧 Nasıl Kullanılır
```bash
chmod +x install.sh
./install.sh
```
> Script, sizden Wi-Fi SSID ve şifre girişi isteyecektir.

## 📅 Kurulumda Yapılanlar

### Sistem Paketleri:
- `base-devel`, `linux-headers`, `git`, `sudo`, `zsh`, `nano`, `btop`, `htop`, `starship`

### Sistem Yardımcıları:
- `timeshift`, `openssh`, `rsync`, `reflector`, `socat`, `earlyoom`, `zram-generator`

### Donanım ve Ses:
- Intel mikrocode, mesa, vulkan, pipewire, wireplumber

### Masaüstü Ortamı:
- Hyprland, waybar, swaylock, swayidle, hyprpaper, grim, slurp, wofi, rofi
- XDG desktop portal: hyprland + gtk

### GNOME Uygulamaları Uyumu:
- Nautilus, gnome-disk-utility, gnome-system-monitor, evince, eog

### Yazı Tipleri:
- JetBrains Mono, Ubuntu Nerd Font, Font Awesome, DejaVu, Noto, vb.

### Geliştirme Araçları:
- Python, pip, virtualenv, setuptools, wheel
- JDK 21, Maven, cloudflared

### Flatpak Uygulamaları:
- OnlyOffice, SceneBuilder, Shortwave, Yuki-IPTV, Fedora Media Writer

## ⚠ Dikkat Edilmesi Gerekenler
- NetworkManager'ın minimal kuruluma dahil edilmiş olması gerekir.
- Bu script yeniden başlatma gerektirir.
- Kullanıcı dizinleri otomatik güncellenir, yerelleştirme ayarları ayrıca yapılmalıdır.
- Klavye dili, saat dilimi, locale gibi ayarlar script dışında manuel yapılmalıdır.
