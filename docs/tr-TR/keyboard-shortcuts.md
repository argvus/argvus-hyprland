---
title: Keyboard shortcuts
description: ARGVUS Hyprland yapılandırması tarafından sağlanan kısayolları bulun.
---

**Kontrol Merkezi → Masaüstü ve Girdi → Klavye Kısayolları** öğesini açın veya `argvus control-center keybindings` çalıştırın.

## Sayfanın yaptığı şey

**Tüm Kısayollar** aktif tuş atama manifestosunu arar ve gruplar. Bir atamayı seçebilir, tuş kombinasyonunu düzenleyebilir, yeni bir kombinasyon yakalayabilir, yapılandırılabilir bir atamayı etkinleştirebilir veya devre dışı bırakabilir ve sayfanın geri yükleme işlemiyle tüm kısayolları geri yükleyebilirsiniz. Bir kısayol, değiştirici olmayan bir tuş içermelidir; editör Super/Win, Ctrl, Alt, Shift, ok tuşları, fonksiyon tuşları ve medya tuşları gibi isimleri normalleştirir. `SUPER + Y` **Kontrol Merkezi → Görünüm → Duvar Kağıtları** öğesini açar.

Resmî kısayol değişiklikleri `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json` içinde saklanır, mantıksal modelde `/keyboard_shortcuts` ile temsil edilir; oluşturulan Hyprland parçası `~/.config/argvus/data/generated/hypr/` altında yazılır. Devre dışı bırakılmış bir kısayol `null` ile temsil edilir. Tuşlar, seçilen yerel ayardan bağımsız olarak sabit İngilizce yapılandırma tuşlarıdır: `window.close` gibi bir manifest ID, `close_window` ile eşleştirilirken, `window.drag_mouse` `drag_window__floating_window_only` ile eşleştirilir. Eski `/hyprland/keybindings` bölümü ve `keybindings.toml` yalnızca geçiş içindir. ARGVUS, yalnızca projeksiyon planı gerçek bir değişiklik bildirdiğinde bir oturum yeniden yüklemesini planlar.

**Kısayollar Oluştur**, paketlenmiş manifestten bağımsız olarak bir global klavye kısayolu oluşturur. Bir açıklama, tuşlar ve ya bir komut ya da desteklenen bir Lua yöneticisi belirtin (örneğin JSON argümanlarıyla `window.float` için `{"action":"toggle"}`). **Oluştur**, bunu kaydeder ve uygular, ardından **Tüm Kısayollar → Özel Kısayollar** içinde seçer. İptal veya `Esc` taslağı iptal eder. Oluşturma ve yakalama komutu çalıştırmaz.

Özel kısayollar düzenlenebilir, etkinleştirilebilir/devre dışı bırakılabilir ve onayla silinebilir. Aynı bağlamdaki etkin kısayollarla çakışmalar, değiştirme onayı gerektirir; korumalı atamalar değiştirilemez. Resmî varsayılanları geri yüklemek özel kayıtları korur. Geri yükleme aktif bir özel kısayolla çakışacaksa, önce o özel kısayolu değiştirin veya devre dışı bırakın. Özel tanımlar `/hyprland/custom_shortcuts` altında `$XDG_CONFIG_HOME/argvus/config/hyprland.json`’de saklanır. Oluşturulan `data/generated/hypr/custom-shortcuts.lua`, mevcut korumalı yükleyici ile yüklenir; geçersiz kayıtlar günlüklenir ve geri kalan yapılandırmanın iptali yapılmaz. Kaydetme hataları taslağı korur; uygulama hataları kaydın kaydedildiğini bildirir ve yeniden denenebilir.

`argvus control-center shortcuts create` veya `argvus control-center shortcuts list` çalıştırarak herhangi bir sayfayı açın. Gelişmiş alt haritalar, fare kısayolları veya bayraklar için [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) hâlâ kullanılabilir. Oluşturulan parçaları asla düzenlemeyin.

## Mevcut referans

Temel manifest ve yüklü hile sayfaları `/usr/share/argvus/hyprland/` altındadır. Aktif kullanıcı geçersiz kılma bir yedek manifest değildir: Kontrol Merkezi'nde seçilen girişleri değiştirir. Bu nedenle, sürüme özel, elle kopyalanmış bir liste eski hale gelebilir.

Bazı kullanışlı yerleşik eylemler arasında odak ve çalışma alanlarını taşıma, kayan pencereleri değiştirme, ekran görüntüleri ve kayıt alma, başlatıcı/terminal açma, görünümü değiştirme, oturumu kilitleme, medyayı kontrol etme ve Hyprland’i yeniden yükleme bulunur. Varsayılan kısayollar aşağıdaki [varsayılan kısayol tablosunda](#default-shortcut-table) listelenmiştir; Kontrol Merkezi sayfası, kısayolların şu anda nasıl yapılandırıldığını gösterir.

`SUPER + Shift + R` açık çalıştırma zamanı yeniden yüklemesidir: Hyprland'i yeniden yükler ve ARGVUS görev çubuğu, Denetim Masası ve Widget Telemetri hizmetlerini yeniden başlatır. Yapılandırma ile yönlendirilen yeniden yüklemeler koşullu kalır ve standart durum değişmediğinde grafiksel yeniden yüklemeyi atlar.

## Varsayılan kısayol tablosu

Tablo, temel manifestonun (`/usr/share/argvus/hyprland/keybindings.json`) varsayılan tuşlarıyla bağlamalarını listeler. Kontrol Merkezi'ndeki kendi değişiklikleriniz, burada gösterilen tuşların etkilenen bağlamalar için yerini alır ve devre dışı bırakılmış bağlamalar çalışmaz.

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
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | Projeyi o konumda açar`argvus projects` |
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
| `SUPER + [` | Terminal not defteri (özel bir çalışma alanında açılır menü; gizlemek için tekrar basın) |
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
| `SUPER + ALT + G` | Proje seçici, sonra seçilen projede git TUI (lazygit veya gitui) (`argvus git`) |

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

### Ekran görüntüleri ve kayıt

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
| `SUPER + F5` | ARGVUS Dark ve ARGVUS Light temaları arasında geçiş yap |
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector and Night Light toggle |

### Boyutlandırma modu (SUPER + R'den sonra)

Bu kısayollar yalnızca yeniden boyutlandırma modu etkinken çalışır. `Esc` veya `Enter` modu bırakır.

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


Yüzen ve çalışma alanı davranışı için [Windows ve düzen](/docs/argvus-hyprland/windows-and-layout/) bölümüne ve ayarlar iş akışı için [Kontrol Merkezi](/docs/components/argvus-control-center/) bölümüne bakın.

## Gece Lambası

**SUPER + Shift + B**, `appearance.brightness` eylemini kanonik tuş atama manifestosunda tutar. Rofi parlaklık menüsü, Hyprsunset mevcut olduğunda Gece Işığı seçeneğini de sunar. Sıcaklığı (1000–20000 K) ve yerel başlangıç/bitiş saatlerini **Kontrol Merkezi > Masaüstü & Giriş > Ekranlar > Gece Işığı** bölümünden yapılandırın. Hızlı eylem, paylaşılan CLI'yi kullanır ve Hyprland’i yeniden yüklemez veya oluşturulan Lua’yı değiştirmez.


İsteğe bağlı argvus-ai paketi yüklendiğinde, SUPER + A AI ajanları menüsünü açar. Bu kısayol, app.ai kullanıcı geçersiz kılmalarına saygı gösterir ve paket kaldırıldıktan ve kompozitör yeniden yüklendikten sonra kaybolur. Yeniden yüklemeye kadar korumalı eylem devre dışıdır.


İsteğe bağlı argvus-ai paketi /usr/share/argvus/ai/hyprland.lua dosyasına sahiptir. Hyprland, kullanıcı tarafından yapılan değiştirmelerden önce bunu güvenli bir şekilde yükler; modülü kaldırmak, yeniden yüklemede onun bağını kaldırır. Hyprland paketi, modül yükleme/güncelleme/kaldırma sonrasında yalnızca sistem yapılandırma zaman damgasını değiştiren bir Pacman kancası sağlar ve bu, yerel otomatik yeniden yüklemeyi tetikler. Eğer otomatik yeniden yükleme devre dışıysa veya ayrı bir kullanıcı root yapılandırması kullanılıyorsa, bu yapılandırmayı açıkça yeniden yükleyin. Kontrol Merkezi kataloğu, aynı varsayılan tuşlar ve yerelleştirilmiş etiketle app.ai içerir; isteğe bağlı modül olmadan bağlama etkin kalmaz.


## Paketler terminal

Bu tuşlar, Hyprland genelinde değil, **Kontrol Merkezi > Sistem Yönetimi > Paketler** içinde uygulanır. `F8` işlem terminalini yeniden açar, `Esc` işlemi durdurmadan gizler, `Shift+PageUp/PageDown` geçmişi kaydırır, `Shift+End` canlı çıktıya döner ve `Ctrl+C` odaklanmış çocuğu keser. Yüklü olan hile sayfası aynı tuşları içerir.

Paketlerde, `/` üst **Arama** çubuğuna odaklanır. `Enter` burada Resmi/AUR kurulum aramalarını gönderir; kaldırma ve güncelleme listeleri yazdıkça filtrelenir. `Down` sonuçlara geçer, `Up` ilk sonuca basıldığında Aramaya döner ve `Esc` Aramada sorguyu korur ve listeye döner. Bir sonuca Enter tuşuna basmak, paketin işlemini gerçekleştirir.
