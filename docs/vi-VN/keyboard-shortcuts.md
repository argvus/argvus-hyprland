---
title: Keyboard shortcuts
description: Tìm các phím tắt được cung cấp bởi cấu hình ARGVUS Hyprland.
---

Mở **Trung tâm điều khiển → Màn hình & Nhập → Phím tắt bàn phím**, hoặc chạy `argvus control-center keybindings`.

## Trang này làm gì

**Tất cả Phím tắt** tìm kiếm và nhóm các biểu mẫu phím tắt đang hoạt động. Bạn có thể chọn một phím tắt, chỉnh sửa tổ hợp phím của nó, ghi lại tổ hợp mới, bật hoặc tắt một phím tắt có thể cấu hình và khôi phục tất cả các phím tắt từ hành động khôi phục của trang. Một phím tắt phải chứa ít nhất một phím không phải phím sửa đổi; trình chỉnh sửa chuẩn hóa các tên như Super/Win, Ctrl, Alt, Shift, các phím mũi tên, phím chức năng và phím phương tiện. `SUPER + Y` mở **Trung Tâm Điều Khiển → Giao Diện → Hình nền**.

Các phím tắt chính thức được lưu trữ trong `$XDG_CONFIG_HOME/argvus/config/keyboard_shortcuts.json`, được đại diện bởi `/keyboard_shortcuts` trong mô hình logic; đoạn Hyprland được tạo ra được ghi bên dưới `~/.config/argvus/data/generated/hypr/`. Một phím tắt bị vô hiệu hóa được đại diện bởi `null`. Các phím là các phím cấu hình tiếng Anh ổn định, độc lập với ngôn ngữ được chọn: một ID manifest như `window.close` ánh xạ đến `close_window`, trong khi `window.drag_mouse` ánh xạ đến `drag_window__floating_window_only`. Phần `/hyprland/keybindings` cũ và `keybindings.toml` chỉ dành cho di cư. ARGVUS lên lịch nạp lại phiên chỉ khi kế hoạch chiếu báo cáo một thay đổi thực sự.

**Tạo Phím Tắt** tạo một phím tắt bàn phím toàn cục độc lập với manifest được đóng gói. Cung cấp mô tả, phím bấm và hoặc một lệnh hoặc một trình phân phối Lua được hỗ trợ (ví dụ `window.float` với đối số JSON `{"action":"toggle"}`). **Tạo** lưu và áp dụng nó, sau đó chọn nó trong **Tất cả Phím Tắt → Phím Tắt Tùy Chỉnh**. Hủy hoặc `Esc` sẽ loại bỏ bản nháp. Tạo và ghi nhận không thực thi lệnh.

Các phím tắt tùy chỉnh có thể được chỉnh sửa, bật/tắt và xóa với xác nhận. Xung đột với các phím tắt đang bật trong cùng một ngữ cảnh yêu cầu xác nhận thay thế; các ràng buộc được bảo vệ không thể bị thay thế. Khôi phục các thiết lập mặc định chính thức sẽ giữ lại các bản ghi tùy chỉnh. Nếu việc khôi phục sẽ gây xung đột với một phím tắt tùy chỉnh đang hoạt động, hãy thay đổi hoặc tắt phím tắt tùy chỉnh đó trước. Các định nghĩa tùy chỉnh được lưu trữ dưới `/hyprland/custom_shortcuts` trong `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. `data/generated/hypr/custom-shortcuts.lua` được tạo ra sẽ được tải cùng với trình nạp được bảo vệ hiện có; các đăng ký không hợp lệ được ghi lại mà không làm gián đoạn phần còn lại của cấu hình. Lỗi lưu giữ lại bản nháp; lỗi ứng dụng báo rằng bản ghi đã được lưu và có thể thử lại.


## Tham chiếu hiện tại

Tệp manifest cơ bản và các cheatsheet đã cài đặt nằm dưới  `argvus control-center shortcuts create`  `argvus control-center shortcuts list`  `bindings.lua` `/usr/share/argvus/hyprland/`. Ghi đè người dùng đang hoạt động không phải là một manifest thay thế: nó thay đổi các mục được chọn trong Trung tâm Điều khiển. Đây là lý do tại sao một danh sách được sao chép thủ công, theo phiên bản, có thể trở nên lỗi thời.


`SUPER + Shift + R` là việc tải lại runtime rõ ràng: nó tải lại Hyprland và khởi động lại thanh tác vụ ARGVUS, Control Panel và các dịch vụ Widget Telemetry. Các lần tải lại theo cấu hình vẫn phụ thuộc điều kiện và bỏ qua việc tải lại đồ họa khi trạng thái chuẩn không thay đổi.

## Bảng phím tắt mặc định

Bảng liệt kê các phím liên kết của tệp cơ sở (`/usr/share/argvus/hyprland/keybindings.json`) cùng với các phím mặc định của chúng. Các thay đổi của bạn trong Trung tâm Điều khiển sẽ thay thế các phím được hiển thị ở đây cho các liên kết bị ảnh hưởng, và các liên kết bị vô hiệu hóa sẽ không hoạt động.

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
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | Mở dự án ở vị trí đó của `argvus projects` |
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
| `SUPER + [` | Bảng ghi chú tạm của Terminal (mở từ menu thả xuống trên không gian làm việc đặc biệt; nhấn lần nữa để ẩn) |
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
| `SUPER + ALT + G` | Bộ chọn dự án, sau đó git TUI (lazygit hoặc gitui) trong dự án đã chọn (`argvus git`) |

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

### Ảnh chụp màn hình và ghi hình

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
| `SUPER + F5` | Chuyển đổi giữa các chủ đề ARGVUS Dark và ARGVUS Light |
| `SUPER + F6` | Toggle animations |
| `SUPER + Shift + B` | Open brightness selector and Night Light toggle |

### Chế độ thay đổi kích thước (sau SUPER + R)

Các phím tắt này chỉ hoạt động khi chế độ thay đổi kích thước đang bật.`Esc` or `Enter`rời chế độ.

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



## Đèn ban đêm

**SUPER + Shift + B** giữ hành động `appearance.brightness` trong bảng ánh xạ phím chuẩn. Menu điều chỉnh độ sáng của Rofi cũng cung cấp Chế độ Ban đêm khi Hyprsunset khả dụng. Cấu hình nhiệt độ (1000–20000 K) và thời gian bắt đầu/kết thúc tại địa phương trong **Control Center > Desktop & Input > Displays > Night Light**. Hành động nhanh sử dụng CLI chia sẻ và không tải lại Hyprland hoặc thay đổi Lua đã tạo.


Với gói argvus-ai tùy chọn được cài đặt, SUPER + A mở menu các tác nhân AI. Phím tắt này tôn trọng các ghi đè của người dùng app.ai và sẽ biến mất sau khi gỡ gói và tải lại trình tổng hợp. Cho đến khi tải lại, hành động được bảo vệ vẫn không hoạt động.


Gói tùy chọn argvus-ai sở hữu /usr/share/argvus/ai/hyprland.lua. Hyprland tải nó một cách an toàn trước khi người dùng ghi đè; việc gỡ bỏ mô-đun sẽ xóa liên kết của nó khi tải lại. Gói Hyprland cung cấp một hook của Pacman chỉ chạm vào dấu thời gian cấu hình hệ thống sau khi cài đặt/nâng cấp/gỡ bỏ mô-đun, kích hoạt việc tự động tải lại gốc. Nếu tính năng tự động tải lại bị vô hiệu hóa hoặc sử dụng cấu hình root người dùng riêng, hãy tải lại cấu hình đó một cách rõ ràng. Danh mục Control Center bao gồm app.ai với cùng các phím mặc định và nhãn đã được địa phương hóa; liên kết vẫn không hoạt động nếu không có mô-đun tùy chọn đó.


## Gói hàng tại bến

Những phím này áp dụng bên trong **Control Center > System Administration > Packages**, thay vì áp dụng toàn cục cho Hyprland. `F8` mở lại terminal giao dịch, `Esc` ẩn nó mà không dừng tiến trình, `Shift+PageUp/PageDown` cuộn lịch sử, `Shift+End` trở về đầu ra trực tiếp và `Ctrl+C` ngắt đứa con được tập trung. Bảng một lược (cheatsheet) đã cài đặt bao gồm cùng các phím này.

Trong Gói, `/` tập trung vào thanh **Tìm kiếm** ở trên cùng. `Enter` tại đó gửi các tìm kiếm cài đặt Chính thức/AUR; danh sách gỡ bỏ và cập nhật được lọc khi bạn gõ. `Down` di chuyển đến kết quả, `Up` trên kết quả đầu tiên trở lại Tìm kiếm, và `Esc` trong Tìm kiếm giữ nguyên truy vấn và quay lại danh sách. Nhấn Enter trên một kết quả thực hiện hành động gói của nó.

See  for the installed and user paths.(/docs/argvus-hyprland/windows-and-layout/) for the installed and user paths. for the installed and user paths.(/docs/components/argvus-control-center/) for the installed and user paths.

Run argvus control-center shortcuts create or argvus control-center shortcuts list to open either page. For advanced submaps, mouse bindings or flags, [bindings.lua](/docs/argvus-hyprland/hyprland-overrides/) remains available. Never edit the generated fragments.
Một số hành động tích hợp sẵn hữu ích bao gồm di chuyển tiêu điểm và không gian làm việc, chuyển đổi cửa sổ nổi, chụp ảnh màn hình và ghi hình, mở trình khởi chạy/terminal, thay đổi giao diện, khóa phiên, điều khiển phương tiện và nạp lại Hyprland. Các phím tắt mặc định được liệt kê trong[bảng phím tắt mặc định](#default-shortcut-table)dưới đây; trang Trung tâm điều khiển hiển thị các liên kết như chúng đang được cấu hình hiện tại.
Xem[Cửa sổ và bố cục](/docs/argvus-hyprland/windows-and-layout/)cho hành vi nổi và không gian làm việc và [Trung tâm điều khiển](/docs/components/argvus-control-center/)cho quy trình cài đặt.
