---
title: 键盘快捷键
description: 查找 ARGVUS Hyprland 配置提供的快捷键。
---
打开 **控制中心 → 桌面与输入 → 键盘快捷键**，或运行 `argvus control-center keybindings`。

## 页面功能

**所有快捷键** 会搜索并分组活动的按键绑定清单。您可以选择一个绑定，编辑其按键组合，捕获一个新的组合，启用或禁用可配置绑定，并通过页面的恢复操作恢复所有快捷键。一个快捷键必须包含一个非修饰键；编辑器会规范化名称，例如 Super/Win、Ctrl、Alt、Shift、方向键、功能键和媒体键。`SUPER + Y` 打开 **控制中心 → 外观 → 壁纸**。

官方快捷键更改存储在 `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json` 中，在逻辑模型中表示为 `/keyboard_shortcuts`；生成的 Hyprland 片段写入 `~/.config/argvus/data/generated/hypr/` 下面。禁用的快捷键表示为 `null`。键是稳定的英文配置键，与所选语言无关：诸如 `window.close` 的清单 ID 映射到 `close_window`，而 `window.drag_mouse` 映射到 `drag_window__floating_window_only`。旧的 `/hyprland/keybindings` 部分和 `keybindings.toml` 仅用于迁移。当投影计划报告实际更改时，ARGVUS 才会安排会话重新加载。

**创建快捷方式** 独立于打包的清单创建全局键盘快捷方式。提供描述、按键以及命令或支持的 Lua 调度器（例如带有 JSON 参数 {"action":"toggle"} 的 `window.float`）。**创建** 会保存并应用快捷方式，然后在 **所有快捷方式 → 自定义快捷方式** 中选择它。取消或  `{"action":"toggle"}` `Esc` 会丢弃草稿。创建和捕获不会执行该命令。

自定义快捷键可以编辑、启用/禁用，并在确认后删除。在相同上下文中启用的快捷键发生冲突时，需要确认替换；受保护的绑定不能被替换。恢复官方默认设置会保留自定义记录。如果恢复会与已激活的自定义快捷键冲突，请先更改或禁用该自定义快捷键。自定义定义存储在 `/hyprland/custom_shortcuts` 下的 `$XDG_CONFIG_HOME/argvus/config/hyprland.json` 中。生成的 `data/generated/hypr/custom-shortcuts.lua` 会与现有的受保护加载器一起加载；无效的注册会被记录，但不会中止其余配置。保存失败时会保留草稿；应用失败会报告记录已保存，并且可以重试。

运行 `argvus control-center shortcuts create` 或 `argvus control-center shortcuts list` 来打开任意页面。对于高级子地图、鼠标绑定或标记，[`bindings.lua`](/docs/argvus-hyprland/hyprland-overrides/) 仍然可用。切勿编辑生成的片段。

## 当前参考

基础清单和已安装的速查表位于 `/usr/share/argvus/hyprland/` 下。活动用户覆盖不是替代清单：它改变了控制中心中选定的条目。这就是为什么针对特定版本手动复制的列表可能会过时。

一些有用的内置操作包括移动焦点和工作区、切换浮动窗口、截屏和录制、打开启动器/终端、改变外观、锁定会话、控制媒体以及重新加载 Hyprland。默认的快捷键绑定列在下方的 [默认快捷键表](#default-shortcut-table) 中；控制中心页面显示当前配置的绑定。

`SUPER + Shift + R` 是显式运行时重载：它会重新加载 Hyprland 并重启 ARGVUS 任务栏、控制面板和小部件遥测服务。基于配置的重载仍然是有条件的，当规范状态未更改时会跳过图形界面的重载。

## 默认快捷键表

该表列出了基础清单 (`/usr/share/argvus/hyprland/keybindings.json`) 的绑定及其默认按键。在控制中心中自行更改的快捷键会替换此处显示的相应绑定按键，而禁用的绑定将不会执行。### 导航

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + Left Arrow` | 按方向聚焦平铺窗口 |
| `SUPER + Right Arrow` | 按方向聚焦平铺窗口 |
| `SUPER + Up Arrow` | 按方向聚焦平铺窗口 |
| `SUPER + Down Arrow` | 按方向聚焦平铺窗口 |
| `SUPER + CTRL + Left Arrow` | 在窗口（平铺和浮动）间循环焦点 |
| `SUPER + CTRL + Right Arrow` | 在窗口（平铺和浮动）间循环焦点 |

### 工作区

| 快捷键 | 描述 |
| --- | --- |
| `CTRL + ALT + Right Arrow` | 在工作区之间切换 |
| `CTRL + ALT + Left Arrow` | 在工作区之间切换 |
| `Mouse extra button (mouse:276)` | 在工作区之间切换 |
| `Mouse side button (mouse:275)` | 在工作区之间切换 |
| `SUPER + 1` | 工作区 1 |
| `SUPER + 2` | 工作区 2 |
| `SUPER + 3` | 工作区 3 |
| `SUPER + 4` | 工作区 4 |
| `SUPER + 5` | 工作区 5 |
| `SUPER + 6` | 工作区 6 |
| `SUPER + 7` | 工作区 7 |
| `SUPER + 8` | 工作区 8 |
| `SUPER + 9` | 工作区 9 |
| `SUPER + CTRL + 1` 到 `SUPER + CTRL + 9` | 在 `argvus projects` 的该位置打开项目 |
| `SUPER + Shift + 1` | 将窗口移到桌面 1 |
| `SUPER + Shift + 2` | 将窗口移到桌面 2 |
| `SUPER + Shift + 3` | 将窗口移到桌面 3 |
| `SUPER + Shift + 4` | 将窗口移到桌面 4 |
| `SUPER + Shift + 5` | 将窗口移到桌面 5 |
| `SUPER + Shift + 6` | 将窗口移到桌面 6 |
| `SUPER + Shift + 7` | 将窗口移到桌面 7 |
| `SUPER + Shift + 8` | 将窗口移到桌面 8 |
| `SUPER + Shift + 9` | 将窗口移到桌面 9 |

### Windows

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + S` | 最大化窗口（切换） |
| `SUPER + Q` | 关闭窗口 |
| `SUPER + Shift + Space` | 启用/禁用浮动窗口 |
| `SUPER + F` | 全屏窗口 |
| `SUPER + E` | 垂直/水平分割切换 |
| `SUPER + W` | 分组/取消分组为标签页 |
| `SUPER + Tab` | 在标签页之间导航 |
| `SUPER + Shift + Left Arrow` | 移动窗口 |
| `SUPER + Shift + Right Arrow` | 移动窗口 |
| `SUPER + Shift + Up Arrow` | 移动窗口 |
| `SUPER + Shift + Down Arrow` | 移动窗口 |
| `SUPER + Left mouse button (mouse:272)` | 拖动窗口（仅浮动窗口） |
| `SUPER + Right mouse button (mouse:273)` | 窗口调整大小模式（仅浮动窗口） |
| `SUPER + R` | 进入窗口调整大小模式（仅浮动窗口） |

### 应用程序

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + Enter` | 终端 |
| `SUPER + [` | 终端备忘板（在特殊工作区下拉；再次按下隐藏） |
| `SUPER + Space` | 文件管理器 |
| `SUPER + CTRL + Space` | 系统监视器 |
| `SUPER + Shift + D` | 可移动设备菜单 |
| `SUPER + Shift + F` | ARGVUS 专注（番茄工作法和专注会话） |
| `SUPER + Shift + C` | ARGVUS 时钟（时钟、计时器和闹钟） |
| `SUPER + D` | 程序启动器 |
| `SUPER + B` | 默认浏览器 |
| `SUPER + C` | 计算器 |
| `SUPER + ALT + S` | SSH 主机选择器（`argvus ssh`） |
| `SUPER + ALT + N` | 代码片段选择器（`argvus snippets`） |
| `SUPER + ALT + G` | 项目选择器，然后在选中的项目中启动 git TUI（lazygit 或 gitui）（`argvus git`） |

### 多媒体

| 快捷键 | 描述 |
| --- | --- |
| `XF86AudioRaiseVolume` | 增大音量 |
| `Volume Down` | 减小音量 |
| `Mute` | 静音 |
| `Brightness Up` | 增加亮度 |
| `Brightness Down` | 降低亮度 |
| `Play/Pause` | 播放/暂停 |
| `Next Track` | 下一曲 |
| `Previous Track` | 上一曲 |
| `Stop` | 停止播放 |

### 截图与录屏

| 快捷键 | 描述 |
| --- | --- |
| `Print` | 捕获选定区域 |
| `SUPER + Print` | 捕获当前窗口 |
| `SUPER + Shift + Print` | 捕获整个屏幕 |
| `SUPER + G` | 开始/暂停/继续录屏 |
| `SUPER + Shift + G` | 停止并保存录屏 |

### 会话

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + L` | 锁定系统 |
| `SUPER + escape` | 退出系统 |
| `SUPER + Shift + R` | 重新加载 Hyprland |
| `SUPER + Shift + S` | 打开/关闭显示器（不挂起系统） |
| `SUPER + Shift + L` | 选择非活动锁定超时 |
| `SUPER + ALT + W` | 切换保持唤醒 |

### 系统

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + Shift + /` | Hyprland 速查表 |
| `SUPER + CTRL + /` | Kitty 速查表 |
| `SUPER + F1` | 打开 ARGVUS 关于页面 |
| `SUPER + ALT + C` | 打开控制中心 |
| `SUPER + P` | 颜色选择器 |
| `SUPER + .` | 表情选择器 |
| `SUPER + H` | 剪贴板历史 |
| `SUPER + Shift + H` | 清除剪贴板历史 |

### 小部件

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + ,` | 打开/关闭通知侧边栏 |
| `Middle mouse button (mouse:274)` | 打开/关闭通知侧边栏 |
| `SUPER + Backspace` | 切换 Waybar 顶部显示 |
| `SUPER + Shift + W` | 配置天气位置 |
| `SUPER + ALT + Up Arrow` | 将任务栏移动到顶部 |
| `SUPER + ALT + Down Arrow` | 将任务栏移动到底部 |

### 外观

| 快捷键 | 描述 |
| --- | --- |
| `SUPER + Y` | 打开控制中心壁纸 |
| `SUPER + Shift + T` | 打开主题选择器 |
| `SUPER + Shift + M` | 打开黏性/间距模式选择器 |
| `SUPER + F5` | 切换 ARGVUS 深色与 ARGVUS 浅色主题 |
| `SUPER + F6` | 切换动画效果 |
| `SUPER + Shift + B` | 打开亮度选择器并切换夜间模式 |

### 调整大小模式（在 SUPER + R 后）

这些快捷键仅在调整大小模式激活时有效。`Esc` 或 `Enter` 可退出该模式。

| 快捷键 | 描述 |
| --- | --- |
| `Right Arrow` | 调整大小 |
| `Left Arrow` | 调整大小 |
| `Up Arrow` | 调整大小 |
| `Down Arrow` | 调整大小 |
| `Shift + Right Arrow` | 移动窗口 |
| `Shift + Left Arrow` | 移动窗口 |
| `Shift + Up Arrow` | 移动窗口 |
| `Shift + Down Arrow` | 移动窗口 |
| `escape` | 退出调整大小模式 |
| `Enter` | 退出调整大小模式 |

请参阅 [Windows 和布局](/docs/argvus-hyprland/windows-and-layout/) 了解浮动和工作区行为，以及 [控制中心](/docs/components/argvus-control-center/) 了解设置工作流程。

## 夜间模式

**SUPER + Shift + B** 会在标准键绑定清单中保留 `appearance.brightness` 操作。其 Rofi 亮度菜单在 Hyprsunset 可用时也提供夜间模式。可以在 **控制中心 > 桌面与输入 > 显示 > 夜间模式** 中配置温度（1000–20000 K）和本地开始/结束时间。快速操作使用共享 CLI，不会重新加载 Hyprland 或更改生成的 Lua 脚本。  

在安装了可选的 argvus-ai 软件包后，SUPER + A 会打开 AI 代理菜单。该绑定会遵循 app.ai 用户覆盖设置，并在卸载软件包并重新加载合成器后消失。在重新加载之前，受保护的操作处于非激活状态。


可选的 argvus-ai 软件包拥有 /usr/share/argvus/ai/hyprland.lua 文件。Hyprland 会在用户覆盖之前安全地加载它；移除该模块会在重新加载时移除其绑定。Hyprland 软件包提供一个 Pacman 钩子，该钩子仅在模块安装/升级/移除后触碰系统配置时间戳，从而触发本地自动重载。如果自动重载被禁用或使用了独立的用户根配置，则需显式重新加载该配置。控制中心目录包含 app.ai，使用相同的默认键和本地化标签；如果没有可选模块，绑定将保持非激活状态。

## 软件包终端

这些按键适用于 **控制中心 > 系统管理 > 软件包** 内，而不是全局适用于 Hyprland。`F8` 会重新打开事务终端，`Esc` 会在不停止进程的情况下隐藏它，`Shift+PageUp/PageDown` 滚动历史记录，`Shift+End` 返回实时输出，`Ctrl+C` 中断当前聚焦的子进程。已安装的备忘单包含相同的按键。

在软件包中，`/` 聚焦顶部的 **搜索** 框。`Enter` 在那里提交官方/AUR 安装搜索；在输入时，移除和更新列表会进行筛选。`Down` 移动到结果，`Up` 在第一个结果上返回到搜索框，`Esc` 在搜索框中保留查询并返回列表。按回车键在结果上执行该软件包操作。
