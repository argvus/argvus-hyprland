---
title: Keyboard shortcuts
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

### Navigation

| Shortcut | Description |
| --- | --- |
| `SUPER + Left Arrow` | Focus tiled window by direction |
| `SUPER + Right Arrow` | Focus tiled window by direction |
| `SUPER + Up Arrow` | Focus tiled window by direction |
| `SUPER + Down Arrow` | Focus tiled window by direction |
| `SUPER + CTRL + Left Arrow` | Cycle focus between windows (tiled and floating) |
| `SUPER + CTRL + Right Arrow` | Cycle focus between windows (tiled and floating) |

### Workspaces

| Shortcut | Description |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Moving between work areas |
| `CTRL + ALT + Left Arrow` | Moving between work areas |
| `Mouse extra button (mouse:276)` | Moving between work areas |
| `Mouse side button (mouse:275)` | Moving between work areas |
| `SUPER + 1` | Workspace 1 |
| `SUPER + 2` | Workspace 2 |
| `SUPER + 3` | Workspace 3 |
| `SUPER + 4` | Workspace 4 |
| `SUPER + 5` | Workspace 5 |
| `SUPER + 6` | Workspace 6 |
| `SUPER + 7` | Workspace 7 |
| `SUPER + 8` | Workspace 8 |
| `SUPER + 9` | Workspace 9 |
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | Membuka proyek di posisi itu dari `argvus projects` |
| `SUPER + Shift + 1` | Move window to desktop 1 |
| `SUPER + Shift + 2` | Move window to desktop 2 |
| `SUPER + Shift + 3` | Move window to desktop 3 |
| `SUPER + Shift + 4` | Move window to desktop 4 |
| `SUPER + Shift + 5` | Move window to desktop 5 |
| `SUPER + Shift + 6` | Move window to desktop 6 |
| `SUPER + Shift + 7` | Move window to desktop 7 |
| `SUPER + Shift + 8` | Move window to desktop 8 |
| `SUPER + Shift + 9` | Move window to desktop 9 |

### Windows

| Shortcut | Description |
| --- | --- |
| `SUPER + S` | Maximize window (toggle) |
| `SUPER + Q` | Close window |
| `SUPER + Shift + Space` | Enable/Disable Floating Window |
| `SUPER + F` | Full screen window |
| `SUPER + E` | Split vertical/horizontal toggle |
| `SUPER + W` | Group/Ungroup into tabs |
| `SUPER + Tab` | Navigate between tabs |
| `SUPER + Shift + Left Arrow` | Move window |
| `SUPER + Shift + Right Arrow` | Move window |
| `SUPER + Shift + Up Arrow` | Move window |
| `SUPER + Shift + Down Arrow` | Move window |
| `SUPER + Left mouse button (mouse:272)` | Drag window (floating window only) |
| `SUPER + Right mouse button (mouse:273)` | Window resize mode (floating window only) |
| `SUPER + R` | Enter window resize mode (floating window only) |

### Applications

| Shortcut | Description |
| --- | --- |
| `SUPER + Enter` | Terminal |
| `SUPER + [` | Catatan tempel terminal (menu tarik-turun di ruang kerja khusus; tekan lagi untuk menyembunyikan) |
| `SUPER + Space` | File Manager |
| `SUPER + CTRL + Space` | System monitor |
| `SUPER + Shift + D` | Removable devices menu |
| `SUPER + Shift + F` | ARGVUS Focus (Pomodoro and focus sessions) |
| `SUPER + Shift + C` | ARGVUS Clock (clock, timers and alarms) |
| `SUPER + D` | Program Launcher |
| `SUPER + B` | Default Browser |
| `SUPER + C` | Calculator |
| `SUPER + ALT + S` | SSH host picker (`argvus ssh`) |
| `SUPER + ALT + N` | Snippet picker (`argvus snippets`) |
| `SUPER + ALT + G`| Pemilih proyek, lalu git TUI (lazygit atau gitui) di proyek yang dipilih (`argvus git`) |

### Media

| Shortcut | Description |
| --- | --- |
| `XF86AudioRaiseVolume` | Volume up |
| `Volume Down` | Volume down |
| `Mute` | Mute |
| `Brightness Up` | Brightness up |
| `Brightness Down` | Brightness down |
| `Play/Pause` | Play/Pause |
| `Next Track` | Next track |
| `Previous Track` | Previous track |
| `Stop` | Stop track |

### Tangkapan layar dan perekaman

| Shortcut | Description |
| --- | --- |
| `Print` | Capture selected area |
| `SUPER + Print` | Capture focused window |
| `SUPER + Shift + Print` | Capture entire screen |
| `SUPER + G` | Start/Pause/Resume screen recording |
| `SUPER + Shift + G` | Stop and save screen recording |

### Session

| Shortcut | Description |
| --- | --- |
| `SUPER + L` | Lock system |
| `SUPER + escape` | Exit system |
| `SUPER + Shift + R` | Reload Hyprland |
| `SUPER + Shift + S` | Turn monitor off/on (not suspend system) |
| `SUPER + Shift + L` | Choose inactivity lock timeout |
| `SUPER + ALT + W` | Toggle Keep Awake |

### System

| Shortcut | Description |
| --- | --- |
| `SUPER + Shift + /` | Hyprland Cheatsheets |
| `SUPER + CTRL + /` | Kitty Cheatsheets |
| `SUPER + F1` | Open About ARGVUS |
| `SUPER + ALT + C` | Open Control Center |
| `SUPER + P` | Color Picker |
| `SUPER + .` | Emoji Picker |
| `SUPER + H` | Clipboard History |
| `SUPER + Shift + H` | Clear Clipboard History |

### Widgets

| Shortcut | Description |
| --- | --- |
| `SUPER + ,` | Open/Close notification sidebar |
| `Middle mouse button (mouse:274)` | Open/Close notification sidebar |
| `SUPER + Backspace` | Toggle Waybar top |
| `SUPER + Shift + W` | Configure weather location |
| `SUPER + ALT + Up Arrow` | Move taskbar to top |
| `SUPER + ALT + Down Arrow` | Move taskbar to bottom |

### Appearance

| Shortcut | Description |
| --- | --- |
| `SUPER + Y` | Open Control Center wallpapers |
| `SUPER + Shift + T` | Open theme selector |
| `SUPER + Shift + M` | Open Sticky/Spaced mode picker |
| `SUPER + F5` | Beralih antara tema ARGVUS Dark dan ARGVUS Light |
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector and Night Light toggle |

### Mode ubah ukuran (setelah SUPER + R)

Shortcut ini hanya berfungsi saat mode ubah ukuran aktif. `Esc` atau `Enter` keluar dari mode.

| Shortcut | Description |
| --- | --- |
| `Right Arrow` | Resize |
| `Left Arrow` | Resize |
| `Up Arrow` | Resize |
| `Down Arrow` | Resize |
| `Shift + Right Arrow` | Move window |
| `Shift + Left Arrow` | Move window |
| `Shift + Up Arrow` | Move window |
| `Shift + Down Arrow` | Move window |
| `escape` | Exit resize mode |
| `Enter` | Exit resize mode |


Lihat [Windows dan tata letak](/docs/argvus-hyprland/windows-and-layout/) untuk perilaku jendela melayang dan area kerja serta [Pusat Kontrol](/docs/components/argvus-control-center/) untuk alur kerja pengaturan.

## Cahaya Malam

**SUPER + Shift + B** mempertahankan aksi `appearance.brightness` dalam manifes keybinding kanonik. Menu kecerahan Rofi-nya juga menawarkan Night Light saat Hyprsunset tersedia. Konfigurasikan suhu (1000–20000 K) dan waktu mulai/berakhir lokal di **Control Center > Desktop & Input > Displays > Night Light**. Aksi cepat ini menggunakan CLI bersama dan tidak memuat ulang Hyprland atau mengubah Lua yang dihasilkan.


Dengan paket argvus-ai opsional yang terpasang, SUPER + A membuka menu agen AI. Binding ini menghormati pengaturan ulang pengguna app.ai dan hilang setelah paket dihapus dan kompositor dimuat ulang. Hingga dimuat ulang, tindakan yang dijaga tidak aktif.


Paket argvus-ai opsional memiliki /usr/share/argvus/ai/hyprland.lua. Hyprland memuatnya dengan aman sebelum pengguna melakukan override; menghapus modul ini menghapus ikatannya saat dimuat ulang. Paket Hyprland menyediakan hook Pacman yang hanya menyentuh stempel waktu konfigurasi sistem setelah instalasi/upgrade/penghapusan modul, memicu autoreload bawaan. Jika autoreload dinonaktifkan atau konfigurasi root pengguna terpisah digunakan, muat ulang konfigurasi tersebut secara eksplisit. Katalog Control Center menyertakan app.ai dengan kunci default dan label lokal yang sama; ikatan tetap tidak aktif tanpa modul opsional.


## Paket terminal

Kunci ini berlaku di dalam **Control Center > System Administration > Packages**, bukan secara global untuk Hyprland. `F8` membuka kembali terminal transaksi, `Esc` menyembunyikannya tanpa menghentikan proses, `Shift+PageUp/PageDown` menggulir riwayat, `Shift+End` kembali ke output langsung, dan `Ctrl+C` menghentikan anak yang sedang fokus. Cheat sheet yang terpasang mencakup kunci yang sama.

Di Paket, `/` memfokuskan bilah **Cari** atas. `Enter` di sana mengirimkan pencarian instalasi Official/AUR; daftar penghapusan dan pembaruan memfilter saat Anda mengetik. `Down` pindah ke hasil, `Up` pada hasil pertama kembali ke Cari, dan `Esc` di Cari mempertahankan kueri dan kembali ke daftar. Tekan Enter pada hasil menjalankan aksi paketnya.
