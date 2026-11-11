---
title: Windows and layout
description: Pahami celah, batas, mode, dan ruang panel di ARGVUS.
---

ARGVUS menggunakan Hyprland untuk penempatan jendela terpetak dan mengambang. Kontrol tata letak yang dapat diakses pengguna berada di tiga halaman Control Center: **Control Center → Appearance → Taskbar** (posisi, ruang, dan ikon), **Control Center → Desktop & Input → Hyprland → Windows → Spaces** dan **Control Center → Desktop & Input → Hyprland → Borders**.

## Konsep

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```

- **Celah jendela** adalah ruang di antara jendela yang ditata dan tepi luar dari tata letak yang ditata.
- **Spasi taskbar atau shell** adalah margin di sekitar permukaan desktop seperti taskbar dan panel. Nilainya tidak sama dengan celah jendela.
- **Tepi** adalah batas yang terlihat di sekitar jendela. **Ketebalan tepi** mengontrol lebar batas yang ditampilkan oleh halaman tampilan.
- **Pembulatan** adalah bagian dari mode visual yang dipilih. Ini mengubah bentuk sudut jendela daripada memindahkan jendela.
- **Reservasi panel dan margin yang terlihat** adalah hal yang terpisah: sebuah panel dapat menempati atau menggunakan ruang secara visual sementara Hyprland masih menata jendela sesuai dengan status spasi aktif.

## Mode Sticky dan Spaced

Mode tema bawaan menyediakan dua geometri awal:

| Mode | Window behavior | Surface treatment |
| --- | --- | --- |
| Lengket | Celah internal `2`, celah luar `0`secara default | Persegi, kompak dan dekat dengan tepi layar |
| Berjarak | Celah internal `10`, celah luar `18`secara default | Membulat, berbentuk bayangan dan lebih luas; batas taskbar/shell default ke`18` |

Ini adalah default, bukan batas. Halaman ruang Jendela dan ruang Taskbar dapat menyimpan celah jendela dan margin taskbar secara independen. Mengubah tema atau mode dapat menghasilkan nilai tata letak efektif yang berbeda.

## Kontrol Tata Letak

Setiap kontrol bersifat independen dan berada di halaman yang tercantum di sini:

- **Taskbar → Posisi** — posisi taskbar, tepi atas atau bawah.
- **Bilah Tugas → Ruang** — bilah tugas atas, kiri, kanan, dan bawah, masing-masing dari `0` hingga `100`. Sticky mengatur default margin bawah ke `2`; Spaced menggunakan `18`.
- **Bilah Tugas → Ikon** — apakah grup utilitas bilah tugas menggunakan perilaku otomatis atau selalu diperluas.
- **Hyprland → Windows → Spaces** — celah dalam dan celah luar atas/kiri/kanan/bawah, masing-masing dari `0` ke `100`.
- **Hyprland → Borders** — batas umum: aktifkan sudut membulat; ketika diaktifkan, pembulatan dapat dipilih dari `2` ke `10`. Ketebalan tepi juga diatur di sini, dari `0` ke `10`.
- **Hyprland → Borders → Shadow** — bayangan jendela, mati secara default. Ini mengatur jangkauan, daya render, sudut tajam, offset dan skala, dan warnanya mengikuti aksen tema dengan alpha `99` kecuali jika warna diketik.

Nilai-nilai ini dituliskan ke status tampilan ARGVUS, dan `argvus-config` memproyeksikannya ke dalam file Hyprland yang dihasilkan yang kemudian diterapkan oleh sesi. Margin taskbar mengubah posisi permukaan shell; celah jendela luar mengubah area jendela yang ditile. Keduanya dapat menghasilkan jarak visual yang serupa, tetapi mengubah satu tidak mengubah yang lain.

## Jendela dan ruang kerja


Konfigurasi yang dikemas membuka Control Center, Snake, dan Disk Usage Analyzer sebagai jendela melayang yang terpusat. Disk Usage Analyzer menggunakan geometri awal  `SUPER + SHIFT + Space` `1399 × 920` yang sama seperti popup memori taskbar, diterapkan oleh aturan kelas jendelanya ketika jendela dibuka. ARGVUS Focus dan ARGVUS Clock adalah popup GTK layer-shell yang ditempatkan di samping taskbar, jadi mereka bukan jendela yang ditata dan tidak menggunakan aturan jendela Hyprland. Kartu alarm Clock adalah permukaan layer terpisah (`argvus-clock-alarm`).

Panel Kontrol menggunakan permukaan lapisan layar penuh saat modalnya terbuka. Aturan yang dikemas mengapung, memusatkan dan menyematkan jendela agen Polkit, portal GTK, dan KDialog sehingga dialog yang diluncurkan oleh panel tetap di atas modal dan dapat menerima input.

`hyprpicker`, dibuka dengan `SUPER + P`, tidak menggunakan animasi Hyprland. Pengecualian ini hanya memengaruhi pemilih warna; animasi lain tetap mengikuti pengaturan global.

### Penempatan workspace untuk browser dan IDE

Tidak ada aturan jendela yang ditentukan secara default pada instalasi baru. Anda dapat menambahkan aturan penempatan workspace per-aplikasi sendiri di bawah `hyprland.window_rules` dalam `argvus-config`, misalnya:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Setiap aturan memiliki `workspace` dari 1 sampai 10 dan daftar `classes`. Entri di `classes` adalah ekspresi reguler yang dicocokkan dengan kelas jendela (peka huruf besar/kecil), misalnya `[Cc]ode.*` atau `jetbrains-.*`. Hanya huruf, angka, dan `._*+?-[]()|^$` yang diterima. `argvus-config` menulis aturan ke `generated/hypr/window-rules.lua`, yang dimuat oleh konfigurasi Hyprland. Untuk mengganti aturan tanpa mengubah pengaturan default, tambahkan `hl.window_rule` panggilan ke `rules.lua` di direktori data ARGVUS Anda; itu dimuat setelah aturan yang dihasilkan.

## Apa yang harus diubah pertama

- Jika jendela terasa sesak, tingkatkan jarak antar jendela atau gunakan mode Berjarak.
- Jika jendela terlihat terlalu jauh dari tepi layar, kurangi jarak luar/taskbar atau gunakan mode Lengket.
- Jika taskbar tampak tidak selaras setelah mengubah posisinya, tinjau posisi taskbar dan semua empat margin taskbar/shell secara bersamaan.
- Jika jendela saling menutupi panel visual, periksa pengaturan tata letak panel dan bilah tugas sebelum mengubah jarak jendela.

Perubahan diterapkan melalui integrasi tampilan/sesi ARGVUS. Gunakan tindakan reset pada halaman jika tersedia; jangan mengedit file Hyprland yang dihasilkan secara langsung.

## Related


## Goyangan jendela

Buka **Desktop & Input → Hyprland → Animations → Windows** dan gunakan
kontrol **Goyang**. Cari `wobble`, atau buka halaman secara langsung:

```sh
argvus control-center hyprland animations windows
```

Wobble dinonaktifkan secara default. Nilai default ARGVUS-nya adalah kekakuan `100`, redaman
`10`, massa `1`, intensitas `1` dan resolusi mesh `8`. Kekakuan dan massa menerima
`0.0001–1000`, redaman `0–1000`, intensitas `0–2`, dan mesh sebuah bilangan bulat `2–32`.
Resolusi mesh yang lebih tinggi meningkatkan biaya rendering. Gunakan tombol panah untuk menyesuaikan nilai
atau tekan Enter untuk mengetiknya. **Kembalikan default Wobble** mengubah draf;
**Terapkan** menyimpan semua editan animasi yang tertunda dan memuat ulang Hyprland sekali, tanpa
memulai ulang sesi. Kembali dalam Animasi mempertahankan draf yang dibagikan.

Sakelar Animasi global menekan Wobble sambil mempertahankan pengaturan
individualnya. Nilai kanonik berada di bawah `effects.wobble_*` dalam keadaan ARGVUS;
`hypr/state.lua` dihasilkan dan tidak boleh diedit secara manual.

Ini memerlukan Hyprland **0.57.0 atau lebih baru**, ditegakkan oleh `argvus-hyprland`'s
ketergantungan paket. Versi 0.56 tidak didukung untuk konfigurasi ini. Maksimum intensitas
yang membatasinya hingga `2`, meskipun dokumentasi baru mungkin mencantumkan `3`. Mode jendela global

## 

Buka **Control Center → Desktop & Input → Hyprland → Windows → Mode** dan pilih **Tile Windows (Default)** atau **Floating Windows**. Pemilih yang sama tersedia dari ikon mode-jendela di grup utilitas taskbar.

Preferensi ini berlaku untuk setiap monitor dan ruang kerja serta diingat setelah logout. Floating mengubah jendela aplikasi yang sudah ada dan jendela yang baru dibuka. Tile hanya mengembalikan jendela yang diubah oleh kebijakan ini; dialog dan jendela lain yang sudah dalam posisi mengambang tetap mengambang. Jendela yang secara eksplisit dipasang saat Floating aktif juga tetap mengambang untuk menjaga pemasangannya. Tata letak tiled dihitung ulang; pohon pembagian sebelumnya yang tepat tidak dikembalikan.

`SUPER + SHIFT + Space` mempertahankan perilaku per-jendela normalnya di Tile. Dalam Floating, itu tidak mengembalikan jendela ke tiling. Panel, taskbar, dan notifikasi adalah permukaan layer-shell dan tidak terpengaruh. Layar penuh terus menggunakan perilaku normal Hyprland; maksimisasi ARGVUS mempertahankan margin di Spaced.

Preferensi kanonik adalah `/hyprland/window_mode` di `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Proyeksi yang dihasilkannya adalah `data/generated/hypr/window-mode.lua`; jangan mengeditnya. Registri pemulihan per-jendela berada di bawah `$XDG_RUNTIME_DIR/argvus`, dibatasi pada instance kompositor, dan tetap ada saat konfigurasi dimuat ulang. Itu tidak digunakan kembali di sesi baru.

Jika aplikasi sedang menunggu atau gagal, antarmuka membedakan ini dari preferensi yang disimpan. Pilih opsi lagi untuk mencoba kembali. Tanpa compositor, preferensi disimpan untuk login berikutnya.

## Tombol jendela dan bilah aplikasi

Mode mengambang menambahkan bilah judul ARGVUS dengan **Perkecil**, **Perbesar / Pulihkan**, dan **Tutup** pada jendela aplikasi normal. Klik ganda pada bilah judul akan mengubah status perbesaran. Dekorasi tambahan ini disembunyikan pada mode Tile dan layar penuh. Aplikasi yang menampilkan kontrolnya sendiri mungkin menampilkan kedua bilah; kontrol ARGVUS yang seragam adalah sengaja.

Sebuah Waybar kedua muncul di setiap monitor, di sisi yang berlawanan dengan taskbar utama. Bar ini hanya menampilkan jendela dari workspace saat ini pada monitor tersebut, termasuk jendela yang diminimalkan. Tab grup yang disembunyikan tidak membuat entri tambahan. Entri yang diminimalkan tetap mempertahankan asosiasi monitor/workspace aslinya. Klik jendela yang tidak aktif untuk mengaktifkannya, jendela yang aktif untuk meminimalkannya, atau jendela yang diminimalkan untuk mengembalikannya; menu konteksnya menawarkan opsi kembalikan, minimalkan, maksimalkan/kembalikan dan tutup. Ikon aplikasi yang tidak dikenal digantikan dengan simbol jendela. Mengaktifkan atau mengembalikan sebuah entri mempertahankan posisi penunjuk. Bar sekunder menggunakan CSS utama yang efektif (warna, font, border, dan pembulatan), dengan tinggi dan margin yang tercermin di sisi yang berlawanan.

`SUPER + Alt + Up` menempatkan bilah utama di atas dan bilah jendela di bawah. `SUPER + Alt + Down` melakukan sebaliknya. Mengulangi suatu arah tidak mengubah posisi. Tile hanya memiliki bilah utama. Kembali ke Tile memulihkan semua jendela yang diminimalkan sebelum menghapus bilah jendela, dan kemudian mempertahankan kebijakan tile/floating asli.

Minimisasi menggunakan workspace cadangan `special:argvus-minimized`. Jangan gunakan workspace itu secara manual. Proses `argvus windows service` mencatat identitas, workspace/monitor asli, geometri, layar penuh/maksimalisasi, dan status pin dalam registry runtime spesifik-instansi compositor di bawah `$XDG_RUNTIME_DIR/argvus`. Catatan tetap ada saat layanan dimulai ulang atau konfigurasi dimuat ulang, tetapi tidak melintasi sesi compositor. Menutup jendela menghapus catatannya. Jika sebuah monitor hilang, pemulihan menggunakan output yang tersedia. Bar pemulihan yang hilang atau gagal mencegah minimisasi baru; pemulihan yang gagal mempertahankan catatan dan bar pemulihan.

Sesi memiliki `argvus-windows.service` dan `argvus-window-bar.service`. Yang terakhir menjaga child Waybar-nya tetap dorman di Tile. Plugin hyprbars dibundel oleh `argvus-hyprland`, dibuat untuk Hyprland 0.57.0 ABI di x86_64; itu tidak dikompilasi di direktori home pengguna. Bangun ulang plugin dengan pembaruan ABI compositor.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, dan `minimize|restore|activate|maximize|close ADDRESS`. Alamat jendela berasal dari daftar. `position top --persist` menyimpan/memproyeksikan preferensi tanpa memulai ulang bilah utama. Detail konfigurasi dan kesalahan runtime dicatat di jurnal; kegagalan tindakan yang terlihat juga menampilkan notifikasi yang diterjemahkan.

Dalam **Spaced + Floating**, jendela menghormati celah luar dan area yang dicadangkan oleh kedua bilah. Batas mencakup border dan judul, yang berada di dalam border jendela yang sama. Memaksimalkan melalui kontrol ARGVUS mengisi area ini dengan margin; memulihkan mengembalikan geometri sebelumnya, termasuk setelah restart layanan. Layar penuh tetap menggunakan seluruh output. Jendela mengambang bisa saling tumpang tindih; celah dalam pada tiling tidak memisahkan mereka.

`SUPER + Alt + Space` mengalihkan mode Tile/Floating global, menggunakan preferensi yang sama seperti taskbar dan Control Center. Perintah yang setara adalah `argvus config window-mode toggle`. Pemanggilan bersamaan dijalankan secara berurutan; pengalihan menggunakan preferensi yang tersimpan walaupun aplikasi sedang menunggu. Pintasan dapat diubah atau dinonaktifkan di Pintasan Keyboard; `SUPER + Shift + Space` mempertahankan aksi jendela individualnya.

Each rule has a workspace from 1 to 10 and a classes list. Entries in classes are regular expressions matched against the window class (case sensitive), for example [Cc]ode.* or jetbrains-.*. Only letters, digits and ._*+?-|^$ are accepted. argvus-config writes the rules to generated/hypr/window-rules.lua, which the Hyprland configuration loads. To replace the rules without changing the defaults, add hl.window_rule calls to rules.lua in your ARGVUS data directory; those load after the generated rules.
untuk jalur yang terpasang dan pengguna. for the installed and user paths.(https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),

Tiled windows are arranged by Hyprland on the active workspace. ARGVUS also supports floating utility windows; SUPER + SHIFT + Space toggles the focused window between tiled and floating layouts. Workspace movement and window focus are controlled by the active keybinding manifest; see [Keyboard shortcuts](/docs/argvus-hyprland/keyboard-shortcuts/).
- [Penampilan](/docs/user-guide/appearance/)
- [Tema](/docs/user-guide/appearance/)
- [Bilah tugas](/docs/argvus-taskbar/taskbar/)
- [Panel Kontrol](/docs/argvus-control-panel/)
intensitas maksimum mengikuti [rilis sumber 0.57.0](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
