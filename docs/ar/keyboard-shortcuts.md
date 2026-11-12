---
title: اختصارات لوحة المفاتيح
description: ARGVUS Hyprland.  ﻦﻳﻮﻜﺗ ﺔﻄﺳﺍﻮﺑ ﺔﻣﺪﻘﻤﻟﺍ ﺕﺍﺭﺎﺼﺘﺧﻻ﻿ﺍ ﻦﻋ ﺚﺤﺑﺍ
---

.argvus control-center keybindings ﻞﻴﻐﺸﺘﺑ ﻢﻗ ﻭﺃ ،**ﺢﻴﺗﺎﻔﻤﻟﺍ ﺔﺣﻮﻟ ﺕﺍﺭﺎﺼﺘﺧﺍ → ﻝﺎﺧﺩﻹ﻿ﺍﻭ ﺐﺘﻜﻤﻟﺍ ﺢﻄﺳ

## ﺔﺤﻔﺼﻟﺍ ﻪﻠﻌﻔﺗ ﻱﺬﻟﺍ ﺎﻣ







يمكن تحرير الاختصارات المخصصة وتمكينها/تعطيلها وحذفها مع التأكيد. تتطلب التعارضات مع الاختصارات الممكّنة في نفس السياق تأكيد الاستبدال؛ لا يمكن استبدال الارتباطات المحمية. تؤدي استعادة الإعدادات الافتراضية الرسمية إلى الاحتفاظ بالسجلات المخصصة. إذا كانت الاستعادة ستتعارض مع اختصار مخصص نشط، فقم بتغيير هذا الاختصار المخصص أو تعطيله أولاً. يتم تخزين التعريفات المخصصة ضمن `argvus control-center keybindings` في `SUPER + Y`. يتم تحميل `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json` الذي تم إنشاؤه باستخدام المُحمل المحمي الموجود؛ يتم تسجيل التسجيلات غير الصالحة دون إلغاء بقية التكوين. عمليات الحفظ الفاشلة تحافظ على المسودة؛ تشير حالات فشل التطبيق إلى أنه تم حفظ السجل ويمكن إعادة محاولته.

.ﺎﻫﺅﺎﺸﻧﺇ ﻢﺗ ﻲﺘﻟﺍ ءﺍﺰﺟﻷ﻿ﺍ ﺮﻳﺮﺤﺘﺑ

## ﻲﻟﺎﺤﻟﺍ ﻊﺟﺮﻤﻟﺍ





`/keyboard_shortcuts` هو إعادة التحميل الصريح لوقت التشغيل: فهو يعيد تحميل Hyprland ويعيد تشغيل ARGVUS شريط المهام ولوحة التحكم وخدمات قياس عناصر واجهة المستخدم. تظل عمليات إعادة التحميل المستندة إلى التكوين مشروطة وتتخطى إعادة التحميل الرسومي عندما تظل الحالة الأساسية دون تغيير.

## ﻲﺿﺍﺮﺘﻓﻻ﻿ﺍ ﺕﺍﺭﺎﺼﺘﺧﻻ﻿ﺍ ﻝﻭﺪﺟ

يسرد الجدول روابط البيان الأساسي (`~/.config/argvus/data/generated/hypr/` /usr/share/argvus/hyprland/keybindings.json SUPER + Shift + R /usr/share/argvus/hyprland/ الارتباطات.lua argvus قائمة اختصارات مركز التحكم argvus إنشاء اختصارات مركز التحكم بيانات/generated/hypr/custom-shortcuts.lua $XDG_CONFIG_HOME/argvus/config/hyprland.json /hyprland/custom_shortcuts Esc {"action":toggle"} window.float keybindings.toml /hyprland/keybindings Drag_window__floating_window_only window.drag_mouse Close_window window. إغلاق `null` ) مع مفاتيحها الافتراضية. تحل تغييراتك الخاصة في "مركز التحكم" محل المفاتيح الموضحة هنا للارتباطات المتأثرة، ولا يتم تشغيل الارتباطات المعطلة.

### الملاحة

| الاختصار | الوصف |
| --- | --- |
|  `window.close`  `close_window`  `window.drag_mouse`  `drag_window__floating_window_only`  `/hyprland/keybindings`  `keybindings.toml`  `window.float`  `{"action":"toggle"}`  `Esc`  `/hyprland/custom_shortcuts`  `$XDG_CONFIG_HOME/argvus/config/hyprland.json`  `data/generated/hypr/custom-shortcuts.lua`  `argvus control-center shortcuts create`  `argvus control-center shortcuts list`  `bindings.lua`  `/usr/share/argvus/hyprland/`  `SUPER + Shift + R`  `/usr/share/argvus/hyprland/keybindings.json` `SUPER + Left Arrow` | Focus tiled window by direction |
| `SUPER + Right Arrow` | التركيز على النافذة المبلطة بالاتجاه |
| `SUPER + Up Arrow` | التركيز على النافذة المبلطة بالاتجاه |
| `SUPER + Down Arrow` | التركيز على النافذة المبلطة بالاتجاه |
| `SUPER + CTRL + Left Arrow` | التركيز على الدورة بين النوافذ (المبلطة والعائمة) |
| `SUPER + CTRL + Right Arrow` | التركيز على الدورة بين النوافذ (المبلطة والعائمة) |

### مساحات العمل

| الاختصار | الوصف |
| --- | --- |
| `CTRL + ALT + Right Arrow` | التنقل بين مناطق العمل |
| `CTRL + ALT + Left Arrow` | التنقل بين مناطق العمل |
| `Mouse extra button (mouse:276)` | التنقل بين مناطق العمل |
| `Mouse side button (mouse:275)` | التنقل بين مناطق العمل |
| `SUPER + 1` | مساحة العمل 1 |
| `SUPER + 2` | مساحة العمل 2 |
| `SUPER + 3` | مساحة العمل 3 |
| `SUPER + 4` | مساحة العمل 4 |
| `SUPER + 5` | مساحة العمل 5 |
| `SUPER + 6` | مساحة العمل 6 |
| `SUPER + 7` | مساحة العمل 7 |
| `SUPER + 8` | مساحة العمل 8 |
| `SUPER + 9` | مساحة العمل 9 |
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9`                                              ﻦﻣ ﻊﺿﻮﻤﻟﺍ ﻚﻟﺫ ﻲﻓ ﻉﻭﺮﺸﻤﻟﺍ ﺢﺘﻔﻳ | `argvus projects` |
| `SUPER + Shift + 1` | نقل النافذة إلى سطح المكتب 1 |
| `SUPER + Shift + 2` | نقل النافذة إلى سطح المكتب 2 |
| `SUPER + Shift + 3` | نقل النافذة إلى سطح المكتب 3 |
| `SUPER + Shift + 4` | نقل النافذة إلى سطح المكتب 4 |
| `SUPER + Shift + 5` | نقل النافذة إلى سطح المكتب 5 |
| `SUPER + Shift + 6` | نقل النافذة إلى سطح المكتب 6 |
| `SUPER + Shift + 7` | نقل النافذة إلى سطح المكتب 7 |
| `SUPER + Shift + 8` | نقل النافذة إلى سطح المكتب 8 |
| `SUPER + Shift + 9` | نقل النافذة إلى سطح المكتب 9 |

### ويندوز

| الاختصار | الوصف |
| --- | --- |
| `SUPER + S` | تكبير النافذة (تبديل) |
| `SUPER + Q` | إغلاق النافذة |
| `SUPER + Shift + Space` | تمكين/تعطيل النافذة العائمة |
| `SUPER + F` | نافذة ملء الشاشة |
| `SUPER + E` | تقسيم التبديل الرأسي/الأفقي |
| `SUPER + W` | تجميع/فك التجميع في علامات التبويب |
| `SUPER + Tab` | التنقل بين علامات التبويب |
| `SUPER + Shift + Left Arrow` | تحريك النافذة |
| `SUPER + Shift + Right Arrow` | تحريك النافذة |
| `SUPER + Shift + Up Arrow` | تحريك النافذة |
| `SUPER + Shift + Down Arrow` | تحريك النافذة |
| `SUPER + Left mouse button (mouse:272)` | نافذة السحب (النافذة العائمة فقط) |
| `SUPER + Right mouse button (mouse:273)` | وضع تغيير حجم النافذة (النافذة العائمة فقط) |
| `SUPER + R` | أدخل وضع تغيير حجم النافذة (النافذة العائمة فقط) |

### التطبيقات

| الاختصار | الوصف |
| --- | --- |
| `SUPER + Enter` | المحطة |
| `SUPER + [`| (ﺎﻬﺋﺎﻔﺧﻹ﻿ ﻯﺮﺧﺃ ﺓﺮﻣ ﻂﻐﺿﺍ ؛ﺔﺻﺎﺧ ﻞﻤﻋ ﺔﺣﺎﺴﻣ ﻲﻓ ﺔﻟﺪﺴﻨﻣ ﺔﻤﺋﺎﻗ) ﺔﻴﻓﺮﻄﻟﺍ ﺕﺎﻈﺣﻼ﻿ﻣ ﺮﺘﻓﺩ
| `SUPER + Space` | مدير الملفات |
| `SUPER + CTRL + Space` | مراقب النظام |
| `SUPER + Shift + D` | قائمة الأجهزة القابلة للإزالة |
| `SUPER + Shift + F` | ARGVUS Focus (جلسات البومودورو والتركيز) |
| `SUPER + Shift + C` | ساعة ARGVUS (الساعة والمؤقتات والمنبهات) |
| `SUPER + D` | مشغل البرنامج |
| `SUPER + B` | المتصفح الافتراضي |
| `SUPER + C` | حاسبة |
| `SUPER + ALT + S` | منتقي مضيف SSH (`argvus ssh`) |
| `SUPER + ALT + N` | منتقي المقتطفات (`argvus snippets`) |
| `SUPER + ALT + G`) ﺭﺎﺘﺨﻤﻟﺍ ﻉﻭﺮﺸﻤﻟﺍ ﻲﻓ (gitui ﻭﺃ lazygit) git ـﻟ ﺔﻴﺼﻨﻟﺍ ﻡﺪﺨﺘﺴﻤﻟﺍ ﺔﻬﺟﺍﻭ ﻢﺛ ،ﻉﻭﺮﺸﻤ`argvus git`) |

### وسائل الإعلام

| الاختصار | الوصف |
| --- | --- |
| `XF86AudioRaiseVolume` | رفع مستوى الصوت |
| `Volume Down` | خفض مستوى الصوت |
| `Mute` | كتم |
| `Brightness Up` | سطوع يصل |
| `Brightness Down` | سطوع أسفل |
| `Play/Pause` | تشغيل/إيقاف مؤقت |
| `Next Track` | المسار التالي |
| `Previous Track` | المسار السابق |
| `Stop` | وقف المسار |

### ﻞﻴﺠﺴﺗﻭ ﺔﺷﺎﺸﻟﺍ ﺕﺎﻄﻘﻟ

| الاختصار | الوصف |
| --- | --- |
| `Print` | التقاط المنطقة المحددة |
| `SUPER + Print` | التقاط نافذة مركزة |
| `SUPER + Shift + Print` | التقاط الشاشة بأكملها |
| `SUPER + G` | بدء تسجيل الشاشة /Pause/Resume |
| `SUPER + Shift + G` | إيقاف وحفظ تسجيل الشاشة |

### جلسة

| الاختصار | الوصف |
| --- | --- |
| `SUPER + L` | نظام القفل |
| `SUPER + escape` | نظام الخروج |
| `SUPER + Shift + R` | تحديث هايبرلاند |
| `SUPER + Shift + S` | إيقاف تشغيل/تشغيل الشاشة (وليس تعليق النظام) |
| `SUPER + Shift + L` | اختر مهلة قفل عدم النشاط |
| `SUPER + ALT + W` | تبديل البقاء مستيقظا |

### النظام

| الاختصار | الوصف |
| --- | --- |
| `SUPER + Shift + /` | أوراق الغش في هايبرلاند |
| `SUPER + CTRL + /` | أوراق غش كيتي |
| `SUPER + F1` | افتح حول ARGVUS |
| `SUPER + ALT + C` | فتح مركز التحكم |
| `SUPER + P` | منتقي الألوان |
| `SUPER + .` | منتقي الرموز التعبيرية |
| `SUPER + H` | تاريخ الحافظة |
| `SUPER + Shift + H` | مسح محفوظات الحافظة |

### الحاجيات

| الاختصار | الوصف |
| --- | --- |
| `SUPER + ,` | فتح/إغلاق الشريط الجانبي للإشعارات |
| `Middle mouse button (mouse:274)` | فتح/إغلاق الشريط الجانبي للإشعارات |
| `SUPER + Backspace` | تبديل أعلى شريط الطريق |
| `SUPER + Shift + W` | تكوين موقع الطقس |
| `SUPER + ALT + Up Arrow` | انقل شريط المهام إلى الأعلى |
| `SUPER + ALT + Down Arrow` | انقل شريط المهام إلى الأسفل |

### المظهر

| الاختصار | الوصف |
| --- | --- |
| `SUPER + Y` | فتح خلفيات مركز التحكم |
| `SUPER + Shift + T` | فتح محدد الموضوع |
| `SUPER + Shift + M` | افتح منتقي الوضع الثابت/المتباعد |
| `SUPER + F5`                          | ﺢﺗﺎﻔﻟﺍ ARGVUS ﻭ ﻦﻛﺍﺪﻟﺍ ARGVUS ﺕﺎﻤﻴﺛ ﻦﻴﺑ ﻞﻳﺪﺒﺘﻟﺍ |
| `SUPER + F6` | تبديل الرسوم المتحركة |
| `SUPER + Shift + B` | فتح محدد السطوع وتبديل الضوء الليلي |

### (SUPER + R ﺪﻌﺑ) ﻢﺠﺤﻟﺍ ﺮﻴﻴﻐﺗ ﻊﺿﻭ

.ﻊﺿﻮﻟﺍ ﻙﺮﺘﻳ Enter ﻭﺃ `Esc` .ﻢﺠﺤﻟﺍ ﺮﻴﻴﻐﺗ ﻊﺿﻭ ﻞﻴﻌﻔﺗ ءﺎﻨﺛ

| الاختصار | الوصف |
| --- | --- |
|  `Enter` `Right Arrow` | Resize |
| `Left Arrow` | تغيير الحجم |
| `Up Arrow` | تغيير الحجم |
| `Down Arrow` | تغيير الحجم |
| `Shift + Right Arrow` | تحريك النافذة |
| `Shift + Left Arrow` | تحريك النافذة |
| `Shift + Up Arrow` | تحريك النافذة |
| `Shift + Down Arrow` | تحريك النافذة |
| `escape` | الخروج من وضع تغيير الحجم |
| `Enter` | الخروج من وضع تغيير الحجم |


راجع [Windows وتخطيط](/docs/argvus-hyprland/hyprland-overrides/) للتعرف على السلوك العائم ومساحة العمل و[مركز التحكم](#default-shortcut-table) للتعرف على سير عمل الإعدادات.

## ﻞﻴﻠﻟﺍ ءﻮﺿ

**SUPER + Shift + B** ءﺍﺮﺟﺈﺑ ﻆﻔﺘﺤﻳ `appearance.brightness` ﻲﻓ ﻉﻮﻄﺴﻟﺍ ﺔﻤﺋﺎﻗ ﻡﺪﻘﻳ ﺎﻤﻛ








##

.ﻡﺎﻋ ﻞﻜﺸﺑ Hyprland ﻰﻠﻋ ﺎﻬﻘﻴﺒﻄﺗ ﻦﻣ ًﻻ﻿ﺪﺑ ،**ﻡﺰﺤﻟﺍ < ﻡﺎﻈﻨﻟﺍ ﺓﺭﺍﺩﺇ < ﻢﻜﺤﺘﻟﺍ ﺰﻛﺮﻣ** `F8`                                                       ،ﺔﻠﻣﺎﻌﻤﻟﺍ ﺔﻄﺤﻣ ﺢﺘﻓ ﺪﻴﻌﻳ`Esc`                                                      ،ﺔﻴﻠﻤﻌﻟﺍ ﻑﺎﻘﻳﺇ ﻥﻭﺩ ﻪﻴﻔﺨﻳ`Shift+PageUp/PageDown`                                                                 ﺮﻳﺮﻤﺘﻟﺍ ﺦﻳﺭﺎﺗ`Shift+End`                                                        ﻭ ﻲﺤﻟﺍ ﺝﺍﺮﺧﻹ﻿ﺍ ﻰﻟﺇ ﺩﻮﻌﻳ`Ctrl+C`                     .ﺢﻴﺗﺎﻔﻤﻟﺍ ﺲﻔﻧ ﺔﺘﺒﺜﻤﻟﺍ ﺶﻐﻟﺍ ﺔﻗﺭﻭ ﻦﻤﻀﺘﺗ .ﺰﻛﺮﻤﻟﺍ ﻞﻔﻄﻟﺍ ﻊﻃﺎﻘﻳ

                                                                     ،ﻡﺰﺤﻟﺍ ﻲﻓ`/`                                               .ﻱﻮﻠﻌﻟﺍ **ﺚﺤﺒﻟﺍ** ﻂﻳﺮﺷ ﻰﻠﻋ ﺰﻛﺮﻳ`Enter`.ﺔﺑﺎﺘﻜﻟﺍ ءﺎﻨﺛﺃ ﺚﻳﺪﺤﺘﻟﺍﻭ ﺔﻟﺍﺯﻹ﻿ﺍ ﻢﺋﺍﻮﻗ ﺔﻴﻔﺼﺗ ؛ AUR / ﻲﻤﺳﺮﻟﺍ ﺖﻴﺒﺜﺘﻟﺍ ﻦﻋ ﺚﺤﺒﻟﺍ ﺕﺎﻴ`Down`                                                            ،ﺞﺋﺎﺘﻨﻟﺍ ﻰﻟﺇ ﻞﻘﺘﻨﻳ`Up`                                           ﻭ ،ﺚﺤﺒﻟﺍ ﻰﻟﺇ ﺩﻮﻌﻳ ﻰﻟﻭﻷ﻿ﺍ ﺔﺠﻴﺘﻨﻟﺍ ﻰﻠﻋ`Esc`.ﺎﻬﺑ ﺔﺻﺎﺨﻟﺍ ﺔﻣﺰﺤﻟﺍ ءﺍﺮﺟﺇ ﺬﻔﻨﻳ ﺔﺠﻴﺘﻧ ﻰﻠﻋ ﻂﻐﻀﻟﺍ .ﺔﻤﺋﺎﻘﻟﺍ ﻰﻟﺇ ﺩﻮﻌﻳﻭ ﻡﻼ﻿ﻌﺘﺳﻻ﻿ﺍ ﻆﻔﺤﻳ

قم بتشغيل argvus إنشاء اختصارات مركز التحكم أو argvus قائمة اختصارات مركز التحكم لفتح أي من الصفحتين. بالنسبة للخرائط الفرعية المتقدمة أو روابط الماوس أو العلامات، تظل [الارتباطات.lua](/docs/argvus-hyprland/windows-and-layout/) متاحة. لا تقم أبدًا بتحرير الأجزاء التي تم إنشاؤها.

تتضمن بعض الإجراءات المضمنة المفيدة نقل التركيز ومساحات العمل، وتبديل النوافذ العائمة، ولقطات الشاشة والتسجيل، وفتح المشغل/المحطة، وتغيير المظهر، وقفل الجلسة، والتحكم في الوسائط، وإعادة تحميل Hyprland. الارتباطات الافتراضية مدرجة في [جدول الاختصار الافتراضي](/docs/components/argvus-control-center/) أدناه؛ تعرض صفحة مركز التحكم الارتباطات كما تم تكوينها حاليًا.
