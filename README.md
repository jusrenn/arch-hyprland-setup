# 🖥️ Arch Linux + Hyprland Otomatik Kurulum Scripti

Bu script, Arch Linux'un **minimal kurulumundan hemen sonra**, sisteminizi eksiksiz ve modern bir masaüstü işletim sistemine dönüştürür.  
Özellikle Hyprland pencere yöneticisi ile uyumlu, GNOME araçlarıyla entegre, donanım dostu ve kullanıcıyı hiçbir yapılandırma ile uğraştırmayan bir sistem hedeflenmiştir.

---

## ✈️ Amaç

- Hyprland (Wayland) tabanlı bir modern masaüstü oluşturmak  
- GNOME yardımcı araçları ile sorunsuz GUI deneyimi sağlamak  
- Yazıcı, ses, bluetooth, ağ, güncelleme gibi sistem servislerini otomatik yapılandırmak  
- Flatpak ile yazılım mağazası desteği sunmak  
- ZRAM ve earlyoom ile bellek taşmalarına karşı önlem almak  
- Python, Java, Flatpak gibi geliştirme ve günlük kullanım araçlarını kurmak

---

## ⚙️ Gereksinimler

- Daha önceden kurulu, internet erişimi olan bir **minimal Arch Linux** sistemi  
- `sudo` yetkisine sahip bir kullanıcı  
- UEFI kurulum yapılmış bir sistem (mikrokod ve firmware desteği için önerilir)  

---

## 🔧 Kurulum

Script’i indirip çalıştır:

```bash
chmod +x install.sh
./modern-arch-setup.sh
