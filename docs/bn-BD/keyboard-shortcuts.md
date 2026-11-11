---
title: Keyboard shortcuts
description: ARGVUS Hyprland কনফিগারেশন দ্বারা প্রদত্ত শর্টকাট খুঁজুন।
---

খুলুন **কন্ট্রোল সেন্টার → ডেস্কটপ & ইনপুট → কীবোর্ড শর্টকাটস**, অথবা চালান `argvus control-center keybindings`।

## পাতা কি করে

**সব শর্টকাট** সক্রিয় কী-বাইন্ডিং ম্যানিফেস্ট খুঁজে বের করে এবং গ্রুপ করে। আপনি একটি বাইন্ডিং নির্বাচন করতে পারেন, এর কী কম্বিনেশন সম্পাদনা করতে পারেন, একটি নতুন কম্বিনেশন ক্যাপচার করতে পারেন, একটি কনফিগারেবল বাইন্ডিং সক্রিয় বা নিষ্ক্রিয় করতে পারেন এবং পৃষ্ঠার রিস্টোর অ্যাকশন থেকে সব শর্টকাট পুনরুদ্ধার করতে পারেন। একটি শর্টকাটে একটি নন-মডিফায়ার কী থাকতে হবে; এডিটর সুপার/উইন, কন্ট্রোল, অল্ট, শিফট, তীর, ফাংশন কী এবং মিডিয়া কী-এর মতো নামগুলোকে স্বাভাবিক রূপে আনে। `SUPER + Y` খুলে **কন্ট্রোল সেন্টার → অ্যাপিয়ারেন্স → ওয়ালপেপারস**।

অফিসিয়াল শর্টকাট পরিবর্তনগুলি `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`-তে সংরক্ষিত হয়, যা লগিক্যাল মডেলে `/keyboard_shortcuts` দ্বারা উপস্থাপিত হয়; তৈরি হওয়া Hyprland ফ্রাগমেন্ট `~/.config/argvus/data/generated/hypr/`-এর নিচে লেখা হয়। একটি নিষ্ক্রিয় শর্টকাট `null` দ্বারা উপস্থাপিত। কীস হল স্থিতিশীল ইংরেজি কনফিগারেশন কীস, নির্বাচিত লোকেলের উপর নির্ভরশীল নয়: `window.close`-এর মতো একটি ম্যানিফেস্ট আইডি `close_window`-তে ম্যাপ হয়, যেখানে `window.drag_mouse` `drag_window__floating_window_only`-তে ম্যাপ হয়। পুরনো `/hyprland/keybindings` অংশ এবং `keybindings.toml` কেবল মাইগ্রেশনের জন্য। ARGVUS শুধুমাত্র তখনই একটি সেশন রিলোডের সময়সূচি নির্ধারণ করে যখন প্রজেকশন প্ল্যান একটি বাস্তব পরিবর্তনের রিপোর্ট দেয়।

**শর্টকাট তৈরি করুন** একটি প্যাকেজ করা ম্যানিফেস্টের স্বাধীনভাবে একটি গ্লোবাল কীবোর্ড শর্টকাট তৈরি করে। একটি বর্ণনা, কী এবং একটি কমান্ড বা সমর্থিত Lua ডিসপ্যাচার (উদাহরণস্বরূপ `window.float` JSON আর্গুমেন্ট সহ `{"action":"toggle"}`) সরবরাহ করুন। **তৈরি করুন** এটি সংরক্ষণ এবং প্রয়োগ করে, তারপর **All Shortcuts → Custom Shortcuts**-এ এটি নির্বাচন করে। বাতিল করুন অথবা `Esc` খসড়া নিল করে। তৈরি এবং ক্যাপচার কমান্ডটি কার্যকর করে না।

কাস্টম শর্টকাটগুলি এডিট করা, সক্ষম/অক্ষম করা এবং নিশ্চিতকরণের সঙ্গে মুছে ফেলা যায়। একই প্রসঙ্গে সক্ষম শর্টকাটগুলির সঙ্গে সংঘর্ষ থাকলে প্রতিস্থাপনের নিশ্চিতকরণ প্রয়োজন; সুরক্ষিত বাইনডিং প্রতিস্থাপন করা যায় না। অফিসিয়াল ডিফল্ট পুনরুদ্ধার করলে কাস্টম রেকর্ড সংরক্ষিত থাকে। যদি পুনরুদ্ধার সক্রিয় কাস্টম শর্টকাটের সঙ্গে সংঘর্ষ করবে, তবে আগে সেই কাস্টম শর্টকাট পরিবর্তন বা অক্ষম করুন। কাস্টম সংজ্ঞাগুলি $XDG_CONFIG_HOME/argvus/config/hyprland.json-এর অধীনে `/hyprland/custom_shortcuts`-তে সংরক্ষিত থাকে। তৈরি হওয়া  `$XDG_CONFIG_HOME/argvus/config/hyprland.json` `data/generated/hypr/custom-shortcuts.lua` বিদ্যমান সুরক্ষিত লোডারের সঙ্গে লোড হয়; অবৈধ রেজিস্ট্রেশনগুলি লগ করা হয়, কিন্তু বাকি কনফিগারেশন বিরত হয় না। সংরক্ষণ ব্যর্থ হলে খসড়া সংরক্ষিত থাকে; অ্যাপلیکেশন ব্যর্থ হলে রেকর্ড সংরক্ষিত হয়েছে এবং পুনরায় চেষ্টা করা যেতে পারে।

কোনও একটি পেজ খুলতে `argvus control-center shortcuts create` বা `argvus control-center shortcuts list` চালান। উন্নত সাবম্যাপ, মাউস বাইন্ডিং বা ফ্ল্যাগের জন্য, [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) उपलब्ध থাকে। কখনও তৈরি করা ফ্র্যাগমেন্টগুলি সম্পাদনা করবেন না।

## বর্তমান রেফারেন্স

বেস ম্যানিফেস্ট এবং ইনস্টল করা চিটশিটগুলি `/usr/share/argvus/hyprland/` এর অধীনে রয়েছে। সক্রিয় ব্যবহারকারীর ওভাররাইট একটি প্রতিস্থাপন ম্যানিফেস্ট নয়: এটি কন্ট্রোল সেন্টারে নির্বাচিত এন্ট্রিগুলি পরিবর্তন করে। এই কারণেই নির্দিষ্ট সংস্করণের, ম্যানুয়ালি অনুলিপি করা তালিকা পুরনো হয়ে যেতে পারে।

কিছু উপকারী বিল্ট-ইন অ্যাকশনগুলির মধ্যে রয়েছে ফোকাস এবং ওয়ার্কস্পেস সরানো, ফ্লোটিং উইন্ডোগুলি টগল করা, স্ক্রিনশট এবং রেকর্ড করা, লঞ্চার/টার্মিনাল খোলা, চেহারা পরিবর্তন করা, সেশন লক করা, মিডিয়া নিয়ন্ত্রণ করা এবং Hyprland রিলোড করা। ডিফল্ট বাইনডিংগুলি নিচের [ডিফল্ট শর্টকাট টেবিল](#default-shortcut-table) এ তালিকাভুক্ত রয়েছে; কন্ট্রোল সেন্টার পৃষ্ঠায় বাইনডিংগুলি বর্তমানে কিভাবে কনফিগার করা হয়েছে তা দেখানো হয়েছে।

`SUPER + Shift + R` হল স্পষ্ট রানটাইম রিলোড: এটি Hyprland রিলোড করে এবং ARGVUS টাস্কবার, কন্ট্রোল প্যানেল এবং উইজেট টেলিমেট্রি সার্ভিসগুলি পুনরায় শুরু করে। কনফিগারেশন-চালিত রিলোডগুলি শর্তসাপেক্ষ থাকে এবং যখন ক্যানোনিকাল অবস্থা অপরিবর্তিত থাকে তখন গ্রাফিকাল রিলোড এড়ায়।

## ডিফল্ট শর্টকাট টেবিল

টেবিলটি বেস ম্যানিফেস্টের (`/usr/share/argvus/hyprland/keybindings.json`) বাইনডিংগুলি তাদের ডিফল্ট কী-এর সাথে তালিকাভুক্ত করে। কন্ট্রোল সেন্টারে আপনার নিজের পরিবর্তনগুলি এখানে প্রদর্শিত কী গুলিকে প্রভাবিত বাইনডিংগুলির জন্য প্রতিস্থাপন করে, এবং অক্ষম করা বাইনডিংগুলি চলবে না।

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
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | সেই অবস্থানে প্রকল্পটি খুলে `argvus projects` |
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
| `SUPER + [` | টার্মিনাল স্ক্র্যাচপ্যাড (একটি বিশেষ ওয়ার্কস্পেসে ড্রপডাউন; আবার চাপলে লুকিয়ে যায়) |
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
| `SUPER + ALT + G`| প্রোজেক্ট পিকার, তারপর নির্বাচিত প্রোজেক্টে গিট টিইউআই (lazygit বা gitui)`argvus git`) |

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

### স্ক্রিনশট এবং রেকর্ডিং

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
| `SUPER + F5` | ARGVUS ডার্ক এবং ARGVUS লাইট থিমগুলির মধ্যে পরিবর্তন করুন |
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector and Night Light toggle |

### রিসাইজ মোড (SUPER + R চাপার পর)

এই শর্টকাটগুলি কেবলমাত্র রিসাইজ মোড সক্রিয় থাকলে কাজ করে। `Esc` বা `Enter` মোডটি ছেড়ে চলে যায়।

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


ভাসমান এবং ওয়ার্কস্পেসের আচরণের জন্য [Windows and layout](/docs/argvus-hyprland/windows-and-layout/) দেখুন এবং সেটিংস ওয়ার্কফ্লোর জন্য [Control Center](/docs/components/argvus-control-center/) দেখুন।

## নাইট লাইট

**SUPER + Shift + B** `appearance.brightness` ক্রিয়াটি canonical keybinding manifest-এ রাখে। এর Rofi উজ্জ্বলতা মেনু Hyprsunset উপলব্ধ হলে Night Light-ও অফার করে। **Control Center > Desktop & Input > Displays > Night Light**-এ তাপমাত্রা (1000–20000 K) এবং স্থানীয় শুরু/শেষ সময় কনফিগার করুন। দ্রুত ক্রিয়াটি শেয়ার করা CLI ব্যবহার করে এবং Hyprland পুনঃলোড করে না বা তৈরি করা Lua পরিবর্তন করে না।


ঐচ্ছিক argvus-ai প্যাকেজ ইনস্টল করার পরে, SUPER + A AI এজেন্ট মেনু খুলে। এই বাইনডিং app.ai ব্যবহারকারীর ওভাররাইডকে সম্মান করে এবং প্যাকেজ অপসারণ ও কম্পোজিটর রিলোডের পরে অদৃশ্য হয়ে যায়। রিলোড না হওয়া পর্যন্ত সংরক্ষিত কাজটি অকার্যকর থাকে।


ঐচ্ছিক argvus-ai প্যাকেজটি /usr/share/argvus/ai/hyprland.lua এর মালিক। Hyprland এটি ব্যবহারকারীর ওভাররাইড করার আগে নিরাপদে লোড করে; মডিউলটি মুছে ফেললে পুনরায় লোডের সময় তার বাইন্ড মুছে যায়। Hyprland প্যাকেজ একটি Pacman হুক প্রদান করে যা মডিউল ইনস্টলেশন/আপগ্রেড/মুছে ফেলার পর কেবল সিস্টেম কনফিগারেশনের টাইমস্ট্যাম্পকে স্পর্শ করে, যা নেটিভ অটোরিলোড ট্রিগার করে। যদি অটোরিলোড নিষ্ক্রিয় থাকে বা আলাদা ব্যবহারকারী রুট কনফিগারেশন ব্যবহার করা হয়, তবে সেই কনফিগারেশনটি স্পষ্টভাবে পুনরায় লোড করুন। কন্ট্রোল সেন্টার ক্যাটালগে app.ai রয়েছে একই ডিফল্ট কী এবং স্থানীয়কৃত লেবেলসহ; ঐচ্ছিক মডিউল ছাড়া বাইন্ডিং সক্রিয় থাকে না।


## প্যাকেজ টার্মিনাল

এই কীগুলো পুরো Hyprland-এর জন্য নয়, বরং **Control Center > System Administration > Packages** এর ভিতরে প্রযোজ্য। `F8` লেনদেন টার্মিনাল পুনরায় খোলে, `Esc` প্রক্রিয়াটি বন্ধ না করে তা লুকায়, `Shift+PageUp/PageDown` ইতিহাস স্ক্রোল করে, `Shift+End` লাইভ আউটপুটে ফিরে আসে এবং `Ctrl+C` ফোকাস করা শিশুকে বাধা দেয়। ইনস্টল করা চিটশিটেও একই কীগুলো অন্তর্ভুক্ত।

প্যাকেজসমূহে, `/` শীর্ষ **Search** বারকে ফোকাস করে। `Enter` সেখানে Official/AUR ইনস্টলেশন খোঁজ জমা দেয়; রিমুভাল এবং আপডেট তালিকাগুলি টাইপ করার সঙ্গে সঙ্গে ফিল্টার হয়। `Down` ফলাফলে চলে যায়, `Up` প্রথম ফলাফলে Search-এ ফিরে যায়, এবং `Esc` Search-এ কুয়েরি সংরক্ষণ করে এবং তালিকায় ফিরে যায়। কোনো ফলাফলে Enter চাপলে তার প্যাকেজ ক্রিয়াটি সম্পন্ন করে।
