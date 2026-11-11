---
title: Keyboard shortcuts
description: ARGVUS Hyprland कॉन्फ़िगरेशन द्वारा प्रदान किए गए शॉर्टकट खोजें।
---

**कंट्रोल सेंटर → डेस्कटॉप और इनपुट → कीबोर्ड शॉर्टकट्स** खोलें, या `argvus control-center keybindings` चलाएँ।

## यह पृष्ठ क्या करता है

**सभी शॉर्टकट** सक्रिय कीबाइंडिंग मैनिफेस्ट को खोजता और समूहित करता है। आप किसी बाइंडिंग का चयन कर सकते हैं, उसकी की-कॉम्बिनेशन को संपादित कर सकते हैं, एक नई कॉम्बिनेशन कैप्चर कर सकते हैं, एक कॉन्फ़िगरेबल बाइंडिंग को सक्षम या अक्षम कर सकते हैं और पेज के पुनर्स्थापना क्रिया से सभी शॉर्टकट्स को पुनर्स्थापित कर सकते हैं। एक शॉर्टकट में एक नॉन-मॉडिफायर कुंजी होनी चाहिए; संपादक Super/Win, Ctrl, Alt, Shift, तीर, फ़ंक्शन कुंजियाँ और मीडिया कुंजियाँ जैसी नामों को सामान्यीकृत करता है। `SUPER + Y` खोलता है **कंट्रोल सेंटर → उपस्थिति → वॉलपेपर**।

आधिकारिक शॉर्टकट परिवर्तन `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json` में संग्रहित किए जाते हैं, जिसे लॉजिकल मॉडल में `/keyboard_shortcuts` द्वारा प्रदर्शित किया जाता है; उत्पन्न Hyprland खंड `~/.config/argvus/data/generated/hypr/` के नीचे लिखा गया है। एक अक्षम शॉर्टकट को `null` द्वारा दर्शाया जाता है। कुंजी स्थिर अंग्रेजी कॉन्फ़िग़ कुंजियाँ हैं, चयनित भाषा-क्षेत्र से स्वतंत्र: `window.close` जैसे मैनिफेस्ट आईडी को `close_window` से मैप किया जाता है, जबकि `window.drag_mouse` को `drag_window__floating_window_only` से मैप किया जाता है। पुराना `/hyprland/keybindings` सेक्शन और `keybindings.toml` केवल माइग्रेशन के लिए हैं। ARGVUS केवल तब एक सत्र रीलोड शेड्यूल करता है जब प्रोजेक्शन योजना एक वास्तविक परिवर्तन की रिपोर्ट करती है।

**शॉर्टकट बनाएं** पैकेज्ड मैनिफेस्ट से स्वतंत्र रूप से एक वैश्विक कीबोर्ड शॉर्टकट बनाता है। विवरण, कुंजी और या तो एक कमांड या समर्थित Lua डिस्पैचर (उदाहरण के लिए `window.float` JSON आर्गुमेंट्स के साथ `{"action":"toggle"}`) प्रदान करें। **बनाएं** इसे सेव और लागू करता है, फिर इसे **सभी शॉर्टकट → कस्टम शॉर्टकट** में चुनता है। रद्द करें या `Esc` ड्राफ्ट को खारिज करता है। निर्माण और कैप्चर कमांड को निष्पादित नहीं करते हैं।

कस्टम शॉर्टकट को संपादित किया जा सकता है, सक्षम/अक्षम किया जा सकता है और पुष्टि के साथ हटाया जा सकता है। उसी संदर्भ में सक्षम शॉर्टकट के साथ संघर्ष में प्रतिस्थापन की पुष्टि की आवश्यकता होती है; संरक्षित बाइंडिंग को प्रतिस्थापित नहीं किया जा सकता। आधिकारिक डिफ़ॉल्ट को पुनर्स्थापित करने से कस्टम रिकॉर्ड बनाए रहते हैं। यदि पुनर्स्थापना सक्रिय कस्टम शॉर्टकट से टकराएगी, तो पहले उस कस्टम शॉर्टकट को बदलें या अक्षम करें। कस्टम परिभाषाएँ `/hyprland/custom_shortcuts` के तहत `$XDG_CONFIG_HOME/argvus/config/hyprland.json` में संग्रहीत होती हैं। उत्पन्न `data/generated/hypr/custom-shortcuts.lua` मौजूदा संरक्षित लोडर के साथ लोड किया जाता है; अमान्य पंजीकरण लॉग किए जाते हैं बिना बाकी कॉन्फ़िगरेशन को रोकने के। सहेजने में विफलता ड्राफ्ट को सुरक्षित रखती है; एप्लिकेशन विफलता यह रिपोर्ट करती है कि रिकॉर्ड सहेजा गया था और इसे पुनः प्रयास किया जा सकता है।

किसी भी पृष्ठ को खोलने के लिए `argvus control-center shortcuts create` या `argvus control-center shortcuts list` चलाएँ। उन्नत सबमैप्स, माउस बाइंडिंग्स या फ्लैग्स के लिए, [`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) उपलब्ध रहता है। कभी भी उत्पन्न किए गए हिस्सों को संपादित न करें।

## वर्तमान संदर्भ

बेस मैनिफेस्ट और इंस्टॉल किए गए चीटशीट `/usr/share/argvus/hyprland/` के अंतर्गत हैं। सक्रिय उपयोगकर्ता ओवरराइड एक प्रतिस्थापन मैनिफेस्ट नहीं है: यह कंट्रोल सेंटर में चयनित प्रविष्टियों को बदल देता है। इसी कारण एक संस्करण-विशिष्ट, मैन्युअली कॉपी की गई सूची पुरानी हो सकती है।

कुछ उपयोगी इन-बिल्ट कार्यों में फोकस और वर्कस्पेस को स्थानांतरित करना, फ्लोटिंग विंडो को टॉगल करना, स्क्रीनशॉट और रिकॉर्डिंग करना, लॉन्चर/टर्मिनल खोलना, उपस्थिति बदलना, सत्र लॉक करना, मीडिया नियंत्रित करना और Hyprland को रीलोड करना शामिल हैं। डिफ़ॉल्ट बाइंडिंग्स नीचे [डिफ़ॉल्ट शॉर्टकट टेबल](#default-shortcut-table) में सूचीबद्ध हैं; कंट्रोल सेंटर पृष्ठ पर बाइंडिंग्स वर्तमान में जो कॉन्फ़िगर की गई हैं उन्हें दिखाता है।

`SUPER + Shift + R` स्पष्ट रनटाइम रीलोड है: यह Hyprland को रीलोड करता है और ARGVUS टास्कबार, कंट्रोल पैनल और विजेट टेलीमेट्री सेवाओं को फिर से शुरू करता है। कॉन्फ़िगरेशन-निर्देशित रीलोड शर्तों पर आधारित रहते हैं और जब कैनोनिकल स्थिति अपरिवर्तित रहती है तब ग्राफिकल रीलोड को छोड़ देते हैं।

## डिफ़ॉल्ट शॉर्टकट तालिका

तालिका बेस मैनिफेस्ट (`/usr/share/argvus/hyprland/keybindings.json`) के बाइंडिंग्स को उनके डिफ़ॉल्ट कुंजियों के साथ सूचीबद्ध करती है। कंट्रोल सेंटर में आपके अपने बदलाव यहां दिखायी गई कुंजियों को प्रभावित बाइंडिंग्स के लिए बदल देते हैं, और अक्षम बाइंडिंग्स नहीं चलतीं।

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
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | उस स्थिति में प्रोजेक्ट खोलता है `argvus projects` |
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
| `SUPER + [` | टर्मिनल स्क्रैचपैड (एक विशेष वर्कस्पेस पर ड्रॉपडाउन; छिपाने के लिए फिर से दबाएँ) |
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
| `SUPER + ALT + G` | प्रोजेक्ट पिकर, फिर चुने गए प्रोजेक्ट में git TUI (lazygit या gitui) (`argvus git`) |

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

### स्क्रीनशॉट्स और रिकॉर्डिंग

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
| `SUPER + F5` | ARGVUS डार्क और ARGVUS लाइट थीम के बीच टॉगल करें |
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector and Night Light toggle |

### रिसाइज़ मोड (SUPER + R के बाद)

ये शॉर्टकट केवल तभी काम करते हैं जब रिसाइज़ मोड सक्रिय हो। `Esc` या `Enter` मोड छोड़ देता है।

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


उड़ने और कार्यक्षेत्र व्यवहार के लिए [Windows और layout](/docs/argvus-hyprland/windows-and-layout/) देखें और सेटिंग्स वर्कफ़्लो के लिए [Control Center](/docs/components/argvus-control-center/) देखें।

## नाइट लाइट

**SUPER + Shift + B** `appearance.brightness` क्रिया को कैनोनिकल कीबाइंडिंग मैनिफेस्ट में रखता है। इसका Rofi ब्राइटनेस मेनू Night Light भी प्रदान करता है जब Hyprsunset उपलब्ध होता है। तापमान (1000–20000 K) और स्थानीय प्रारंभ/समाप्ति समय को **Control Center > Desktop & Input > Displays > Night Light** में कॉन्फ़िगर करें। त्वरित क्रिया साझा CLI का उपयोग करती है और Hyprland को रीलोड नहीं करती या जेनरेटेड Lua को बदलती नहीं है।


वैकल्पिक argvus-ai पैकेज स्थापित होने पर, SUPER + A AI एजेंट्स मेनू खोलता है। यह बाइंडिंग app.ai उपयोगकर्ता ओवरराइड का सम्मान करती है और पैकेज हटाने और कंपोज़िटर रीलोड के बाद गायब हो जाती है। रीलोड तक संरक्षित क्रिया अक्रियाशील रहती है।


वैकल्पिक argvus-ai पैकेज /usr/share/argvus/ai/hyprland.lua का मालिक है। Hyprland इसे उपयोगकर्ता द्वारा ओवरराइड करने से पहले सुरक्षित रूप से लोड करता है; मॉड्यूल को हटाने से इसके रीलोड पर बाइंड निष्क्रिय हो जाता है। Hyprland पैकेज एक Pacman हुक प्रदान करता है जो केवल मॉड्यूल स्थापना/अपग्रेड/हटाने के बाद सिस्टम कॉन्फ़िगरेशन टाइमस्टैम्प को छूता है, जिससे देशी ऑटोरेलोड सक्रिय होता है। यदि ऑटोरेलोड अक्षम है या अलग उपयोगकर्ता रूट कॉन्फ़िग का उपयोग किया जा रहा है, तो उस कॉन्फ़िगरेशन को स्पष्ट रूप से रीलोड करें। कंट्रोल सेंटर कैटलॉग में app.ai शामिल है जिसमें वही डिफ़ॉल्ट कुंजियाँ और स्थानीयकृत लेबल हैं; बाइंड वैकल्पिक मॉड्यूल के बिना निष्क्रिय रहता है।


## पैकेजेस टर्मिनल

ये कुंजी **Control Center > System Administration > Packages** के अंदर लागू होती हैं, न कि Hyprland पर वैश्विक रूप से। `F8` लेन-देन टर्मिनल को फिर से खोलता है, `Esc` इसे प्रक्रिया को रोकें बिना छुपाता है, `Shift+PageUp/PageDown` इतिहास को स्क्रॉल करता है, `Shift+End` लाइव आउटपुट पर लौटता है और `Ctrl+C` फ़ोकस किए गए चाइल्ड को रोकता है। स्थापित की गई चीटशीट में वही कुंजियाँ शामिल हैं।

पैकेजों में, `/` शीर्ष **खोज** बार पर ध्यान केंद्रित करता है। `Enter` वहां आधिकारिक/AUR इंस्टॉलेशन खोज प्रस्तुत करता है; हटाने और अद्यतन सूचियाँ टाइप करने पर फ़िल्टर होती हैं। `Down` परिणामों में जाता है, `Up` पहले परिणाम पर खोज पर लौटता है, और `Esc` खोज में क्वेरी को बनाए रखता है और सूची में लौटता है। किसी परिणाम पर एंटर दबाने से उसका पैकेज क्रिया प्रदर्शन करता है।
