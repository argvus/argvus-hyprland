---
title: Mouse dan touchpad
description: Konfigurasikan perilaku penunjuk dan touchpad di ARGVUS.
---

Buka **Control Center → Locale & Region → Mouse & Touchpad**, atau jalankan `argvus control-center input`.

## Tikus

Ketika seekor tikus terdeteksi, halaman menampilkan:

- sensitivitas dari `-1.0` hingga `1.0`;
- profil percepatan adaptif atau datar;
- faktor gulir dari `0.1` ke `10.0`;
- pengguliran alami;
- tata letak tombol untuk kidal.

Sensitivitas, faktor gulir, dan sakelar diterapkan melalui Hyprland saat halaman terbuka, kemudian seluruh kondisi input disimpan. Halaman membaca nilai compositor saat ini ketika tidak ada file input ARGVUS.

## Panel sentuh

Ketika sebuah touchpad terdeteksi, halaman menampilkan scroll alami, ketuk untuk klik, ketuk-dan-seret, klik kanan dua jari dan nonaktif saat mengetik. Opsi-opsi ini hanya ditampilkan sebagai kontrol yang berguna ketika sesi yang berjalan melaporkan sebuah touchpad.

## Kontrol tergantung perangkat keras

Kontrol mouse lanjutan yang didukung oleh `ratbag` hanya ditampilkan untuk perangkat yang didukung. ARGVUS tidak mengklaim bahwa setiap mouse mendukung perubahan DPI, profil, atau polling. Jika sebuah perangkat tidak terdeteksi atau layanan perangkat opsional tidak tersedia, kontrol tersebut tidak dapat diterapkan oleh halaman ini.

## Ketahanan dan pengaturan ulang

Pengaturan disimpan sebagai status pengguna dan fragmen input Hyprland yang dihasilkan dibuat ulang untuk sesi tersebut. Gunakan tindakan reset pada halaman saat tersedia; jangan mengedit fragmen yang dihasilkan secara langsung. Sebuah pengaturan hanya dapat berlaku untuk compositor saat ini ketika sesi tidak dapat memuat ulang status perangkat yang relevan.

Lihat jalur yang diinstal dan jalur pengguna.(/docs/components/argvus-control-center/) serta jalur yang diinstal dan pengguna.(/docs/user-guide/where-to-configure/).

Lihat [Pusat Kontrol](/docs/components/argvus-control-center/)dan [Di mana mengonfigurasi hal-hal](/docs/user-guide/where-to-configure/).
