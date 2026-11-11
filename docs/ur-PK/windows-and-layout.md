---
title: Windows and layout
description: ARGVUS ۔ﮟﯿﮭﺠﻤﺳ ﻮﮐ ﮧﮕﺟ ﯽﮐ ﻞﻨﯿﭘ ﺭﻭﺍ ﮞﻮﻘﯾﺮﻃ ،ﺩﻭﺪﺣ ،ﮞﻮﺠﯿﻠﺧ ﮟﯿﻣ
---

ARGVUS ﮯﯿﻟ ﮯﮐ ﻦﺸﯾﺯﻮﭘ ﯽﮐ ﻭﮉﻧﻭ ﮓﻨﭨﻮﻠﻓ ﺭﻭﺍ ﮉﻠﺋﺎﭨ Hyprland ﭧﭘ ﻥﺍ ﺭﻭﺍ ﭖﺎﭨ ﮏﺴﯾﮈ → ﺮﭩ

##                                                                         ﺕﺍﺭﻮﺼﺗ

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```

- ۔ﮯﮨ ﯽﺗﻮﮨ ﻥﺎﯿﻣﺭﺩ ﮯﮐ ﮮﺭﺎﻨﮐ ﯽﻧﻭﺮﯿﺑ ﮯﮐ ﭦﺅﺁ ﮯﻟ ﮦﺪﺷ ﻞﺋﺎﭨ ﺭﻭﺍ ﮞﻮﯿﮐﮍﮭﮐ ﮦﺪﺷ ﻞﺋﺎﭨ ﻮﺟ ﮯﮨ 
- ۔ﮯﮨ ﮟﯿﮩﻧ ﯼﻭﺎﺴﻣ ﮯﮐ ﭗﯿﮔ ﮯﮐ ﻭﮉﻧﻭ ﮧﯾ ۔ﮯﮨ ﻦﺟﺭﺎﻣ ﺎﮐ ﺩﺮﮔ ﺩﺭﺍ ﮯﮐ ﻞﻨﯿﭘ ﺭﻭﺍ ﺭﺎﺑ ﮏﺳﺎﭨ ﮯﺴﯿ
- ۔ﮯﮨ ﯽﺗﺮﮐ ﻝﻭﺮﭩﻨﮐ ﻮﮐ ﯽﺋﺍﮌﻮﭼ ﯽﮐ ﺪﺣﺮﺳ ﯽﻟﺍﻭ ﮯﻧﺎﺟ ﯽﺋﺎﮭﮐﺩ ﮯﺳ ﺐﻧﺎﺟ ﯽﮐ ﮧﺤﻔﺻ ﯼﺮﮨﺎﻇ **ﯽﺋﺎ
- ۔ﮯﮨ ﯽﺘﯾﺩ ﺖﮐﺮﺣ ﻮﮐ ﻭﮉﻧﻭ ﮧﮐ ﮧﻧ ﮯﮨ ﯽﺘﻟﺪﺑ ﻞﮑﺷ ﯽﮐ ﮯﻧﻮﮐ ﮯﮐ ﻭﮉﻧﻭ ﮧﯾ ۔ﮯﮨ ﮧﺼﺣ ﺎﮐ ﮈﻮﻣ ﯼﺮﺼ
- ۔ﮯﮨ ﺎﺘﯾﺩ ﺐﯿﺗﺮﺗ ﻖﺑﺎﻄﻣ ﮯﮐ ﭧﯿﭩﺳﺍ ﮓﻨﺴﯿﭙﺳﺍ ﻝﺎﻌﻓ ﻮﮐ ﮞﻮﯿﮐﮍﮭﮐ ﯽﮭﺑ ﺏﺍ Hyprland ﮧﮑﺒﺟ ﮯﮨ 

##                                                       ﺯﮈﻮﻣ ﮯﻟﺍﻭ ﮯﻔﻗﻭ ﺭﻭﺍ ﺎﭙﭽﭙﭼ

                   :ﮟﯿﮨ ﮯﺗﺮﮐ ﻢﮨﺍﺮﻓ ﮞﺎﯾﺮﭩﯿﻣﻮﯿﺟ ﯽﺋﺍﺪﺘﺑﺍ ﻭﺩ ﺯﮈﻮﻣ ﻢﯿﮭﺗ ﮯﺌﮔ ﮯﯿﮐ ﺪﻨﺑ

| Mode | Window behavior | Surface treatment |
| --- | --- | --- |
                                                         ءﻼ﻿ﺧ ﯽﻧﻭﺭﺪﻧﺍ | ﺎﭙﭽﭙﭼ |`2`                                                                   ﻼ﻿ﺧ ﯽﻧﻭﺮﯿﺑ ،`0`                     | ﺐﯾﺮﻗ ﮯﮐ ﮮﺭﺎﻨﮐ ﮯﮐ ﻦﯾﺮﮑﺳﺍ ﺭﻭﺍ ﭧﮑﯿﭙﻤﮐ ،ﯽﻌﺑﺮﻣ | ﭧﻟﺎﻔﯾﮈ ﺭﻮﻄﺑ
                                                     ءﻼ﻿ﺧ ﯽﻧﻭﺭﺪﻧﺍ | ﻻ﻿ﺍﻭ ﮯﻠﺻﺎﻓ |`10`                                                                   ﻼ﻿ﺧ ﯽﻧﻭﺮﯿﺑ ،`18` ﮯﮨ ﺭﺪﻗ ﭧﻟﺎﻔﯾﮈ ﯽﮐ ﻦﺟﺭﺎﻣ ﻞﯿﺷ/ﺭﺎﺑ ﮏﺳﺎﭨ ؛ﻊﯿﺳﻭ ﮦﺩﺎﯾﺯ ﺭﻭﺍ ﺭﺍﺩ ﮯﺋﺎﺳ ،ﻝﻮﮔ | ﭧﻟﺎﻔﯾﮈ ﺭﻮ`18` |

۔ﮟﯿﮨ ﯽﺘﮑﺳ ﻮﮨ ﺮﮨﺎﻇ ﮟﯾﺭﺪﻗ ﯽﮐ ﭦﺅﺁ ﮯﻟ ﺮﺛﺆﻣ ﻒﻠﺘﺨﻣ ﮯﺳ ﮯﻧﺮﮐ ﻞﯾﺪﺒﺗ ﻮﮐ

## ﺰﻟﻭﺮﭩﻨﮐ ﭦﺅﺁ ﮯﻟ

:ﮯﮨ ﺩﻮﺟﻮﻣ ﺮﭘ ﮯﺤﻔﺻ ﯽﺌﮔ ﯼﺩ ﮞﺎﮩﯾ ﺭﻭﺍ ﮯﮨ ﺩﺍﺯﺁ ﻝﻭﺮﭩﻨﮐ ﺮﮨ

- ۔ﺐﻧﺎﺟ ﯽﮐ ﮯﭽﯿﻧ ﺎﯾ ﺮﭘﻭﺍ ،ﻡﺎﻘﻣ ﺎﮐ ﺭﺎﺑ ﮏﺳﺎﭨ — **ﻡﺎﻘﻣ → ﺭﺎﺑ ﮏﺳﺎﭨ**
- ﮯﺳ ﮏﯾﺍ ﺮﮨ ،ﺰﻨﺟﺭﺎﻣ ﮯﮐ ﮯﭽﯿﻧ ﺭﻭﺍ ﮟﯿﺋﺍﺩ ،ﮟﯿﺋﺎﺑ ،ﺮﭘﻭﺍ ﮯﮐ ﺭﺎﺑ ﮏﺳﺎﭨ — **ﺰﺴﯿﭙﺳﺍ → ﺭﺎﺑ `0` to `100`                                         ﮯﮨ ﺎﺗﺮﮐ ﭧﻟﺎﻔﯾﮈ ﻮﮐ ﻦﺟﺭﺎﻣ ﮟﯿﺋﺎﺑ ﯽﮑﭩﺳﺍ .`2`                                                      ﮯﮨ ﺎﺗﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﮉﺴﯿﭙﺳﺍ ;`18`.
- ۔ﮯﮨ ﺎﺗﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﻮﮐ ﮯﯾﻭﺭ ﯽﺋﻮﮨ ﯽﻠﯿﮭﭘ ﮧﺸﯿﻤﮨ ﺎﯾ ﺭﺎﮐﺩﻮﺧ ﭖﻭﺮﮔ ﯽﭩﯿﻠﯿﭨﻮﯾ ﺭﺎﺑ ﮏﺳﺎﭨ ﺎﯾﺁ
- **Hyprland → Windows → Spaces** — inner gap and outer top/left/right/bottom gaps, each from 

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

 to 

.
- **Hyprland → Borders** — general borders: enable rounded corners; when enabled, rounding is selectable from 

 to 

. Edge thickness is set here too, from 

 to  100  `0`  `100` `2`.
- **Hyprland → Borders → Shadow** — the window shadow, off by default. It sets the range, render power, sharp corners, offsets and scale, and its color follows the theme accent with alpha  `10`  `0`  `10` `99` unless a color is typed.

۔ﺎﺘﻟﺪﺑ ﮟﯿﮩﻧ ﺍﺮﺳﻭﺩ ﮯﺳ ﮯﻧ

## ﺰﺴﯿﭙﺳﺍ ﮎﺭﻭ ﺭﻭﺍ ﺯﻭﮉﻧﻭ







 argvus-clock-alarm  1399 × 920  SUPER + SHIFT + Space  `argvus-config`  `SUPER + SHIFT + Space`  `1399 × 920`  `argvus-clock-alarm` `hyprpicker`، ﻮﺟ `SUPER + P` ﺎﯿﮔ ﻻ﻿ﻮﮭﮐ ﮫﺗﺎﺳ ﮯﮐ، Hyprland ۔ﮟﯿﮨ ﯽﺘﮭﮐﺭ 

###                                 ﮧﮕﺟ ﯽﮐ ﺲﯿﭙﺳﺍ ﮎﺭﻭ ﮯﯿﻟ ﮯﮐ ﺰﯾﺍ ﯼﮈ ﯽﺋﺁ ﺭﻭﺍ ﺯﺭﺯﺅﺍﺮﺑ

## ﮯﮨ ﺎﻧﺮﮐ ﻞﯾﺪﺒﺗ ﺎﯿﮐ ﮯﻠﮩﭘ ﮯﺳ ﺐﺳ

- ۔ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﮈﻮﻣ ﮉﺴﯿﭙﺳﺍ ﺎﯾ ﮟﯿﺋﺎﮬﮍﺑ ﻮﮐ ﮯﻠﺻﺎﻓ ﮯﮐ ﻭﮉﻧﻭ ﻮﺗ ﮟﯿﮕﻟ ﯽﺋﻮﮨ ﯼﺮﮭﺑ ﺯﻭﮉﻧﻭ ﺮ
- ۔ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﮈﻮﻣ ﯽﮑﯿﭩﺳﺍ ﺎﯾ ﮟﯾﺮﮐ ﻢﮐ ﮧﮕﺟ ﯽﮐ ﺭﺎﺑ ﮏﺳﺎﭨ/ﯽﻧﻭﺮﯿﺑ ﻮﺗ ،ﮟﯿﮨ ﯽﮨﺭ ﮓﻟ ﺭﻭﺩ 
- ۔ﮟﯿﮭﮑﯾﺩ ﮫﺗﺎﺳ ﮏﯾﺍ ﻮﮐ ﻦﺟﺭﺎﻣ ﮯﮐ ﻞﯿﺷ/ﺭﺎﺑ ﮏﺳﺎﭨ ﮞﻭﺭﺎﭼ ﺭﻭﺍ ﻦﺸﯾﺯﻮﭘ ﯽﮐ ﺭﺎﺑ ﮏﺳﺎﭨ ﻮﺗ ﮯﺋﺁ 
- ۔ﮟﯾﺮﮐ ﮏﯿﭼ ﺕﺎﺒﯿﺗﺮﺗ ﯽﮐ ﺐﯿﺗﺮﺗ ﯽﮐ ﺭﺎﺑ ﮏﺳﺎﭨ ﺭﻭﺍ ﻞﻨﯿﭘ ﮯﻠﮩﭘ ﮯﺳ ﮯﻧﺮﮐ ﻞﯾﺪﺒﺗ ﺲﭙﯿﮔ ﻭﮉﻧﻭ ،

۔ﮟﯾﺮﮐ ﮧﻧ ﻢﯿﻣﺮﺗ ﺖﺳﺍﺭ ﮦﺍﺮﺑ ﮟﯿﻣ ﮞﻮﻠﺋﺎﻓ Hyprland ﮦﺪﺷ ﺍﺪﯿﭘ ؛ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﯽﺋﺍﻭﺭﺭﺎﮐ ﯽ

## Related

-                                                   (/docs/user-guide/appearance/)[ﺕﺎﻋﻮﺿﻮﻣ]

##                                                                     ﺎﻨﻠﮨ ﯽﮐﮍﮭﮐ

  ﮟﯾﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﺭﻭﺍ **ﺯﻭﮉﻧﻭ → ﺰﻨﺸﯿﻤﯿﻨﯾﺍ → ﮉﻨﯿﻟﺮﭙﺋﺎﮨ → ﭧﭘ ﻥﺍ ﺭﻭﺍ ﭖﺎﭨ ﮏﺴﯾﮈ** ﻦﭘﻭﺍ

```sh
argvus control-center hyprland animations windows
```

ﮟﯿﮨ  ﮓﻨﭙﻤﯾﮈ ، `hyprland.window_rules`  `argvus-config`  `workspace`  `classes`  `classes`  `[Cc]ode.*`  `jetbrains-.*`  `._*+?-[]()|^$`  `argvus-config`  `generated/hypr/window-rules.lua`  `hl.window_rule`  `rules.lua`  `wobble` `100` ﯽﺘﺨﺳ ﺲﭩﻟﺎﻔﯾﮈ ﮯﮐ ARGVUS ﮯﮐ ﺱﺍ ۔ﮯ
`10`, mass `1`, intensity `1`                                                              ﻢﯿﺴﻘﺗ ﯽﮐ ﻝﺎﺟ ﺭﻭﺍ`8`                                                        ﮟﯾﺮﮐ ﻝﻮﺒﻗ ﺱﺎﻣ ﺭﻭﺍ ﯽﺘﺨﺳ
`0.0001–1000`, damping `0–1000`, intensity `0–2`, and mesh an integer `2–32`.
ﮟﯾﺮﮐ ﭧﺴﺟﮉﯾﺍ ﮯﮐ ﺮﮐ ﻝﺎﻤﻌﺘﺳﺍ ﺎﮐ ﺰﯿﮐ ﺯﻭﺮﯾﺍ ۔ﮯﮨ ﺎﺗﺎﮬﮍﺑ ﺕﺎﺟﺍﺮﺧﺍ ﮯﮐ ﮓﻧﺭﮉﻨﯾﺭ ﻦﺷﻮﻟﻭﺰﯾﺭ 
؛ﮯﮨ ﺎﺗﺮﮐ ﻞﯾﺪﺒﺗ ﻮﮐ ﭧﻓﺍﺭﮈ **ﮟﯾﺮﮐ ﻝﺎﺤﺑ ﻮﮐ ﺲﭩﻟﺎﻔﯾﮈ Wobble** ۔ﮟﯿﺋﺎﺑﺩ ﺮﭩﻧﺍ ﮯﯿﻟ ﮯﮐ ﮯﻧ
**Apply** ﺭﻭﺍ ﮯﮨ ﺎﺗﺮﮐ ﻅﻮﻔﺤﻣ ﻮﮐ ﺲﭨﮉﯾﺍ ﻦﺸﯿﻤﯿﻨﯾﺍ ﺍﻮﺘﻟﺍ ﺮﯾﺯ ﻡﺎﻤﺗ Hyprland ﺮﯿﻐﺑ ،ﮯﮨ
۔ﮯﮨ ﺎﺘﮨﺭ ﺭﺍﺮﻗﺮﺑ ﭧﻓﺍﺭﮈ ﮧﮐﺮﺘﺸﻣ ﮯﺳ ﮯﻧﺎﺟ ﺲﭘﺍﻭ ﺭﺪﻧﺍ ﮯﮐ ﺰﻨﺸﯿﻤﯿﻨﯾﺍ ۔ﺎﻧﺮﮐ ﻉﻭﺮﺷ ﮦﺭﺎﺑﻭﺩ 

ﮯﮨ ﺎﺘﮭﮐﺭ ﺭﺍﺮﻗﺮﺑ ﻮﮐ ﺕﺎﯿﺻﻮﺼﺧ ﯼﺩﺍﺮﻔﻧﺍ ﮯﮐ ﺱﺍ ﮧﮑﺒﺟ ﮯﮨ ﺎﺘﯾﺩ ﺎﺑﺩ ﻮﮐ ﻞﺑﻭ ﭻﺋﻮﺳ ﺰﻨﺸﯿﻤﯿﻨﯾ
     ؛ﮟﯿﮨ ﺩﻮﺟﻮﻣ ﺖﺤﺗ ﮯﮐ `effects.wobble_*` ﮟﯿﻣ ﺖﺳﺎﯾﺭ ARGVUS ﺭﺍﺪﻗﺍ ﯼﺭﺎﯿﻌﻣ ۔ﺰﮕﻨﭩﯿﺳ
`hypr/state.lua` ۔ﮯﯿﮨﺎﭼ ﺎﻧﺎﺟ ﺎﯿﮐ ﮟﯿﮩﻧ ﻢﯿﻣﺮﺗ ﺮﭘ ﺭﻮﻃ ﯽﺘﺳﺩ ﮯﺳﺍ ﺭﻭﺍ ﮯﮨ ﺎﯿﮔ ﺎﯿﮐ ﺍﺪ

ﮯﮨ ﺎﯿﮔ ﺎﯿﮐ ﺬﻓﺎﻧ ﮧﻌﯾﺭﺫ ﮯﮐ `argvus-hyprland` ﮯﺴﺟ ،ﮯﮨ ﺕﺭﻭﺮﺿ ﯽﮐ **ﺪﯾﺪﺟ ﺎﯾ Hyprland
               ۔ﮯﮨ ﮧﺘﻓﺎﯾ ﺖﯾﺎﻤﺣ ﺮﯿﻏ 0.56 ﻥﮊﺭﻭ ﮯﯿﻟ ﮯﮐ ﻦﺸﯾﺮﮕﯿﻔﻨﮐ ﺱﺍ ۔ﺭﺎﺼﺤﻧﺍ ﺞﯿﮑﯿﭘ
                                                          ﮯﮨ ﺎﺗﺮﮐ ﺩﻭﺪﺤﻣ ﮯﺳﺍ ﻮﺟ`2`                                     ﮯﮨ ﺎﺘﮑﺳ ﻮﮨ ﺝﺭﺩ ﮟﯿﻣ ﺕﺍﺰﯾﻭﺎﺘﺳﺩ ﮯﺌﻧ ﮧﮑﻧﻻ﻿ﺎﺣ ،`3`.

##                                                                 ﮈﻮﻣ ﻭﮉﻧﻭ ﻞﺑﻮﻠﮔ





`SUPER + SHIFT + Space` ؛ﮯﮨ ﯽﺘﮭﮐﺭ ﯼﺭﺎﺟ ﻮﮐ ﮯﯾﻭﺭ ﮯﮐ ﻝﻮﻤﻌﻣ ﮯﮐ ﮉﻨﯿﻟﺮﭙﺋﺎﮨ ﻦﯾﺮﮑﺳﺍ ﻞﻓ ۔ﺎﺗﮍﭘ



۔ﮯﮨ ﯽﺗﺎﺟ ﻮﮨ ﻅﻮﻔﺤ

## ﺭﺎﺑ ﯽﮐ ﺖﺳﺍﻮﺧﺭﺩ ﺭﻭﺍ ﻦﭩﺑ ﻭﮉﻧﻭ





 $XDG_RUNTIME_DIR/argvus  data/generated/hypr/window-mode.lua  $XDG_CONFIG_HOME/argvus/config/hyprland.json  `/hyprland/window_mode`  `$XDG_CONFIG_HOME/argvus/config/hyprland.json`  `data/generated/hypr/window-mode.lua`  `$XDG_RUNTIME_DIR/argvus` `SUPER + Alt + Up`                              ۔ﮯﮨ ﺎﺘﮭﮐﺭ ﮯﭽﯿﻧ ﻮﮐ ﺭﺎﺑ ﻭﮉﻧﻭ ﺭﻭﺍ ﺮﭘﻭﺍ ﻮﮐ ﺭﺎﺑ ﯼﺰﮐﺮﻣ`SUPER + Alt + Down`۔ﮯﮨ ﺎﺘﮭﮐﺭ ﺭﺍﺮﻗﺮﺑ ﻮﮐ ﯽﺴﯿﻟﺎﭘ ﮓﻨﭨﻮﻠﻓ/ﮦﺪﺷ ﻞﺋﺎﭨ ﻞﺻﺍ ﺮﮭﭘ ﺭﻭﺍ ،ﮯﺳ ﮯﻧﺎﭩﮨ ﻮﮐ ﺭﺎﺑ ﻭﮉﻧﻭ ﮯ

Minimization uses the reserved 

 workspace. Do not use that workspace manually. The 

 process records identity, original workspace/monitor, geometry, fullscreen/maximization and pin state in a compositor-instance-specific runtime registry under 

. Records survive a service restart or config reload, but do not cross compositor sessions. Closing a window removes its record. If a monitor disappears, restoration uses an available output. A missing or failed recovery bar prevents new minimizations; failed restoration retains the record and recovery bar.



Commands: 

, 

, 

, `special:argvus-minimized`, and `argvus windows service`. The window addresses come from the list. `$XDG_RUNTIME_DIR/argvus` position top --persist  minimize|restore|activate|maximize|close ADDRESS  restore-all  position top|bottom  watch --json  argvus windows list --json  argvus-hyprland  argvus-window-bar.service  `argvus-windows.service`  stores/projects the preference without restarting the main bar. Configuration and runtime error details are written to the journal; visible action failures also show a translated notification.

In **Spaced + Floating**، ۔ﮯﮨ ﺎﺘﮭﭩﯿﺑ ﺭﺪﻧﺍ ﮯﮐ ﺭﮈﺭﺎﺑ ﻭﮉﻧﻭ ﯽﺳﺍ ﻮﺟ ،ﮟﯿﮨ ﻞﻣﺎﺷ ﻞﭩﺋﺎﭨ

 `argvus-window-bar.service`  `argvus-hyprland`  `argvus windows list --json`  `watch --json`  `position top|bottom`  `restore-all`  `minimize|restore|activate|maximize|close ADDRESS`  `position top --persist` `SUPER + Alt + Space` ﮯﮨ ﮉﻧﺎﻤﮐ ﯼﻭﺎﺴﻣ ۔ﮯﮨ ﯽﺗﻮﮨ ﻝﺎﻤﻌﺘﺳﺍ ﺢﯿﺟﺮﺗ ﯽﮨﻭ ﯽﮐ ﺮﭩﻨﯿﺳ ﻝﻭﺮﭩﻨﮐ ﺭﻭﺍ ﺭﺎﺑ ﮏﺳﺎﭨ ﮟﯿﻣ ﺲﺟ`argvus config window-mode toggle` ؛ﮯﮨ ﺎﺘﮑﺳ ﺎﺟ ﺎﯿﮐ ﻝﺎﻌﻓ ﺮﯿﻏ ﺎﯾ ﻞﯾﺪﺒﺗ ﻮﮐ ﭧﮐ ﭦﺭﺎﺷ ﮟﯿﻣ ﺲﭩﮐ ﭦﺭﺎﺷ ﮈﺭﻮﺑ ﯽﮐ ۔ﮯﮨ ﯽﺗﺮﮐ ﻝﺎ`SUPER + Shift + Space`                                        ۔ﮯﮨ ﺎﺘﮭﮐﺭ ﺭﺍﺮﻗﺮﺑ ﻮﮐ ﻞﻤﻋ ﻭﮉﻧﻭ ﯼﺩﺮﻓ ﮯﻨﭘﺍ

Each rule has a workspace from 1 to 10 and a classes list. Entries in classes are regular expressions matched against the window class (case sensitive), for example [Cc]ode.* or jetbrains-.*. Only letters, digits and ._*+?-|^$ are accepted. argvus-config writes the rules to generated/hypr/window-rules.lua, which the Hyprland configuration loads. To replace the rules without changing the defaults, add hl.window_rule calls to rules.lua in your ARGVUS data directory; those load after the generated rules.

Each rule has a workspace from 1 to 10 and a classes list. Entries in classes are regular expressions matched against the window class (case sensitive), for example [Cc]ode.* or jetbrains-.*. Only letters, digits and ._*+?-|^$ are accepted. argvus-config writes the rules to generated/hypr/window-rules.lua, which the Hyprland configuration loads. To replace the rules without changing the defaults, add hl.window_rule calls to rules.lua in your ARGVUS data directory; those load after the generated rules.
 for the installed and user paths. for the installed and user paths.(https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),

Tiled windows are arranged by Hyprland on the active workspace. ARGVUS also supports floating utility windows; SUPER + SHIFT + Space toggles the focused window between tiled and floating layouts. Workspace movement and window focus are controlled by the active keybinding manifest; see [Keyboard shortcuts](/docs/argvus-hyprland/keyboard-shortcuts/).
- [                                                                     ﻞﮑﺷ ﯼﺮﮨﺎﻇ](/docs/user-guide/appearance/)
- [                                                                       ﺕﺎﻋﻮﺿﻮﻣ](/docs/user-guide/appearance/)
- [                                                                      ﺭﺎﺑ ﮏﺳﺎﭨ](/docs/argvus-taskbar/taskbar/)
- [                                                                   ﻞﻨﯿﭘ ﻝﻭﺮﭩﻨﮐ](/docs/argvus-control-panel/)
                                                     ﺪﻌﺑ ﮯﮐ ﮦﺩﺎﯾﺯ ﮯﺳ ﮦﺩﺎﯾﺯ ﺕﺪﺷ[                                                            ﺬﺧﺎﻣ 0.57.0 ﯽﺗﺭﺍﺪﺻ](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
