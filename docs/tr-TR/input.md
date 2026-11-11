---
title: Mouse and touchpad
description: ARGVUS'ta işaretçi ve dokunmatik yüzey davranışını yapılandırın.
---

**Kontrol Merkezi → Dil ve Bölge → Fare & Dokunmatik Yüzey** öğesini açın veya `argvus control-center input` çalıştırın.

## Mouse

Bir fare algılandığında, sayfa şunları gösterir:

- sensitivity from `-1.0` to `1.0`;
- uyarlanabilir veya düz hızlanma profili;
- kaydırma faktörü `0.1`'den `10.0`'ye;
- natural scrolling;
- sol el ile kullanılan düğme düzeni.

Hassasiyet, kaydırma faktörü ve geçişler, sayfa açıkken Hyprland üzerinden uygulanır, ardından tam giriş durumu kaydedilir. Sayfa, ARGVUS giriş dosyası mevcut olmadığında geçerli kompozitör değerini okur.

## Touchpad

Bir dokunmatik yüzey algılandığında, sayfa doğal kaydırma, tıklamak için dokunma, dokun ve sürükle, iki parmakla sağ tıklama ve yazarken devre dışı bırakma seçeneklerini gösterir. Bu seçenekler, yalnızca çalışan oturum bir dokunmatik yüzey bildirdiğinde faydalı kontroller olarak gösterilir.

## Donanıma bağımlı kontroller

`ratbag` tarafından desteklenen gelişmiş fare kontrolleri yalnızca desteklenen cihazlar için gösterilir. ARGVUS, her farenin DPI, profiller veya anket değişikliklerini desteklediğini iddia etmez. Bir cihaz algılanmazsa veya isteğe bağlı cihaz hizmeti kullanılamıyorsa, bu kontroller bu sayfa tarafından uygulanamaz.

## Kalıcılık ve sıfırlama

Ayarlar kullanıcı durumu olarak saklanır ve oluşturulan Hyprland giriş parçacığı oturum için yeniden oluşturulur. Sayfanın sıfırlama işlemi mevcut olduğunda kullanın; oluşturulan parçacığı doğrudan düzenlemeyin. Oturum ilgili cihaz durumunu yeniden yükleyemediğinde bir ayar yalnızca geçerli kompozitöre uygulanabilir.

Bkz. [Kontrol Merkezi](/docs/components/argvus-control-center/) ve [Şeylerin nerede yapılandırılacağı](/docs/user-guide/where-to-configure/).
