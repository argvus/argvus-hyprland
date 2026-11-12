---
title: Pintasan keyboard
description: Temukan pintasan yang disediakan oleh konfigurasi ARGVUS Hyprland.
---

Buka **Control Center → Desktop & Input → Keyboard Shortcuts**, atau jalankan `argvus control-center keybindings`.

## Apa yang dilakukan halaman

**Semua Pintasan** mencari dan mengelompokkan manifes pengikatan tombol aktif. Anda dapat memilih sebuah pengikatan, mengedit kombinasi tombolnya, menangkap kombinasi baru, mengaktifkan atau menonaktifkan pengikatan yang dapat dikonfigurasi, dan mengembalikan semua pintasan dari tindakan pemulihan halaman. Sebuah pintasan harus berisi tombol non-modifier; editor menormalkan nama-nama seperti Super/Win, Ctrl, Alt, Shift, panah, tombol fungsi, dan tombol media. `SUPER + Y` membuka **Pusat Kontrol → Tampilan → Wallpaper**.

Perubahan pintasan resmi disimpan di `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`, yang diwakili oleh `/keyboard_shortcuts` dalam model logis; fragmen Hyprland yang dihasilkan ditulis di bawah `~/.config/argvus/data/generated/hypr/`. Pintasan yang dinonaktifkan diwakili oleh `null`. Kunci adalah kunci konfigurasi bahasa Inggris yang stabil, independen dari lokal yang dipilih: ID manifes seperti `window.close` dipetakan ke `close_window`, sementara `window.drag_mouse` dipetakan ke `drag_window__floating_window_only`. Bagian `/hyprland/keybindings` lama dan `keybindings.toml` hanya untuk migrasi. ARGVUS menjadwalkan pemuatan ulang sesi hanya ketika rencana proyeksi melaporkan perubahan nyata.

**Buat Pintasan** membuat pintasan keyboard global secara independen dari manifest paket. Berikan deskripsi, tombol, dan baik perintah atau dispatcher Lua yang didukung (misalnya `window.float` dengan argumen JSON `{"action":"toggle"}`). **Buat** menyimpan dan menerapkannya, kemudian memilihnya di **Semua Pintasan → Pintasan Kustom**. Batal atau `Esc` membatalkan draf. Pembuatan dan penangkapan tidak mengeksekusi perintah.

Pintasan kustom dapat diedit, diaktifkan/dinonaktifkan, dan dihapus dengan konfirmasi. Konflik dengan pintasan yang diaktifkan dalam konteks yang sama memerlukan konfirmasi penggantian; binding yang dilindungi tidak dapat diganti. Mengembalikan default resmi akan mempertahankan catatan kustom. Jika pengembalian akan bertabrakan dengan pintasan kustom aktif, ubah atau nonaktifkan pintasan kustom tersebut terlebih dahulu. Definisi kustom disimpan di bawah `/hyprland/custom_shortcuts` dalam `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. `data/generated/hypr/custom-shortcuts.lua` yang dihasilkan dimuat dengan loader yang dilindungi yang ada; registrasi yang tidak valid dicatat tanpa menghentikan konfigurasi lainnya. Kegagalan penyimpanan mempertahankan draft; kegagalan aplikasi melaporkan bahwa catatan telah disimpan dan dapat dicoba kembali.

Jalankan `argvus control-center shortcuts create` atau `argvus control-center shortcuts list` untuk membuka salah satu halaman. Untuk submap lanjutan, pengikatan mouse atau bendera, [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) tetap tersedia. Jangan pernah mengedit fragmen yang dihasilkan.

## Referensi saat ini

Manifest dasar dan cheatsheets yang terpasang berada di bawah `/usr/share/argvus/hyprland/`. Override pengguna aktif bukanlah manifest pengganti: itu mengubah entri yang dipilih di Control Center. Inilah sebabnya mengapa daftar yang disalin secara manual dan spesifik versi dapat menjadi usang.

Beberapa aksi bawaan yang berguna meliputi memindahkan fokus dan ruang kerja, mengalihkan jendela mengambang, menangkap layar dan merekam, membuka peluncur/terminal, mengubah tampilan, mengunci sesi, mengontrol media, dan memuat ulang Hyprland. Binding default tercantum dalam [tabel pintasan default](#default-shortcut-table) di bawah ini; halaman Control Center menampilkan binding sebagaimana yang telah dikonfigurasi saat ini.

`SUPER + Shift + R` adalah pemuatan ulang runtime eksplisit: ini memuat ulang Hyprland dan memulai ulang taskbar ARGVUS, Panel Kontrol, dan layanan Telemetri Widget. Pemuatan ulang berbasis konfigurasi tetap bersyarat dan melewatkan pemuatan ulang grafis ketika keadaan kanonis tidak berubah.

## Tabel pintasan default

Tabel ini mencantumkan pengikatan dari manifest dasar (`/usr/share/argvus/hyprland/keybindings.json`) dengan tombol default mereka. Perubahan Anda sendiri di Control Center menggantikan tombol yang ditampilkan di sini untuk pengikatan yang terpengaruh, dan pengikatan yang dinonaktifkan tidak berjalan.

### Navigasi

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + Left Arrow` | Fokuskan jendela ubin berdasarkan arah |
| `SUPER + Right Arrow` | Fokuskan jendela ubin berdasarkan arah |
| `SUPER + Up Arrow` | Fokuskan jendela ubin berdasarkan arah |
| `SUPER + Down Arrow` | Fokuskan jendela ubin berdasarkan arah |
| `SUPER + CTRL + Left Arrow` | Fokus siklus antar jendela (ubin dan mengambang) |
| `SUPER + CTRL + Right Arrow` | Fokus siklus antar jendela (ubin dan mengambang) |

### Ruang kerja

| Pintasan | Deskripsi |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Perpindahan antar area kerja |
| `CTRL + ALT + Left Arrow` | Perpindahan antar area kerja |
| `Mouse extra button (mouse:276)` | Perpindahan antar area kerja |
| `Mouse side button (mouse:275)` | Perpindahan antar area kerja |
| `SUPER + 1` | Ruang Kerja 1 |
| `SUPER + 2` | Ruang Kerja 2 |
| `SUPER + 3` | Ruang Kerja 3 |
| `SUPER + 4` | Ruang Kerja 4 |
| `SUPER + 5` | Ruang Kerja 5 |
| `SUPER + 6` | Ruang Kerja 6 |
| `SUPER + 7` | Ruang Kerja 7 |
| `SUPER + 8` | Ruang Kerja 8 |
| `SUPER + 9` | Ruang Kerja 9 |
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | Membuka proyek di posisi itu dari `argvus projects` |
| `SUPER + Shift + 1` | Pindahkan jendela ke desktop 1 |
| `SUPER + Shift + 2` | Pindahkan jendela ke desktop 2 |
| `SUPER + Shift + 3` | Pindahkan jendela ke desktop 3 |
| `SUPER + Shift + 4` | Pindahkan jendela ke desktop 4 |
| `SUPER + Shift + 5` | Pindahkan jendela ke desktop 5 |
| `SUPER + Shift + 6` | Pindahkan jendela ke desktop 6 |
| `SUPER + Shift + 7` | Pindahkan jendela ke desktop 7 |
| `SUPER + Shift + 8` | Pindahkan jendela ke desktop 8 |
| `SUPER + Shift + 9` | Pindahkan jendela ke desktop 9 |

### jendela

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + S` | Maksimalkan jendela (alihkan) |
| `SUPER + Q` | Tutup jendela |
| `SUPER + Shift + Space` | Aktifkan/Nonaktifkan Jendela Mengambang |
| `SUPER + F` | Jendela layar penuh |
| `SUPER + E` | Pisahkan tombol vertikal/horizontal |
| `SUPER + W` | Kelompokkan/Pisahkan ke dalam tab |
| `SUPER + Tab` | Menavigasi antar tab |
| `SUPER + Shift + Left Arrow` | Pindahkan jendela |
| `SUPER + Shift + Right Arrow` | Pindahkan jendela |
| `SUPER + Shift + Up Arrow` | Pindahkan jendela |
| `SUPER + Shift + Down Arrow` | Pindahkan jendela |
| `SUPER + Left mouse button (mouse:272)` | Tarik jendela (hanya jendela mengambang) |
| `SUPER + Right mouse button (mouse:273)` | Mode pengubahan ukuran jendela (hanya jendela mengambang) |
| `SUPER + R` | Masuk ke mode pengubahan ukuran jendela (hanya jendela mengambang) |

### Aplikasi

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + Enter` | Terminal |
| `SUPER + [` | Catatan tempel terminal (menu tarik-turun di ruang kerja khusus; tekan lagi untuk menyembunyikan) |
| `SUPER + Space` | Manajer File |
| `SUPER + CTRL + Space` | Pemantau sistem |
| `SUPER + Shift + D` | Menu perangkat yang dapat dilepas |
| `SUPER + Shift + F` | Fokus ARGVUS (Pomodoro dan sesi fokus) |
| `SUPER + Shift + C` | ARGVUS Jam (jam, timer dan alarm) |
| `SUPER + D` | Peluncur Program |
| `SUPER + B` | Peramban Bawaan |
| `SUPER + C` | Kalkulator |
| `SUPER + ALT + S` | Pemilih host SSH (`argvus ssh`) |
| `SUPER + ALT + N` | Pemilih cuplikan (`argvus snippets`) |
| `SUPER + ALT + G`| Pemilih proyek, lalu git TUI (lazygit atau gitui) di proyek yang dipilih (`argvus git`) |

### Media

| Pintasan | Deskripsi |
| --- | --- |
| `XF86AudioRaiseVolume` | Naikkan volume |
| `Volume Down` | Volume turun |
| `Mute` | Bisukan |
| `Brightness Up` | Kecerahan |
| `Brightness Down` | Kecerahan turun |
| `Play/Pause` | Putar/Jeda |
| `Next Track` | Lagu berikutnya |
| `Previous Track` | Lagu sebelumnya |
| `Stop` | Hentikan jalur |

### Tangkapan layar dan perekaman

| Pintasan | Deskripsi |
| --- | --- |
| `Print` | Tangkap area yang dipilih |
| `SUPER + Print` | Tangkap jendela terfokus |
| `SUPER + Shift + Print` | Tangkap seluruh layar |
| `SUPER + G` | Perekaman layar Start/Pause/Resume |
| `SUPER + Shift + G` | Hentikan dan simpan rekaman layar |

### Sesi

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + L` | Sistem kunci |
| `SUPER + escape` | Keluar dari sistem |
| `SUPER + Shift + R` | Muat ulang Hyprland |
| `SUPER + Shift + S` | Mematikan/menghidupkan monitor (bukan menangguhkan sistem) |
| `SUPER + Shift + L` | Pilih batas waktu penguncian ketidakaktifan |
| `SUPER + ALT + W` | Alihkan Tetap Terjaga |

### Sistem

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + Shift + /` | Lembar Cheat Hyprland |
| `SUPER + CTRL + /` | Lembar Curang Kitty |
| `SUPER + F1` | Buka Tentang ARGVUS |
| `SUPER + ALT + C` | Buka Pusat Kontrol |
| `SUPER + P` | Pemilih Warna |
| `SUPER + .` | Pemilih Emoji |
| `SUPER + H` | Riwayat Papan Klip |
| `SUPER + Shift + H` | Hapus Riwayat Papan Klip |

### Widget

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + ,` | Buka/Tutup sidebar notifikasi |
| `Middle mouse button (mouse:274)` | Buka/Tutup sidebar notifikasi |
| `SUPER + Backspace` | Alihkan Waybar atas |
| `SUPER + Shift + W` | Konfigurasikan lokasi cuaca |
| `SUPER + ALT + Up Arrow` | Pindahkan bilah tugas ke atas |
| `SUPER + ALT + Down Arrow` | Pindahkan bilah tugas ke bawah |

### Penampilan

| Pintasan | Deskripsi |
| --- | --- |
| `SUPER + Y` | Buka wallpaper Pusat Kontrol |
| `SUPER + Shift + T` | Buka pemilih tema |
| `SUPER + Shift + M` | Buka pemilih mode Lengket/Spasi |
| `SUPER + F5` | Beralih antara tema ARGVUS Dark dan ARGVUS Light |
| `SUPER + F6` | Beralih animasi |
| `SUPER + Shift + B` | Buka pemilih kecerahan dan tombol Lampu Malam |

### Mode ubah ukuran (setelah SUPER + R)

Shortcut ini hanya berfungsi saat mode ubah ukuran aktif. `Esc` atau `Enter` keluar dari mode.

| Pintasan | Deskripsi |
| --- | --- |
| `Right Arrow` | Ubah ukuran |
| `Left Arrow` | Ubah ukuran |
| `Up Arrow` | Ubah ukuran |
| `Down Arrow` | Ubah ukuran |
| `Shift + Right Arrow` | Pindahkan jendela |
| `Shift + Left Arrow` | Pindahkan jendela |
| `Shift + Up Arrow` | Pindahkan jendela |
| `Shift + Down Arrow` | Pindahkan jendela |
| `escape` | Keluar dari mode pengubahan ukuran |
| `Enter` | Keluar dari mode pengubahan ukuran |


Lihat [Windows dan tata letak](/docs/argvus-hyprland/windows-and-layout/) untuk perilaku jendela melayang dan area kerja serta [Pusat Kontrol](/docs/components/argvus-control-center/) untuk alur kerja pengaturan.

## Cahaya Malam

**SUPER + Shift + B** mempertahankan aksi `appearance.brightness` dalam manifes keybinding kanonik. Menu kecerahan Rofi-nya juga menawarkan Night Light saat Hyprsunset tersedia. Konfigurasikan suhu (1000–20000 K) dan waktu mulai/berakhir lokal di **Control Center > Desktop & Input > Displays > Night Light**. Aksi cepat ini menggunakan CLI bersama dan tidak memuat ulang Hyprland atau mengubah Lua yang dihasilkan.


Dengan paket argvus-ai opsional yang terpasang, SUPER + A membuka menu agen AI. Binding ini menghormati pengaturan ulang pengguna app.ai dan hilang setelah paket dihapus dan kompositor dimuat ulang. Hingga dimuat ulang, tindakan yang dijaga tidak aktif.


Paket argvus-ai opsional memiliki /usr/share/argvus/ai/hyprland.lua. Hyprland memuatnya dengan aman sebelum pengguna melakukan override; menghapus modul ini menghapus ikatannya saat dimuat ulang. Paket Hyprland menyediakan hook Pacman yang hanya menyentuh stempel waktu konfigurasi sistem setelah instalasi/upgrade/penghapusan modul, memicu autoreload bawaan. Jika autoreload dinonaktifkan atau konfigurasi root pengguna terpisah digunakan, muat ulang konfigurasi tersebut secara eksplisit. Katalog Control Center menyertakan app.ai dengan kunci default dan label lokal yang sama; ikatan tetap tidak aktif tanpa modul opsional.


## Paket terminal

Kunci ini berlaku di dalam **Control Center > System Administration > Packages**, bukan secara global untuk Hyprland. `F8` membuka kembali terminal transaksi, `Esc` menyembunyikannya tanpa menghentikan proses, `Shift+PageUp/PageDown` menggulir riwayat, `Shift+End` kembali ke output langsung, dan `Ctrl+C` menghentikan anak yang sedang fokus. Cheat sheet yang terpasang mencakup kunci yang sama.

Di Paket, `/` memfokuskan bilah **Cari** atas. `Enter` di sana mengirimkan pencarian instalasi Official/AUR; daftar penghapusan dan pembaruan memfilter saat Anda mengetik. `Down` pindah ke hasil, `Up` pada hasil pertama kembali ke Cari, dan `Esc` di Cari mempertahankan kueri dan kembali ke daftar. Tekan Enter pada hasil menjalankan aksi paketnya.
