---
title: Klavye kısayolları
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

### Navigasyon

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + Left Arrow` | Döşemeli pencereyi yöne göre odakla |
| `SUPER + Right Arrow` | Döşemeli pencereyi yöne göre odakla |
| `SUPER + Up Arrow` | Döşemeli pencereyi yöne göre odakla |
| `SUPER + Down Arrow` | Döşemeli pencereyi yöne göre odakla |
| `SUPER + CTRL + Left Arrow` | Pencereler arasında odaklamayı değiştir (döşenmiş ve kayan) |
| `SUPER + CTRL + Right Arrow` | Pencereler arasında odaklamayı değiştir (döşenmiş ve kayan) |

### Çalışma alanları

| Kısayol | Açıklama |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Çalışma alanları arasında geçiş |
| `CTRL + ALT + Left Arrow` | Çalışma alanları arasında geçiş |
| `Mouse extra button (mouse:276)` | Çalışma alanları arasında geçiş |
| `Mouse side button (mouse:275)` | Çalışma alanları arasında geçiş |
| `SUPER + 1` | Çalışma Alanı 1 |
| `SUPER + 2` | Çalışma Alanı 2 |
| `SUPER + 3` | Çalışma Alanı 3 |
| `SUPER + 4` | Çalışma Alanı 4 |
| `SUPER + 5` | Çalışma Alanı 5 |
| `SUPER + 6` | Çalışma Alanı 6 |
| `SUPER + 7` | Çalışma Alanı 7 |
| `SUPER + 8` | Çalışma Alanı 8 |
| `SUPER + 9` | Çalışma Alanı 9 |
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | Projeyi o konumda açar`argvus projects` |
| `SUPER + Shift + 1` | Pencereyi masaüstüne taşı 1 |
| `SUPER + Shift + 2` | Pencereyi masaüstüne taşı 2 |
| `SUPER + Shift + 3` | Pencereyi masaüstüne taşı 3 |
| `SUPER + Shift + 4` | Pencereyi masaüstüne taşı 4 |
| `SUPER + Shift + 5` | Pencereyi masaüstüne taşı 5 |
| `SUPER + Shift + 6` | Pencereyi masaüstüne taşı 6 |
| `SUPER + Shift + 7` | Pencereyi masaüstüne taşı 7 |
| `SUPER + Shift + 8` | Pencereyi masaüstüne taşı 8 |
| `SUPER + Shift + 9` | Pencereyi masaüstüne taşı 9 |

### Windows

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + S` | Pencereyi büyüt (aç/kapat) |
| `SUPER + Q` | Pencereyi kapat |
| `SUPER + Shift + Space` | Kayan Pencereyi Etkinleştir/Devre Dışı Bırak |
| `SUPER + F` | Tam ekran pencere |
| `SUPER + E` | Dikey/yatay bölünmüş geçiş |
| `SUPER + W` | Sekmeler halinde grupla/grubu çöz |
| `SUPER + Tab` | Sekmeler arasında gezinin |
| `SUPER + Shift + Left Arrow` | Pencereyi taşı |
| `SUPER + Shift + Right Arrow` | Pencereyi taşı |
| `SUPER + Shift + Up Arrow` | Pencereyi taşı |
| `SUPER + Shift + Down Arrow` | Pencereyi taşı |
| `SUPER + Left mouse button (mouse:272)` | Pencereyi sürükleyin (yalnızca kayan pencere) |
| `SUPER + Right mouse button (mouse:273)` | Pencere yeniden boyutlandırma modu (yalnızca kayan pencere) |
| `SUPER + R` | Pencere yeniden boyutlandırma moduna girin (yalnızca kayan pencere) |

### Uygulamalar

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + Enter` | terminali |
| `SUPER + [` | Terminal not defteri (özel bir çalışma alanında açılır menü; gizlemek için tekrar basın) |
| `SUPER + Space` | Dosya Yöneticisi |
| `SUPER + CTRL + Space` | Sistem monitörü |
| `SUPER + Shift + D` | Çıkarılabilir cihazlar menüsü |
| `SUPER + Shift + F` | ARGVUS Odaklanma (Pomodoro ve odaklanma oturumları) |
| `SUPER + Shift + C` | ARGVUS Saat (saat, zamanlayıcılar ve alarmlar) |
| `SUPER + D` | Program Başlatıcı |
| `SUPER + B` | Varsayılan Tarayıcı |
| `SUPER + C` | Hesap Makinesi |
| `SUPER + ALT + S` | SSH ana bilgisayar seçici (`argvus ssh`) |
| `SUPER + ALT + N` | Parçacık seçici (`argvus snippets`) |
| `SUPER + ALT + G` | Proje seçici, sonra seçilen projede git TUI (lazygit veya gitui) (`argvus git`) |

### Medya

| Kısayol | Açıklama |
| --- | --- |
| `XF86AudioRaiseVolume` | Sesi aç |
| `Volume Down` | Sesi kıs |
| `Mute` | Sessiz |
| `Brightness Up` | Parlaklık artır |
| `Brightness Down` | Parlaklık azaldı |
| `Play/Pause` | Oynat/Duraklat |
| `Next Track` | Sonraki parça |
| `Previous Track` | Önceki parça |
| `Stop` | Parçayı durdur |

### Ekran görüntüleri ve kayıt

| Kısayol | Açıklama |
| --- | --- |
| `Print` | Seçilen alanı yakala |
| `SUPER + Print` | Odaklanmış pencereyi yakala |
| `SUPER + Shift + Print` | Tüm ekranı yakala |
| `SUPER + G` | Start/Pause/Resume ekran kaydı |
| `SUPER + Shift + G` | Ekran kaydını durdurun ve kaydedin |

### Oturum

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + L` | Kilit sistemi |
| `SUPER + escape` | Çıkış sistemi |
| `SUPER + Shift + R` | Hyprland'yu yeniden yükle |
| `SUPER + Shift + S` | Monitörü kapatıp açın (sistemi askıya almayın) |
| `SUPER + Shift + L` | Hareketsizlik kilidi zaman aşımını seçin |
| `SUPER + ALT + W` | Uyanık Tutmayı Değiştir |

### Sistem

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + Shift + /` | Hyprland Hile Sayfaları |
| `SUPER + CTRL + /` | Kitty Hile Sayfaları |
| `SUPER + F1` | Açık ARGVUS Hakkında |
| `SUPER + ALT + C` | Kontrol Merkezini Aç |
| `SUPER + P` | Renk Seçici |
| `SUPER + .` | Emoji Seçici |
| `SUPER + H` | Pano Geçmişi |
| `SUPER + Shift + H` | Pano Geçmişini Temizle |

### Widget'lar

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + ,` | Bildirim kenar çubuğunu aç/kapat |
| `Middle mouse button (mouse:274)` | Bildirim kenar çubuğunu aç/kapat |
| `SUPER + Backspace` | Waybar'yu değiştir üst |
| `SUPER + Shift + W` | Hava durumu konumunu yapılandırın |
| `SUPER + ALT + Up Arrow` | Görev çubuğunu yukarıya taşı |
| `SUPER + ALT + Down Arrow` | Görev çubuğunu aşağıya taşı |

### Görünüm

| Kısayol | Açıklama |
| --- | --- |
| `SUPER + Y` | Kontrol Merkezi duvar kağıtlarını açın |
| `SUPER + Shift + T` | Tema seçiciyi aç |
| `SUPER + Shift + M` | Yapışkan/Aralıklı mod seçiciyi aç |
| `SUPER + F5` | ARGVUS Dark ve ARGVUS Light temaları arasında geçiş yap |
| `SUPER + F6` | Animasyonları aç / kapat |
| `SUPER + Shift + B` | Parlaklık seçiciyi ve Gece Işığı geçişini açın |

### Boyutlandırma modu (SUPER + R'den sonra)

Bu kısayollar yalnızca yeniden boyutlandırma modu etkinken çalışır. `Esc` veya `Enter` modu bırakır.

| Kısayol | Açıklama |
| --- | --- |
| `Right Arrow` | Yeniden Boyutlandır |
| `Left Arrow` | Yeniden Boyutlandır |
| `Up Arrow` | Yeniden Boyutlandır |
| `Down Arrow` | Yeniden Boyutlandır |
| `Shift + Right Arrow` | Pencereyi taşı |
| `Shift + Left Arrow` | Pencereyi taşı |
| `Shift + Up Arrow` | Pencereyi taşı |
| `Shift + Down Arrow` | Pencereyi taşı |
| `escape` | Yeniden boyutlandırma modundan çık |
| `Enter` | Yeniden boyutlandırma modundan çık |


Yüzen ve çalışma alanı davranışı için [Windows ve düzen](/docs/argvus-hyprland/windows-and-layout/) bölümüne ve ayarlar iş akışı için [Kontrol Merkezi](/docs/components/argvus-control-center/) bölümüne bakın.

## Gece Lambası

**SUPER + Shift + B**, `appearance.brightness` eylemini kanonik tuş atama manifestosunda tutar. Rofi parlaklık menüsü, Hyprsunset mevcut olduğunda Gece Işığı seçeneğini de sunar. Sıcaklığı (1000–20000 K) ve yerel başlangıç/bitiş saatlerini **Kontrol Merkezi > Masaüstü & Giriş > Ekranlar > Gece Işığı** bölümünden yapılandırın. Hızlı eylem, paylaşılan CLI'yi kullanır ve Hyprland’i yeniden yüklemez veya oluşturulan Lua’yı değiştirmez.


İsteğe bağlı argvus-ai paketi yüklendiğinde, SUPER + A AI ajanları menüsünü açar. Bu kısayol, app.ai kullanıcı geçersiz kılmalarına saygı gösterir ve paket kaldırıldıktan ve kompozitör yeniden yüklendikten sonra kaybolur. Yeniden yüklemeye kadar korumalı eylem devre dışıdır.


İsteğe bağlı argvus-ai paketi /usr/share/argvus/ai/hyprland.lua dosyasına sahiptir. Hyprland, kullanıcı tarafından yapılan değiştirmelerden önce bunu güvenli bir şekilde yükler; modülü kaldırmak, yeniden yüklemede onun bağını kaldırır. Hyprland paketi, modül yükleme/güncelleme/kaldırma sonrasında yalnızca sistem yapılandırma zaman damgasını değiştiren bir Pacman kancası sağlar ve bu, yerel otomatik yeniden yüklemeyi tetikler. Eğer otomatik yeniden yükleme devre dışıysa veya ayrı bir kullanıcı root yapılandırması kullanılıyorsa, bu yapılandırmayı açıkça yeniden yükleyin. Kontrol Merkezi kataloğu, aynı varsayılan tuşlar ve yerelleştirilmiş etiketle app.ai içerir; isteğe bağlı modül olmadan bağlama etkin kalmaz.


## Paketler terminal

Bu tuşlar, Hyprland genelinde değil, **Kontrol Merkezi > Sistem Yönetimi > Paketler** içinde uygulanır. `F8` işlem terminalini yeniden açar, `Esc` işlemi durdurmadan gizler, `Shift+PageUp/PageDown` geçmişi kaydırır, `Shift+End` canlı çıktıya döner ve `Ctrl+C` odaklanmış çocuğu keser. Yüklü olan hile sayfası aynı tuşları içerir.

Paketlerde, `/` üst **Arama** çubuğuna odaklanır. `Enter` burada Resmi/AUR kurulum aramalarını gönderir; kaldırma ve güncelleme listeleri yazdıkça filtrelenir. `Down` sonuçlara geçer, `Up` ilk sonuca basıldığında Aramaya döner ve `Esc` Aramada sorguyu korur ve listeye döner. Bir sonuca Enter tuşuna basmak, paketin işlemini gerçekleştirir.
