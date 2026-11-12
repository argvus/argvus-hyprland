---
title: Windows ve düzen
description: ARGVUS'taki boşlukları, sınırları, modları ve panel alanını anlayın.
---

ARGVUS, döşeli ve kayan pencere yerleştirmesi için Hyprland kullanır. Kullanıcıya yönelik düzen kontrolleri üç Kontrol Merkezi sayfasında bulunur: **Kontrol Merkezi → Görünüm → Görev Çubuğu** (konum, alanlar ve simgeler), **Kontrol Merkezi → Masaüstü & Girdi → Hyprland → Pencereler → Alanlar** ve **Kontrol Merkezi → Masaüstü & Girdi → Hyprland → Sınırlar**.

##

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```

- **Pencere boşlukları**, döşeli pencereler ile döşeli düzenin dış kenarı arasındaki alandır.
- **Görev çubuğu veya kabuk boşluğu**, görev çubuğu ve panel gibi masaüstü yüzeylerinin etrafındaki marjdır. Bu, bir pencere boşluğu ile aynı değer değildir.
- **Kenarlıklar** bir pencerenin etrafına çizilen görünür sınırdır. **Kenar kalınlığı**, görünüm sayfasında ortaya çıkan kenarlık genişliğini kontrol eder.
- **Yuvarlama**, seçilen görsel modun bir parçasıdır. Pencereyi taşımak yerine pencere köşe şeklini değiştirir.
- **Panel rezervasyonu ve görünür kenar boşluğu** ayrı konulardır: bir panel, Hyprland hala pencereleri aktif boşluk durumuna göre yerleştirirken alan kaplayabilir veya görsel olarak kullanabilir.

## Yapışkan ve Aralıklı modlar

Paketlenmiş tema modları iki başlangıç geometrisi sağlar:

| Modu | Pencere davranışı | Yüzey işleme |
| --- | --- | --- |
| Yapışkan | İç boşluk `2`, dış boşluk `0`varsayılan olarak | Kare, kompakt ve ekranın kenarına yakın |
| Aralıklı | İç boşluk `10`, dış boşluk `18`varsayılan olarak | Yuvarlatılmış, gölgeli ve daha geniş; görev çubuğu/kabuk kenar boşluğu varsayılan olarak `18` |

Bunlar varsayılanlardır, sınırlar değildir. Pencere boşlukları ve Görev Çubuğu boşlukları sayfaları, pencere boşluklarını ve görev çubuğu kenar boşluklarını bağımsız olarak depolayabilir. Bir tema veya mod değiştirmek, farklı etkili düzen değerlerini gösterebilir.

## Düzen kontrolleri

Her kontrol bağımsızdır ve burada listelenen sayfada bulunur:

- **Görev Çubuğu → Konum** — görev çubuğu konumu, üst veya alt kenar.
- **Görev Çubuğu → Alanlar** — görev çubuğu üst, sol, sağ ve alt kenar boşlukları, her biri `0` ile `100` arasında. Sticky alt kenar boşluğunu varsayılan olarak `2` yapar; Spaced `18` kullanır.
- **Görev Çubuğu → Simgeler** — görev çubuğu yardımcı grubu otomatik mi yoksa her zaman genişletilmiş davranışı mı kullanacak.
- **Hyprland → Windows → Spaces** — iç boşluk ve dış üst/sol/sağ/alt boşluklar, her biri `0`'den `100`'ya kadar.
- **Hyprland → Borders** — genel sınırlar: yuvarlatılmış köşeleri etkinleştir; etkinleştirildiğinde, yuvarlatma `2`'den `10`'ya kadar seçilebilir. Kenar kalınlığı da burada ayarlanır, `0`'den `10`'ya kadar.
- **Hyprland → Kenarlar → Gölge** — pencere gölgesi, varsayılan olarak kapalıdır. Aralığı, render gücünü, keskin köşeleri, ofsetleri ve ölçeği ayarlar ve rengi, bir renk girilmedikçe tema aksanını alfa `99` ile takip eder.

Bu değerler ARGVUS görünüm durumuna yazılır ve `argvus-config`, bunları oturumun uyguladığı oluşturulmuş Hyprland dosyalarına yansıtır. Bir görev çubuğu kenar boşluğu, kabuk yüzeyinin konumunu değiştirir; dış pencere boşluğu ise döşenmiş pencere alanını değiştirir. Benzer bir görsel mesafe üretebilirler, ancak birini değiştirmek diğerini değiştirmez.

## Pencereler ve çalışma alanları


Paketlenmiş yapılandırma, Kontrol Merkezi, Snake ve Disk Kullanım Analizörü'nü yüzen, ortalanmış pencereler olarak açar. Disk Kullanım Analizörü, pencere açıldığında pencere sınıfı kuralı tarafından uygulanan görev çubuğu bellek açılır penceresi ile aynı başlangıç  `SUPER + SHIFT + Space` `1399 × 920` geometrisini kullanır. ARGVUS Focus ve ARGVUS Clock, görev çubuğunun yanına sabitlenmiş GTK katman-kabuğu açılır pencereleridir, bu nedenle döşenmiş pencereler değildirler ve Hyprland pencere kurallarını kullanmazlar. Saat alarm kartı ayrı bir katman yüzeyidir (`argvus-clock-alarm`).

Kontrol Paneli, modali açıkken tam ekran katman yüzeyi kullanır. Paketlenmiş kurallar, Polkit ajanını, GTK portalını ve KDialog pencerelerini yüzdürür, ortalar ve sabitler, böylece panel tarafından başlatılan dialoglar modalin üzerinde kalır ve giriş alabilir.

`hyprpicker`, `SUPER + P` ile açıldığında, Hyprland animasyonlarını kullanmaz. Bu istisna yalnızca renk seçiciyi etkiler; diğer animasyonlar küresel ayarları takip etmeye devam eder.

### Tarayıcılar ve IDE'ler için çalışma alanı yerleşimi

Temiz bir kurulumda varsayılan olarak pencere kuralları tanımlanmamıştır. Kendi uygulama başına çalışma alanı yerleştirme kurallarınızı argvus-config altında `hyprland.window_rules` içinde ekleyebilirsiniz, örneğin:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Her kuralın 1'den 10'a kadar bir  `argvus-config` `workspace`'si ve bir `classes` listesi vardır. `classes`'deki girdiler, pencere sınıfına karşı eşleşen düzenli ifadelerdir (büyük/küçük harf duyarlı), örneğin `[Cc]ode.*` veya `jetbrains-.*`. Yalnızca harfler, rakamlar ve `._*+?-[]()|^$` kabul edilir. `argvus-config`, kuralları `generated/hypr/window-rules.lua`'ye yazar ve Hyprland yapılandırması bunu yükler. Varsayılanları değiştirmeden kuralları değiştirmek için, ARGVUS veri dizininizde `hl.window_rule` çağrılarını `rules.lua`'ye ekleyin; bunlar oluşturulan kurallardan sonra yüklenir.

## İlk olarak neyi değiştirmeli

- Pencereler sıkışık görünüyorsa, pencere boşluğunu artırın veya Aralıklı modu kullanın.
- Pencereler ekran kenarından çok uzakta görünüyorsa, dış/görev çubuğu boşluğunu azaltın veya Yapışkan modu kullanın.
- Görev çubuğunun konumunu değiştirdikten sonra hizalanmamış görünüyorsa, görev çubuğu konumunu ve tüm dört görev çubuğu/shell kenar boşluğunu birlikte gözden geçirin.
- Pencereler bir görsel panelin üzerine geliyorsa, pencere boşluklarını değiştirmeden önce panel ve görev çubuğu düzeni ayarlarını kontrol edin.

Değişiklikler ARGVUS görünüm/oturum entegrasyonu üzerinden uygulanır. Mevcutsa sayfanın sıfırlama eylemini kullanın; oluşturulan Hyprland dosyalarını doğrudan düzenlemeyin.

## İlgili


## Pencere sallanması

Aç **Masaüstü ve Giriş → Hyprland → Animasyonlar → Pencereler** ve
**Sallanma** kontrollerini kullanın. `wobble` arayın veya sayfayı doğrudan açın:

```sh
argvus control-center hyprland animations windows
```

Salınım varsayılan olarak devre dışıdır. ARGVUS varsayılanları sertlik `100`, sönümleme
`10`, kütle `1`, yoğunluk `1` ve ağ çözünürlüğü `8`'dir. Sertlik ve kütle
`0.0001–1000`, sönümleme `0–1000`, yoğunluk `0–2` ve ağ için bir tamsayı `2–32` kabul eder.
Daha yüksek ağ çözünürlüğü render maliyetini artırır. Ayarlamak için ok tuşlarını kullanın
değerleri veya onları yazmak için Enter. **Wobble varsayılanlarını geri yükle** taslağı değiştirir;
**Uygula**, bekleyen tüm animasyon düzenlemelerini kaydeder ve Hyprland'i bir kez yeniden yükler, olmadan
Oturum yeniden başlatılıyor. Animasyonlar içinde geri gitmek, paylaşılan taslağı korur.

Küresel Animations anahtarı, Wobble özelliğini bastırırken bireysel
ayarlarını korur. Kanonik değerler ARGVUS durumunda `effects.wobble_*` altında bulunur;
`hypr/state.lua` oluşturulur ve elle düzenlenmemelidir.

Bu, `argvus-hyprland`'nun
paket bağımlılığı. 0.56 sürümü bu yapılandırma için desteklenmiyor.
yoğunluk maksimumu,

## Küresel pencere modu

Aç **Kontrol Merkezi → Masaüstü ve Girdi → Hyprland → Pencereler → Mod** ve **Pencereleri Döşeme (Varsayılan)** veya **Yüzen Pencereler** seçimini yap. Aynı seçim aracı, görev çubuğu yardımcı program grubundaki pencere modu simgesinden de mevcuttur.

Tercih her monitör ve çalışma alanı için geçerlidir ve çıkış yapıldıktan sonra hatırlanır. Yüzen, mevcut uygulama pencerelerini ve yeni açılan pencereleri dönüştürür. Döşeme, yalnızca bu politika tarafından dönüştürülen pencereleri geri yükler; zaten yüzen durumda olan iletişim kutuları ve diğer pencereler yüzen olarak kalır. Yüzen aktifken açıkça sabitlenen bir pencere, sabitlenmesini korumak için yüzen kalır. Döşemeli düzen yeniden hesaplanır; önceki tam bölünmüş ağacı geri yüklenmez.

 `2`  `3` `SUPER + SHIFT + Space`, Tile modunda normal pencere başına davranışını korur. Floating modda bir pencereyi tekrar döşemeye (tiling) geçirmez. Paneller, görev çubuğu ve bildirimler layer-shell yüzeyleridir ve etkilenmezler. Tam ekran, Hyprland'in normal davranışını kullanmaya devam eder; ARGVUS maksimizasyonu Spaced modunda kenarlıkları korur.

Kanonik tercih, `/hyprland/window_mode` içinde `$XDG_CONFIG_HOME/argvus/config/hyprland.json`’dur. Üretilen projeksiyonu `data/generated/hypr/window-mode.lua`’dir; bunu düzenlemeyin. Pencere başına geri yükleme kaydı, `$XDG_RUNTIME_DIR/argvus` altında bulunur, kompozitör örneğine özgüdür ve yapılandırma yeniden yüklemelerinden sonra korunur. Yeni bir oturumda yeniden kullanılmaz.

Başvuru beklemede ise veya başarısız olursa, arayüz bunu kaydedilen tercihten ayırır. Yeniden denemek için seçeneği tekrar seçin. Bir bileştirici olmadan, tercih bir sonraki girişte kaydedilir.

## Pencere düğmeleri ve uygulama çubuğu

Yüzen mod, normal uygulama pencerelerine **Simge Durumuna Küçült**, **Büyüt / Geri Yükle** ve **Kapat** içeren bir ARGVUS başlık çubuğu ekler. Başlık çubuğuna çift tıklamak, pencereyi büyütme durumunu değiştirir. Ek dekorasyon, Döşeme ve tam ekran modunda gizlenir. Kendi kontrollerini çizen uygulamalar her iki çubuğu da gösterebilir; standart ARGVUS kontrolleri kasıtlıdır.

Her monitörde, ana görev çubuğunun karşı tarafındaki kenarda ikinci bir Waybar görünür. Sadece o monitörün mevcut çalışma alanındaki pencereleri listeler, küçültülmüş pencereler dahil. Gizli grup sekmeleri ekstra giriş oluşturmaz. Küçültülmüş girişler, orijinal monitör/çalışma alanı ilişkisini korur. Etkin olmayan bir pencereye tıklayarak etkinleştirebilir, etkin bir pencereye tıklayarak küçültebilir veya küçültülmüş bir pencereye tıklayarak geri getirebilirsiniz; bağlam menüsü geri yükle, küçült, büyüt/gönder ve kapat seçeneklerini sunar. Bilinmeyen uygulama simgeleri pencere simgesi ile varsayılan olarak gösterilir. Bir girişi etkinleştirmek veya geri yüklemek, imleç pozisyonunu korur. İkincil çubuk, etkili birincil CSS'i (renkler, yazı tipleri, kenarlık ve yuvarlama) kullanır; yüksekliği ve ters kenardaki yansıtılmış kenar boşlukları ile birlikte.

`SUPER + Alt + Up` ana çubuğu üstte, pencere çubuğunu altta yerleştirir. `SUPER + Alt + Down` ise tersini yapar. Bir yönü tekrar etmek, konumları değiştirmez. Tile’da sadece ana çubuk vardır. Tile’a geri dönmek, pencere çubuğu kaldırılmadan önce tüm simge durumuna küçültülmüş pencereleri geri getirir ve ardından orijinal döşeme/serbest politika korunur.

Minimize etme, rezerve edilmiş `special:argvus-minimized` çalışma alanını kullanır. Bu çalışma alanını manuel olarak kullanmayın. `argvus windows service` işlemi, kimliği, orijinal çalışma alanını/monitörü, geometrisini, tam ekran/masimleştirme ve sabitleme durumunu `$XDG_RUNTIME_DIR/argvus` altında her kompozitör örneğine özgü bir çalışma zamanı kaydında kaydeder. Kayıtlar bir servis yeniden başlatması veya yapılandırma yeniden yüklemesini geçirir, ancak kompozitör oturumlarını geçmez. Bir pencere kapatıldığında kaydı silinir. Bir monitör kaybolursa, geri yükleme mevcut bir çıktı kullanır. Eksik veya başarısız bir geri kazanım çubuğu, yeni minimize işlemlerini engeller; başarısız geri yükleme kaydı ve geri kazanım çubuğunu korur.

Oturum `argvus-windows.service` ve `argvus-window-bar.service` adlı öğelere sahiptir. İkincisi Waybar alt öğesini Tile içinde pasif tutar. hyprbars eklentisi `argvus-hyprland` tarafından paketlenmiştir, Hyprland 0.57.0 ABI için x86_64 üzerinde oluşturulmuştur; kullanıcı ev dizininde derlenmemiştir. Eklentiyi bir compositor ABI güncellemesi ile yeniden derleyin.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all` ve `minimize|restore|activate|maximize|close ADDRESS`. Pencere adresleri listeden gelir. `position top --persist` tercihi ana çubuğu yeniden başlatmadan kaydeder/projeler. Yapılandırma ve çalışma zamanı hata detayları günlük dosyasına yazılır; görülebilen işlem hataları ayrıca çevrilmiş bir bildirim gösterir.

**Spaced + Floating** modunda, pencereler dış boşluklara ve her iki çubuğun ayırdığı alanlara saygı gösterir. Sınırlar, aynı pencere sınırının içinde yer alan kenarlık ve başlığı içerir. ARGVUS kontrolleri ile tam ekran yapıldığında bu alan kenar boşluklarıyla doldurulur; geri yükleme, hizmet yeniden başlatıldıktan sonra bile önceki geometrinin geri getirilmesini sağlar. Tam ekran hâlâ tüm çıktıyı kullanır. Pencereler serbest şekilde hareket edebilir; döşeme iç boşlukları onları ayırmaz.

`SUPER + Alt + Space`, görev çubuğu ve Kontrol Merkezi ile aynı tercihi kullanarak genel Kare/Kayan modu açar veya kapatır. Eşdeğer komut `argvus config window-mode toggle`'dir. Eşzamanlı çağrılar sıraya konur; görev beklemede olsa bile geçiş kaydedilen tercihi kullanır. Kısayol, Klavye Kısayollarında değiştirilebilir veya devre dışı bırakılabilir; `SUPER + Shift + Space` kendi tek pencere eylemini korur.

Her kuralın 1'den 10'a kadar bir çalışma alanı ve bir sınıf listesi vardır. Sınıflardaki girişler, pencere sınıfına (büyük/küçük harfe duyarlı) göre eşleşen düzenli ifadelerdir; örneğin [Cc]ode.* veya jetbrains-.*. Yalnızca harfler, rakamlar ve ._*+?-|^$ kabul edilir. argvus-config, kuralları Hyprland yapılandırmasının yüklediği created/hypr/window-rules.lua öğesine yazar. Varsayılanları değiştirmeden kuralları değiştirmek için, ARGVUS veri dizininizdeki kurallara.lua hl.window_rule çağrılarını ekleyin; bunlar oluşturulan kurallardan sonra yüklenir.
 yüklü ve kullanıcı yolları için. yüklü ve kullanıcı yolları için.(https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),

Döşenmiş pencereler etkin çalışma alanında Hyprland tarafından düzenlenir. ARGVUS aynı zamanda değişken yardımcı program pencerelerini de destekler; SUPER + SHIFT + Space, odaklanılan pencerede döşenmiş ve kayan düzenler arasında geçiş yapar. Çalışma alanı hareketi ve pencere odağı, etkin tuş bağlama bildirimi tarafından kontrol edilir; bkz. [Klavye kısayolları](/docs/argvus-hyprland/keyboard-shortcuts/).
- [Görünüm](/docs/user-guide/appearance/)
- [Temalar](/docs/user-guide/appearance/)
- [Görev Çubuğu](/docs/argvus-taskbar/taskbar/)
- [Denetim Masası](/docs/argvus-control-panel/)
yoğunluk maksimumu şunu takip eder[0.57.0 kaynağı yayınlandı](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
