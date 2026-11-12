---
title: Phím tắt
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

### Điều hướng

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + Left Arrow` | Cửa sổ lát gạch tập trung theo hướng |
| `SUPER + Right Arrow` | Cửa sổ lát gạch tập trung theo hướng |
| `SUPER + Up Arrow` | Cửa sổ lát gạch tập trung theo hướng |
| `SUPER + Down Arrow` | Cửa sổ lát gạch tập trung theo hướng |
| `SUPER + CTRL + Left Arrow` | Lấy nét theo chu kỳ giữa các cửa sổ (lát gạch và nổi) |
| `SUPER + CTRL + Right Arrow` | Lấy nét theo chu kỳ giữa các cửa sổ (lát gạch và nổi) |

### Không gian làm việc

| Phím tắt | Mô tả |
| --- | --- |
| `CTRL + ALT + Right Arrow` | Di chuyển giữa các khu vực làm việc |
| `CTRL + ALT + Left Arrow` | Di chuyển giữa các khu vực làm việc |
| `Mouse extra button (mouse:276)` | Di chuyển giữa các khu vực làm việc |
| `Mouse side button (mouse:275)` | Di chuyển giữa các khu vực làm việc |
| `SUPER + 1` | Không gian làm việc 1 |
| `SUPER + 2` | Không gian làm việc 2 |
| `SUPER + 3` | Không gian làm việc 3 |
| `SUPER + 4` | Không gian làm việc 4 |
| `SUPER + 5` | Không gian làm việc 5 |
| `SUPER + 6` | Không gian làm việc 6 |
| `SUPER + 7` | Không gian làm việc 7 |
| `SUPER + 8` | Không gian làm việc 8 |
| `SUPER + 9` | Không gian làm việc 9 |
| `SUPER + CTRL + 1` to `SUPER + CTRL + 9` | Mở dự án ở vị trí đó của `argvus projects` |
| `SUPER + Shift + 1` | Di chuyển cửa sổ sang màn hình nền 1 |
| `SUPER + Shift + 2` | Di chuyển cửa sổ sang màn hình nền 2 |
| `SUPER + Shift + 3` | Di chuyển cửa sổ sang màn hình nền 3 |
| `SUPER + Shift + 4` | Di chuyển cửa sổ sang màn hình nền 4 |
| `SUPER + Shift + 5` | Di chuyển cửa sổ sang màn hình nền 5 |
| `SUPER + Shift + 6` | Di chuyển cửa sổ sang màn hình nền 6 |
| `SUPER + Shift + 7` | Di chuyển cửa sổ sang màn hình nền 7 |
| `SUPER + Shift + 8` | Di chuyển cửa sổ sang màn hình nền 8 |
| `SUPER + Shift + 9` | Di chuyển cửa sổ sang màn hình nền 9 |

### cửa sổ

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + S` | Phóng to cửa sổ (chuyển đổi) |
| `SUPER + Q` | Đóng cửa sổ |
| `SUPER + Shift + Space` | Bật/Tắt Cửa sổ nổi |
| `SUPER + F` | Cửa sổ toàn màn hình |
| `SUPER + E` | Chuyển đổi chia dọc/ngang |
| `SUPER + W` | Nhóm/Ungroup thành các tab |
| `SUPER + Tab` | Điều hướng giữa các tab |
| `SUPER + Shift + Left Arrow` | Di chuyển cửa sổ |
| `SUPER + Shift + Right Arrow` | Di chuyển cửa sổ |
| `SUPER + Shift + Up Arrow` | Di chuyển cửa sổ |
| `SUPER + Shift + Down Arrow` | Di chuyển cửa sổ |
| `SUPER + Left mouse button (mouse:272)` | Kéo cửa sổ (chỉ cửa sổ nổi) |
| `SUPER + Right mouse button (mouse:273)` | Chế độ thay đổi kích thước cửa sổ (chỉ cửa sổ nổi) |
| `SUPER + R` | Vào chế độ thay đổi kích thước cửa sổ (chỉ cửa sổ nổi) |

### Ứng dụng

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + Enter` | Nhà ga |
| `SUPER + [` | Bảng ghi chú tạm của Terminal (mở từ menu thả xuống trên không gian làm việc đặc biệt; nhấn lần nữa để ẩn) |
| `SUPER + Space` | Trình quản lý tệp |
| `SUPER + CTRL + Space` | Giám sát hệ thống |
| `SUPER + Shift + D` | Menu thiết bị di động |
| `SUPER + Shift + F` | ARGVUS Focus (Pomodoro và các phiên tập trung) |
| `SUPER + Shift + C` | Đồng hồ ARGVUS (đồng hồ, hẹn giờ và báo thức) |
| `SUPER + D` | Trình khởi chạy chương trình |
| `SUPER + B` | Trình duyệt mặc định |
| `SUPER + C` | Máy tính |
| `SUPER + ALT + S` | Bộ chọn máy chủ SSH (`argvus ssh`) |
| `SUPER + ALT + N` | Bộ chọn đoạn mã (`argvus snippets`) |
| `SUPER + ALT + G` | Bộ chọn dự án, sau đó git TUI (lazygit hoặc gitui) trong dự án đã chọn (`argvus git`) |

### Phương tiện truyền thông

| Phím tắt | Mô tả |
| --- | --- |
| `XF86AudioRaiseVolume` | Tăng âm lượng |
| `Volume Down` | Giảm âm lượng |
| `Mute` | Tắt tiếng |
| `Brightness Up` | Tăng độ sáng |
| `Brightness Down` | Giảm độ sáng |
| `Play/Pause` | Phát/Tạm dừng |
| `Next Track` | Bài hát tiếp theo |
| `Previous Track` | Bài hát trước |
| `Stop` | Dừng theo dõi |

### Ảnh chụp màn hình và ghi hình

| Phím tắt | Mô tả |
| --- | --- |
| `Print` | Chụp khu vực đã chọn |
| `SUPER + Print` | Chụp cửa sổ lấy nét |
| `SUPER + Shift + Print` | Chụp toàn bộ màn hình |
| `SUPER + G` | Ghi màn hình Start/Pause/Resume |
| `SUPER + Shift + G` | Dừng và lưu ghi màn hình |

### Phiên

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + L` | Hệ thống khóa |
| `SUPER + escape` | Hệ thống thoát |
| `SUPER + Shift + R` | Tải lại Hyprland |
| `SUPER + Shift + S` | Tắt/bật màn hình (không tạm dừng hệ thống) |
| `SUPER + Shift + L` | Chọn thời gian chờ khóa không hoạt động |
| `SUPER + ALT + W` | Chuyển đổi Giữ tỉnh táo |

### Hệ thống

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + Shift + /` | Bảng tính Hyprland |
| `SUPER + CTRL + /` | Bảng tính Kitty |
| `SUPER + F1` | Mở Giới thiệu về ARGVUS |
| `SUPER + ALT + C` | Trung tâm điều khiển mở |
| `SUPER + P` | Bộ chọn màu |
| `SUPER + .` | Bộ chọn biểu tượng cảm xúc |
| `SUPER + H` | Lịch sử bảng nhớ tạm |
| `SUPER + Shift + H` | Xóa lịch sử bảng nhớ tạm |

### Widget

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + ,` | Thanh bên thông báo Mở/Đóng |
| `Middle mouse button (mouse:274)` | Thanh bên thông báo Mở/Đóng |
| `SUPER + Backspace` | Chuyển đổi đầu Waybar |
| `SUPER + Shift + W` | Cấu hình vị trí thời tiết |
| `SUPER + ALT + Up Arrow` | Di chuyển thanh tác vụ lên trên cùng |
| `SUPER + ALT + Down Arrow` | Di chuyển thanh tác vụ xuống dưới cùng |

### Ngoại hình

| Phím tắt | Mô tả |
| --- | --- |
| `SUPER + Y` | Hình nền Trung tâm điều khiển mở |
| `SUPER + Shift + T` | Mở bộ chọn chủ đề |
| `SUPER + Shift + M` | Mở bộ chọn chế độ Chú ý/Dải cách |
| `SUPER + F5` | Chuyển đổi giữa các chủ đề ARGVUS Dark và ARGVUS Light |
| `SUPER + F6` | Chuyển đổi hình ảnh động |
| `SUPER + Shift + B` | Mở bộ chọn độ sáng và chuyển đổi Ánh sáng ban đêm |

### Chế độ thay đổi kích thước (sau SUPER + R)

Các phím tắt này chỉ hoạt động khi chế độ thay đổi kích thước đang bật.`Esc` or `Enter`rời chế độ.

| Phím tắt | Mô tả |
| --- | --- |
| `Right Arrow` | Thay đổi kích thước |
| `Left Arrow` | Thay đổi kích thước |
| `Up Arrow` | Thay đổi kích thước |
| `Down Arrow` | Thay đổi kích thước |
| `Shift + Right Arrow` | Di chuyển cửa sổ |
| `Shift + Left Arrow` | Di chuyển cửa sổ |
| `Shift + Up Arrow` | Di chuyển cửa sổ |
| `Shift + Down Arrow` | Di chuyển cửa sổ |
| `escape` | Thoát chế độ thay đổi kích thước |
| `Enter` | Thoát chế độ thay đổi kích thước |



## Đèn ban đêm

**SUPER + Shift + B** giữ hành động `appearance.brightness` trong bảng ánh xạ phím chuẩn. Menu điều chỉnh độ sáng của Rofi cũng cung cấp Chế độ Ban đêm khi Hyprsunset khả dụng. Cấu hình nhiệt độ (1000–20000 K) và thời gian bắt đầu/kết thúc tại địa phương trong **Control Center > Desktop & Input > Displays > Night Light**. Hành động nhanh sử dụng CLI chia sẻ và không tải lại Hyprland hoặc thay đổi Lua đã tạo.


Với gói argvus-ai tùy chọn được cài đặt, SUPER + A mở menu các tác nhân AI. Phím tắt này tôn trọng các ghi đè của người dùng app.ai và sẽ biến mất sau khi gỡ gói và tải lại trình tổng hợp. Cho đến khi tải lại, hành động được bảo vệ vẫn không hoạt động.


Gói tùy chọn argvus-ai sở hữu /usr/share/argvus/ai/hyprland.lua. Hyprland tải nó một cách an toàn trước khi người dùng ghi đè; việc gỡ bỏ mô-đun sẽ xóa liên kết của nó khi tải lại. Gói Hyprland cung cấp một hook của Pacman chỉ chạm vào dấu thời gian cấu hình hệ thống sau khi cài đặt/nâng cấp/gỡ bỏ mô-đun, kích hoạt việc tự động tải lại gốc. Nếu tính năng tự động tải lại bị vô hiệu hóa hoặc sử dụng cấu hình root người dùng riêng, hãy tải lại cấu hình đó một cách rõ ràng. Danh mục Control Center bao gồm app.ai với cùng các phím mặc định và nhãn đã được địa phương hóa; liên kết vẫn không hoạt động nếu không có mô-đun tùy chọn đó.


## Gói hàng tại bến

Những phím này áp dụng bên trong **Control Center > System Administration > Packages**, thay vì áp dụng toàn cục cho Hyprland. `F8` mở lại terminal giao dịch, `Esc` ẩn nó mà không dừng tiến trình, `Shift+PageUp/PageDown` cuộn lịch sử, `Shift+End` trở về đầu ra trực tiếp và `Ctrl+C` ngắt đứa con được tập trung. Bảng một lược (cheatsheet) đã cài đặt bao gồm cùng các phím này.

Trong Gói, `/` tập trung vào thanh **Tìm kiếm** ở trên cùng. `Enter` tại đó gửi các tìm kiếm cài đặt Chính thức/AUR; danh sách gỡ bỏ và cập nhật được lọc khi bạn gõ. `Down` di chuyển đến kết quả, `Up` trên kết quả đầu tiên trở lại Tìm kiếm, và `Esc` trong Tìm kiếm giữ nguyên truy vấn và quay lại danh sách. Nhấn Enter trên một kết quả thực hiện hành động gói của nó.

Xem đường dẫn người dùng và cài đặt.(/docs/argvus-hyprland/windows-and-layout/) để biết đường dẫn người dùng và cài đặt. cho các đường dẫn đã cài đặt và người dùng.(/docs/components/argvus-control-center/) cho các đường dẫn đã cài đặt và người dùng.

Run argvus control-center shortcuts create or argvus control-center shortcuts list to open either page. For advanced submaps, mouse bindings or flags, [bindings.lua](/docs/argvus-hyprland/hyprland-overrides/) remains available. Never edit the generated fragments.
Một số hành động tích hợp sẵn hữu ích bao gồm di chuyển tiêu điểm và không gian làm việc, chuyển đổi cửa sổ nổi, chụp ảnh màn hình và ghi hình, mở trình khởi chạy/terminal, thay đổi giao diện, khóa phiên, điều khiển phương tiện và nạp lại Hyprland. Các phím tắt mặc định được liệt kê trong[bảng phím tắt mặc định](#default-shortcut-table)dưới đây; trang Trung tâm điều khiển hiển thị các liên kết như chúng đang được cấu hình hiện tại.
Xem[Cửa sổ và bố cục](/docs/argvus-hyprland/windows-and-layout/)cho hành vi nổi và không gian làm việc và [Trung tâm điều khiển](/docs/components/argvus-control-center/)cho quy trình cài đặt.
