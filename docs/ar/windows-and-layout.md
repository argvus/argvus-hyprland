---
title: Windows and layout
description:                        .ARGVUS ﻲﻓ ﺕﺎﺣﻮﻠﻟﺍ ﺔﺣﺎﺴﻣﻭ ﺐﻴﻟﺎﺳﻷ﻿ﺍﻭ ﺩﻭﺪﺤﻟﺍﻭ ﺕﺍﻮﺠﻔﻟﺍ ﻢﻬﻓﺍ
---

.**ﺩﻭﺪﺤﻟﺍ → Hyprland → ﻝﺎﺧﺩﻹ﻿ﺍﻭ ﺐﺘﻜﻤﻟﺍ ﺢﻄﺳ → ﻢﻜﺤﺘﻟﺍ ﺰﻛﺮﻣ**ﻭ **ﺕﺎﺣﺎﺴﻤﻟﺍ → ﺬﻓﺍﻮﻨﻟ

##                                                                       ﻢﻴﻫﺎﻔﻤﻟﺍ

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```

- .ﺞﺟﺰﻤﻟﺍ ﻢﻴﻤﺼﺘﻠﻟ ﺔﻴﺟﺭﺎﺨﻟﺍ ﺔﻓﺎﺤﻟﺍﻭ ﺔﺠﺟﺰﻤﻟﺍ ﺬﻓﺍﻮﻨﻟﺍ ﻦﻴﺑ ﺔﻓﺎﺴﻤﻟﺍ ﻲﻫ **ﺬﻓﺍﻮﻨﻟﺍ ﺕﺍﻮﺠ
- .ﺓﺬﻓﺎﻨﻟﺍ ﺓﻮﺠﻓ ﺔﻤﻴﻗ ﺲﻔﻧ ﺖﺴﻴﻟ ﺎﻬﻧﺇ .ﺔﺣﻮﻠﻟﺍﻭ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﻞﺜﻣ ﺐﺘﻜﻤﻟﺍ ﺢﻄﺳ ﺢﻄﺳﺃ ﻝﻮﺣ 
- .ﺮﻬﻈﻤﻟﺍ ﺔﺤﻔﺻ ﻲﻓ ﺔﺿﻭﺮﻌﻤﻟﺍ ﺩﻭﺪﺤﻟﺍ ﺽﺮﻋ ﻲﻓ ﻢﻜﺤﺘﻳ **ﺔﻓﺎﺤﻟﺍ ﻚﻤﺳ** .ﺓﺬﻓﺎﻨﻟﺍ ﻝﻮﺣ ﺔﻣﻮﺳﺮ
- .ﺓﺬﻓﺎﻨﻟﺍ ﻚﻳﺮﺤﺗ ﻦﻣ ًﻻ﻿ﺪﺑ ﺓﺬﻓﺎﻨﻟﺍ ﺔﻳﻭﺍﺯ ﻞﻜﺷ ﺮﻴﻐﻳ ﻪﻧﺇ .ﺩﺪﺤﻤﻟﺍ ﺽﺮﻌﻟ
- .ﻂﺸﻨﻟﺍ ﺪﻋﺎﺒﺘﻟﺍ ﺔﻟﺎﺤﻟ ﺎًﻘﻓﻭ ﺬﻓﺍﻮﻨﻟﺍ ﻢﻈﻨﻳ Hyprland ﻞﻈﻳ ﺎﻤﻨﻴﺑ ﺎًﻳﺮﺼﺑ ﺔﺣﺎﺴﻤﻟﺍ ﻡﺪﺨﺘﺴﺗ

##                                                       ﺔﻗﺮﻔﻤﻟﺍﻭ ﺔﻘﺻﻼ﻿ﻟﺍ ﺕﺎﻴﻌﺿﻮﻟﺍ

                                 :ﻦﻴﺘﻴﺋﺍﺪﺘﺑﺍ ﻦﻴﺘﺳﺪﻨﻫ ﺔﻌﻤﺠﻤﻟﺍ ﺕﺎﻤﺴﻟﺍ ﻉﺎﺿﻭﺃ ﺮﻓﻮﺗ

| Mode | Window behavior | Surface treatment |
| --- | --- | --- |
                                                          ﺔﻴﻠﺧﺍﺩ ﺓﻮﺠﻓ | ﺖﺑﺎﺛ |`2`                                                             ﺔﻴﺟﺭﺎﺨﻟﺍ ﺓﻮﺠﻔﻟﺍ ،`0`                                 | ﺔﺷﺎﺸﻟﺍ ﺔﻓﺎﺣ ﻦﻣ ﺐﻳﺮﻗﻭ ﻁﻮﻐﻀﻣ ،ﻊﺑﺮﻣ | ﺎًﻴﺿﺍﺮﺘﻓﺍ
                                                        ﺔﻴﻠﺧﺍﺩ ﺓﻮﺠﻓ | ﺪﻋﺎﺒﺘﻣ |`10`                                                             ﺔﻴﺟﺭﺎﺨﻟﺍ ﺓﻮﺠﻔﻟﺍ ،`18`  ﻰﻟﺇ ﺔﻴﺿﺍﺮﺘﻓﻻ﻿ﺍ ﻑﺪﺼﻟﺍ/ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﺔﻓﺎﺣ ؛ﺎًﻋﺎﺴﺗﺍ ﺮﺜﻛﺃﻭ ﻝﻼ﻿ﻇ ﻊﻣ ،ﺮﻳﺪﺘﺴﻣ | ﺎًﻴﺿﺍﺮﺘﻓﺍ`18` |

.ﺔﻟﺎﻌﻓﻭ ﺔﻔﻠﺘﺨﻣ ﻂﻴﻄﺨﺗ ﻢﻴﻗ ﺽﺮﻌﻳ ﻥﺃ ﻊﺿﻮﻟﺍ ﻭﺃ ﺔﻤﺴﻟﺍ ﺮﻴﻴﻐﺘﻟ ﻦﻜﻤﻳ .ﻞﻘﺘﺴﻣ ﻞﻜﺸﺑ ﻡﺎﻬﻤﻟﺍ

##                                                                  ﻂﻴﻄﺨﺘﻟﺍ ﻂﺑﺍﻮﺿ

                             :ﺎﻨﻫ ﺓﺭﻮﻛﺬﻤﻟﺍ ﺔﺤﻔﺼﻟﺍ ﻰﻠﻋ ﺶﻴﻌﻳﻭ ﻞﻘﺘﺴﻣ ﻢﻜﺤﺗ ﺮﺼﻨﻋ ﻞﻛ

-          .ﻰﻠﻔﺴﻟﺍ ﻭﺃ ﺎﻴﻠﻌﻟﺍ ﺔﻓﺎﺤﻟﺍ ،ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﻊﻗﻮﻣ — **ﻊﻗﻮﻤﻟﺍ → ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ**
- ﻦﻣ ﺎﻬﻨﻣ ﻞﻛ ،ﻞﻔﺳﻷ﻿ﺍﻭ ﻦﻤﻳﻷ﻿ﺍ ،ﺮﺴﻳﻷ﻿ﺍ ،ﻰﻠﻋﻷ﻿ﺍ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ — **ﺕﺎﺣﺎﺴﻤﻟﺍ → ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ*`0` to `100`                                       ـﺑ ﺎًﻴﺿﺍﺮﺘﻓﺍ ﻲﻠﻔﺴﻟﺍ ﺶﻣﺎﻬﻟﺍ Sticky ﺩﺪﺤﻳ .`2`                                                               Spaced ﻡﺪﺨﺘﺴﻳ ;`18`.
- .ﺎًﻤﺋﺍﺩ ﻊﺳﻮﻤﻟﺍ ﻙﻮﻠﺴﻟﺍ ﻭﺃ ﻲﺋﺎﻘﻠﺘﻟﺍ ﻙﻮﻠﺴﻟﺍ ﻡﺪﺨﺘﺴﺗ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﺕﺍﻭﺩﺃ ﺔﻋﻮﻤﺠﻣ ﺖﻧﺎﻛ ء
- **Hyprland → Windows → Spaces** — ﻦﻣ ﺓﺪﺣﺍﻭ ﻞﻛ ،ﻞﻔﺳﺃ/ﻦﻴﻤﻳ/ﺭﺎﺴﻳ/ﻰﻠﻋﺃ ﺔﻴﺟﺭﺎﺨﻟﺍ ﺕﺍ`0` to `100`.
- **Hyprland → ﻦﻣ ﺐﻳﺮﻘﺘﻟﺍ ﺭﺎﻴﺘﺧﺍ ﻦﻜﻤﻳ ،ﻞﻴﻌﻔﺘﻟﺍ ﺪﻨﻋ ؛ﺓﺮﻳﺪﺘﺴﻤﻟﺍ ﺎﻳﺍﻭﺰﻟﺍ ﻞﻴﻌﻔﺗ :ﺔﻣﺎ`2` to `10`                                             ﻦﻣ ،ﺔﻓﺎﺤﻟﺍ ﻚﻤﺳ ﻂﺒﺿ ﺎًﻀﻳﺃ ﻢﺘﻳ ﺎﻨﻫ .`0` to `10`.
- **Hyprland → Borders → Shadow** — ﺔﻴﻓﺎﻔﺸﻟﺍ ﻊﻣ ﻢﻴﺜﻟﺍ ﻲﻓ ﺰﻴﻴﻤﺘﻟﺍ ﻥﻮﻟ ﻊﺒﺘﻳ ﻪﻧﻮﻟﻭ `99`                                                          .ﻥﻮﻟ ﺔﺑﺎﺘﻛ ﻢﺘﻳ ﻢﻟ ﺎﻣ

.ﺮﺧﻵ﻿ﺍ ﺮﻴﻐﻳ ﻻ﻿ ﺎﻤﻫﺪﺣﺃ ﺮﻴ

## ﻞﻤﻌﻟﺍ ﺕﺎﺣﺎﺴﻣﻭ ﺬﻓﺍﻮﻨﻟﺍ







 argvus-clock-alarm  1399 × 920  SUPER + SHIFT + Space  `argvus-config`  `SUPER + SHIFT + Space`  `1399 × 920`  `argvus-clock-alarm` `hyprpicker`، ﻊﻣ ﺡﻮﺘﻔﻤﻟﺍ `SUPER + P`، ﺕﺎﻣﻮﺳﺭ ﻡﺪﺨﺘﺴﻳ ﻻ﻿ Hyprland ﺔﻣﺎﻌ

###                             ﺕﺎﻴﺠﻣﺮﺒﻟﺍ ﺮﻳﻮﻄﺗ ﺕﺎﺌﻴﺑﻭ ﺕﺎﺤﻔﺼﺘﻤﻠﻟ ﻞﻤﻌﻟﺍ ﺔﺣﺎﺴﻣ ﻊﻳﺯﻮﺗ

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Each rule has a 

 from 1 to 10 and a 

 list. Entries in 

##                                                         ًﻻ﻿ﻭﺃ ﻩﺮﻴﻴﻐﺗ ﺐﺠﻳ ﻱﺬﻟﺍ ﺎﻣ

- .ﺔﻓﺎﺴﻤﻟﺍ ﻊﺿﻭ ﻡﺪﺨﺘﺳﺍ ﻭﺃ ﺬﻓﺍﻮﻨﻟﺍ ﺓﻮﺠﻓ ﺩﺰﻓ ،ﻡﺎﺣﺩﺯﻻ﻿ﺎﺑ ﺬﻓﺍﻮﻨﻟﺍ ﺕﺮﻌ
- .ﻖﺼﻠﻟﺍ ﻊﺿﻭ ﻡﺪﺨﺘﺳﺍ ﻭﺃ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ/ﺔﻴﺟﺭﺎﺨﻟﺍ ﺔﻓﺎﺴﻤﻟﺍ ﻞﻠﻗ ،ﺔﺷﺎﺸﻟﺍ ﺔﻓﺎﺣ ﻦﻋ ﺍًﺪﺟ ﺓﺪﻴﻌ
- .ﺎًﻌﻣ ﺔﻓﺪﺼﻟﺍ/ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺸﻟ ﻊﺑﺭﻷ﻿ﺍ ﻑﺍﻮﺤﻟﺍ ﻊﻴﻤﺟﻭ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﻊﻗﻮﻣ ﻊﺟﺍﺮﻓ ،ﻪﻌﻗﻮﻣ ﺮﻴﻴﻐ
- .ﺬﻓﺍﻮﻨﻟﺍ ﻞﺻﺍﻮﻓ ﺮﻴﻴﻐﺗ ﻞﺒﻗ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷﻭ ﺔﺣﻮﻠﻟﺍ ﻂﻴﻄﺨﺗ ﺕﺍﺩﺍﺪﻋﺇ ﻦﻣ ﻖﻘﺤﺗ ،ﺔﻳﺮﺼﺑ ﺔﺣﻮﻟ

.ﺓﺮﺷﺎﺒﻣ ﺓﺄﺸﻨُﻤﻟﺍ Hyprland ﺕﺎﻔﻠﻣ ﺮﻳﺮﺤﺘﺑ ﻢﻘﺗ ﻻ﻿ ؛ﺎًﺣﺎﺘﻣ ﻥﻮﻜﻳ ﺎﻣﺪﻨﻋ ﺔﺤﻔﺼﻠﻟ ﻦﻴﻴﻌﺘﻟﺍ ﺓ

## Related

-                                                  (/docs/user-guide/appearance/)[ﻊﻴﺿﺍﻮﻤﻟﺍ]

##                                                                 ﺓﺬﻓﺎﻨﻟﺍ ﺯﺍﺰﺘﻫﺍ

    ﻡﺪﺨﺘﺳﺍﻭ **ﺬﻓﺍﻮﻨﻟﺍ → ﺔﻛﺮﺤﺘﻤﻟﺍ ﻡﻮﺳﺮﻟﺍ → ﺪﻧﻻ﻿ﺮﻴﺒﻳﺎﻫ → ﻝﺎﺧﺩﺇﻭ ﺐﺘﻜﻤﻟﺍ ﺢﻄﺳ** ﺢﺘﻓﺍ
           :ﺓﺮﺷﺎﺒﻣ ﺔﺤﻔﺼﻟﺍ ﺢﺘﻓﺍ ﻭﺃ ، `hyprland.window_rules`  `argvus-config`  `workspace`  `classes`  `classes`  `[Cc]ode.*`  `jetbrains-.*`  `._*+?-[]()|^$`  `argvus-config`  `generated/hypr/window-rules.lua`  `hl.window_rule`  `rules.lua` `wobble` ﻦﻋ ﺚﺤﺑﺍ .**ﺯﺍﺰﺘﻫﻻ﻿ﺍ ﻢﻜﺤﺗ**

```sh
argvus control-center hyprland animations windows
```

ﺪﻴﻤﺨﺘﻟﺍﻭ ،`100` ﺔﺑﻼ﻿ﺼﻟﺍ ﻲﻫ ARGVUS ﻪﻟ ﺔﻴﺿﺍﺮﺘﻓﻻ﻿ﺍ ﺕﺍﺩﺍﺪﻋﻹ﻿ﺍ .ﺎًﻴﺿﺍﺮﺘﻓﺍ ﺯ
`10`, mass `1`, intensity `1`                                                                  ﺔﻜﺒﺸﻟﺍ ﺓﺩﻮﺟﻭ`8`                                                         ﻞﺒﻘﺗ ﺔﻠﺘﻜﻟﺍﻭ ﺔﺑﻼ﻿ﺼﻟﺍ .
`0.0001–1000`, damping `0–1000`, intensity `0–2`, and mesh an integer `2–32`.
             ﻞﻳﺪﻌﺘﻠﻟ ﻢﻬﺳﻷ﻿ﺍ ﺢﻴﺗﺎﻔﻣ ﻡﺪﺨﺘﺳﺍ .ﺽﺮﻌﻟﺍ ﺔﻔﻠﻜﺗ ﻦﻣ ﻰﻠﻋﻷ﻿ﺍ ﺔﻜﺒﺸﻟﺍ ﺔﻗﺩ ﺪﻳﺰﻳ
؛ﺓﺩﻮﺴﻤﻟﺍ ﺮﻴﻐﻳ **ﺔﻴﺿﺍﺮﺘﻓﻻ﻿ﺍ Wobble ﺕﺍﺩﺍﺪﻋﺇ ﺓﺩﺎﻌﺘﺳﺍ** .ﺎﻬﺘﺑﺎﺘﻜﻟ Enter ﻂﻐﺿﺍ ﻭﺃ ﻢﻴﻘ
ﻥﻭﺩ ،ﺓﺪﺣﺍﻭ ﺓﺮﻣ Hyprland ﻞﻴﻤﺤﺗ ﺪﻴﻌﻳﻭ ﺔﻘﻠﻌﻤﻟﺍ ﺔﻛﺮﺤﺘﻤﻟﺍ ﻡﻮﺳﺮﻟﺍ ﺕﻼ﻿ﻳﺪﻌﺗ ﻊﻴﻤﺟ ﻆﻔﺤﻳ *
  .ﺔﻛﺮﺘﺸﻤﻟﺍ ﺓﺩﻮﺴﻤﻟﺎﺑ ﻆﻔﺘﺤﻳ ﺔﻛﺮﺤﺘﻤﻟﺍ ﻡﻮﺳﺮﻟﺍ ﻞﺧﺍﺩ ﻰﻟﺇ ﺓﺩﻮﻌﻟﺍ .ﺔﺴﻠﺠﻟﺍ ﻞﻴﻐﺸﺗ ﺓﺩﺎﻋﺇ

 ﺔﻳﺩﺮﻔﻟﺍ ﻪﺘﻴﺻﺎﺨﺑ ﻅﺎﻔﺘﺣﻻ﻿ﺍ ﻊﻣ Wobble ﺯﺍﺰﺘﻫﺍ ﻒﻗﻮﻳ ﺔﻛﺮﺤﺘﻤﻟﺍ ﻡﻮﺳﺮﻠﻟ ﻲﻤﻟﺎﻌﻟﺍ ﺡﺎﺘﻔﻤﻟﺍ
          ؛ARGVUS ﺔﻟﺎﺣ ﻲﻓ `effects.wobble_*` ﺖﺤﺗ ﺪﺟﻮﺗ ﺔﻴﻧﻮﻧﺎﻘﻟﺍ ﻢﻴﻘﻟﺍ .ﺕﺍﺩﺍﺪﻋﻹ﻿ﺍ
                             .ًﺎﻳﻭﺪﻳ ﻪﻠﻳﺪﻌﺗ ﻡﺪﻋ ﺐﺠﻳﻭ `hypr/state.lua` ءﺎﺸﻧﺇ ﻢﺗ

       `argvus-hyprland`'s ﺔﻄﺳﺍﻮﺑ ﺽﻭﺮﻔﻣ ،**ﺙﺪﺣﺃ ﻭﺃ Hyprland **0.57.0 ﺐﻠﻄﺘﻳ ﺍﺬﻫ
                        ـﻟﺍ .ﻦﻳﻮﻜﺘﻟﺍ ﺍﺬﻬﻟ ﻡﻮﻋﺪﻣ ﺮﻴﻏ 0.56 ﺭﺍﺪﺻﻹ﻿ﺍ .ﺔﻣﺰﺤﻟﺍ ﺩﺎﻤﺘﻋﺍ
.3 ﺝﺭﺪﺗ ﺪﻗ ﺙﺪﺣﻷ﻿ﺍ ﻖﺋﺎﺛﻮﻟﺍ ﻥﺃ ﻦﻣ ﻢﻏﺮﻟﺍ ﻰﻠﻋ ،`2` ﻰﻠ

##                                                            ﻲﻤﻟﺎﻌﻟﺍ ﺓﺬﻓﺎﻨﻟﺍ ﻊﺿﻭ





Spaced.



ﺓﺬﻓﺎﻧ ﺭﺍﺭﺯﺃ .ﻲﻟﺎﺘﻟﺍ ﻝﻮﺧﺪﻟﺍ ﻞﻴﺠ

## ﻖﻴﺒﻄﺘﻟﺍ ﻂﻳﺮﺷﻭ

.ﺓﺩﻮﺼﻘﻣ ﺓﺪﺣﻮﻤﻟﺍ ARGVUS ﻢﻜﺤﺗ ﺮﺻﺎﻨﻋ ؛ﻦﻴﻄﻳﺮﺸﻟﺍ ﻼ﻿ﻛ ﺽﺮﻌﺗ ﺪﻗ ﺎﻬﺑ ﺔﺻ



 $XDG_RUNTIME_DIR/argvus  data/generated/hypr/window-mode.lua  $XDG_CONFIG_HOME/argvus/config/hyprland.json  /hyprland/window_mode  SUPER + SHIFT + Space  `3`  `SUPER + SHIFT + Space`  `/hyprland/window_mode`  `$XDG_CONFIG_HOME/argvus/config/hyprland.json`  `data/generated/hypr/window-mode.lua`  `$XDG_RUNTIME_DIR/argvus` `SUPER + Alt + Up`                           .ﻞﻔﺳﻷ﻿ﺍ ﻲﻓ ﺓﺬﻓﺎﻨﻟﺍ ﻂﻳﺮﺷﻭ ﻰﻠﻋﻷ﻿ﺍ ﻲﻓ ﻲﺴﻴﺋﺮﻟﺍ ﻂﻳﺮﺸﻟﺍ ﻊﻀﻳ`SUPER + Alt + Down`.ﺔﻴﻠﺻﻷ﻿ﺍ ﻢﺋﺎﻌﻟﺍ/ﻂﻴﻠﺒﺘﻟﺍ ﺔﺳﺎﻴﺴﺑ ﻆﻔﺘﺤﻳ ﻢﺛ ،ﺓﺬﻓﺎﻨﻟﺍ ﻂﻳﺮﺷ ﺔﻟﺍﺯﺇ ﻞﺒﻗ ﺓﺮﻐﺼﻤﻟﺍ ﺬﻓﺍﻮﻨﻟﺍ





Commands:  argvus-hyprland  argvus-window-bar.service  argvus-windows.service  $XDG_RUNTIME_DIR/argvus  argvus windows service  `special:argvus-minimized`  `argvus windows service`  `$XDG_RUNTIME_DIR/argvus`  `argvus-windows.service`  `argvus-window-bar.service`  `argvus-hyprland` `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, and `minimize|restore|activate|maximize|close ADDRESS`. The window addresses come from the list. `position top --persist` stores/projects the preference without restarting the main bar. Configuration and runtime error details are written to the journal; visible action failures also show a translated notification.



`SUPER + Alt + Space` ﻮﻫ ﺊﻓﺎﻜﻤﻟﺍ ﺮﻣﻷ﻿ﺍ .ﻢﻜﺤﺘﻟﺍ ﺰﻛﺮﻣﻭ ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ ﻲﻓ ﺩﻮﺟﻮﻤﻟﺍ ﻞﻴﻀﻔﺘﻟﺍ ﺲﻔﻧ ﻡﺍﺪﺨﺘﺳﺎﺑ ،ﻲﻤ`argvus config window-mode toggle`;ﺢﻴﺗﺎﻔﻤﻟﺍ ﺔﺣﻮﻟ ﺕﺍﺭﺎﺼﺘﺧﺍ ﻲﻓ ﻪﻠﻴﻄﻌﺗ ﻭﺃ ﺭﺎﺼﺘﺧﻻ﻿ﺍ ﺮﻴﻴﻐﺗ ﻦﻜﻤﻳ .ﺭﺎﻈﺘﻧﻻ﻿ﺍ ﺪﻴﻗ ﻖﻴﺒﻄﺘﻟﺍ ﻥ`SUPER + Shift + Space`                                      .ﻪﺑ ﺔﺻﺎﺨﻟﺍ ﺔﻳﺩﺮﻔﻟﺍ ﺓﺬﻓﺎﻨﻟﺍ ﻞﻌﻓ ﻰﻠﻋ ﻆﻓﺎﺤﻳ

Each rule has a workspace from 1 to 10 and a classes list. Entries in classes are regular expressions matched against the window class (case sensitive), for example [Cc]ode.* or jetbrains-.*. Only letters, digits and ._*+?-|^$ are accepted. argvus-config writes the rules to generated/hypr/window-rules.lua, which the Hyprland configuration loads. To replace the rules without changing the defaults, add hl.window_rule calls to rules.lua in your ARGVUS data directory; those load after the generated rules.

Each rule has a workspace from 1 to 10 and a classes list. Entries in classes are regular expressions matched against the window class (case sensitive), for example [Cc]ode.* or jetbrains-.*. Only letters, digits and ._*+?-|^$ are accepted. argvus-config writes the rules to generated/hypr/window-rules.lua, which the Hyprland configuration loads. To replace the rules without changing the defaults, add hl.window_rule calls to rules.lua in your ARGVUS data directory; those load after the generated rules.
 for the installed and user paths. for the installed and user paths.(https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),

Tiled windows are arranged by Hyprland on the active workspace. ARGVUS also supports floating utility windows; SUPER + SHIFT + Space toggles the focused window between tiled and floating layouts. Workspace movement and window focus are controlled by the active keybinding manifest; see [Keyboard shortcuts](/docs/argvus-hyprland/keyboard-shortcuts/).
- [                                                                        ﺮﻬﻈﻤﻟﺍ](/docs/user-guide/appearance/)
- [                                                                     ﺕﺎﻋﻮﺿﻮﻤﻟﺍ](/docs/user-guide/appearance/)
- [                                                                   ﻡﺎﻬﻤﻟﺍ ﻂﻳﺮﺷ](/docs/argvus-taskbar/taskbar/)
- [                                                                   ﻢﻜﺤﺘﻟﺍ ﺔﺣﻮﻟ](/docs/argvus-control-panel/)
                                                                 ﻊﺒﺘﺗ ﺓﺪﺷ ﻰﺼﻗﺃ[                                                        0.57.0 ﺭﺪﺼﻤﻟﺍ ﺭﺍﺪﺻﺇ ﻢﺗ](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
