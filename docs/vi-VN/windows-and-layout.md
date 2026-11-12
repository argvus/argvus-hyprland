---
title: Windows và bố cục
description: Hiểu các khoảng trống, biên, chế độ và không gian bảng trong ARGVUS.
---

ARGVUS sử dụng Hyprland để sắp xếp cửa sổ dạng lát và nổi. Các điều khiển bố cục dành cho người dùng nằm trong ba trang Control Center: **Control Center → Appearance → Taskbar** (vị trí, không gian và biểu tượng), **Control Center → Desktop & Input → Hyprland → Windows → Spaces** và **Control Center → Desktop & Input → Hyprland → Borders**.

## Các khái niệm

```text
┌────────────────────────────────────┐
│          outer space / panel       │
│   ┌────────────┐  inner  ┌──────┐  │
│   │   window   │   gap    │window│  │
│   └────────────┘          └──────┘  │
│     border around each window       │
└────────────────────────────────────┘
```

- **Khoảng cách cửa sổ** là khoảng trống giữa các cửa sổ được xếp lát và mép ngoài của bố cục lát.
- **Khoảng cách thanh tác vụ hoặc giao diện** là lề xung quanh các bề mặt màn hình như thanh tác vụ và thanh điều khiển. Nó không phải là giá trị giống như khoảng cách cửa sổ.
- **Đường viền** là cạnh có thể nhìn thấy được vẽ xung quanh một cửa sổ. **Độ dày cạnh** kiểm soát độ rộng đường viền hiển thị trên trang giao diện.
- **Bo tròn** là một phần của chế độ trực quan được chọn. Nó thay đổi hình dạng góc cửa sổ thay vì di chuyển cửa sổ.
- **Đặt trước bảng điều khiển và lề hiển thị** là những mối quan tâm riêng biệt: một bảng điều khiển có thể chiếm chỗ hoặc sử dụng không gian một cách trực quan trong khi Hyprland vẫn sắp xếp cửa sổ theo trạng thái khoảng cách đang hoạt động.

## Chế độ Dính và Chế độ Cách đều

Các chế độ giao diện đi kèm cung cấp hai hình học khởi đầu:

| Chế độ | Hành vi của cửa sổ | Xử lý bề mặt |
| --- | --- | --- |
| Dính | Khoảng trống bên trong `2`, khe ngoài`0`mặc định | Hình vuông, gọn gàng và gần mép màn hình |
| Có khoảng cách | Khoảng cách bên trong `10`, khe ngoài`18`mặc định | Bo tròn, có bóng và rộng rãi hơn; lề thanh tác vụ/lớp vỏ mặc định là`18` |

Đây là mặc định, không phải giới hạn. Các trang Khe cửa sổ và Khe thanh tác vụ có thể lưu khe cửa sổ và lề thanh tác vụ một cách độc lập. Thay đổi chủ đề hoặc chế độ có thể cho thấy các giá trị bố cục hiệu quả khác nhau.

## Điều khiển bố cục

Mỗi điều khiển là độc lập và nằm trên trang được liệt kê ở đây:

- **Thanh tác vụ → Vị trí** — vị trí thanh tác vụ, cạnh trên hoặc cạnh dưới.
- **Thanh tác vụ → Khoảng trống** — lề trên, trái, phải và dưới của thanh tác vụ, mỗi cái từ `0` đến `100`. Sticky mặc định lề dưới là `2`; Spaced sử dụng `18`.
- **Thanh tác vụ → Biểu tượng** — liệu nhóm tiện ích thanh tác vụ sử dụng hành vi tự động hay luôn mở rộng.
- **Hyprland → Windows → Spaces** — khoảng cách bên trong và khoảng cách bên ngoài ở trên/trái/phải/dưới, mỗi khoảng từ `0` đến `100`.
- **Hyprland → Borders** — viền chung: bật bo cong các góc; khi bật, mức bo cong có thể chọn từ `2` đến `10`. Độ dày viền cũng được đặt ở đây, từ `0` đến `10`.
- **Hyprland → Borders → Shadow** — bóng cửa sổ, mặc định tắt. Nó thiết lập phạm vi, công suất hiển thị, các góc sắc nét, các độ lệch và tỷ lệ, và màu sắc của nó theo màu nhấn của chủ đề với alpha `99` trừ khi một màu được nhập.

Các giá trị này được ghi vào trạng thái xuất hiện ARGVUS, và `argvus-config` chiếu chúng vào các tệp Hyprland được tạo mà phiên sau đó áp dụng. Lề thanh tác vụ thay đổi vị trí bề mặt của shell; khoảng trống cửa sổ bên ngoài thay đổi khu vực cửa sổ xếp gạch. Chúng có thể tạo ra khoảng cách trực quan tương tự, nhưng thay đổi cái này không làm thay đổi cái kia.

## Cửa sổ và không gian làm việc


Cấu hình được đóng gói mở Trung tâm điều khiển, Snake và Trình phân tích sử dụng đĩa dưới dạng các cửa sổ nổi, căn giữa. Trình phân tích sử dụng đĩa sử dụng cùng hình học  `SUPER + SHIFT + Space` `1399 × 920` ban đầu như cửa sổ bật lên bộ nhớ trên thanh tác vụ, được áp dụng bởi quy tắc lớp cửa sổ của nó khi cửa sổ mở ra. ARGVUS Focus và ARGVUS Clock là các cửa sổ bật lên GTK layer-shell được neo bên cạnh thanh tác vụ, vì vậy chúng không phải là cửa sổ xếp lát và không sử dụng các quy tắc cửa sổ Hyprland. Thẻ báo thức của Đồng hồ là một bề mặt lớp riêng biệt (`argvus-clock-alarm`).

Bảng điều khiển sử dụng một bề mặt lớp toàn màn hình khi hộp thoại modal của nó đang mở. Các quy tắc đã đóng gói sẽ nổi, căn giữa và ghim các cửa sổ của tác nhân Polkit, cổng GTK và KDialog để các hộp thoại được khởi chạy bởi bảng điều khiển luôn nằm trên modal và có thể nhận đầu vào.

`hyprpicker`, mở bằng `SUPER + P`, không sử dụng các hiệu ứng hoạt hình Hyprland. Ngoại lệ này chỉ ảnh hưởng đến công cụ chọn màu; các hiệu ứng hoạt hình khác vẫn tiếp tục theo cài đặt toàn cục.

### Vị trí không gian làm việc cho trình duyệt và IDE

Không có quy tắc cửa sổ nào được định nghĩa theo mặc định trên một cài đặt mới. Bạn có thể thêm các quy tắc đặt vị trí không gian làm việc theo ứng dụng của riêng bạn dưới `hyprland.window_rules` trong `argvus-config`, ví dụ:

```sh
argvus config get hyprland.window_rules
argvus config set hyprland.window_rules.browser.workspace 3
```

Mỗi quy tắc có một `workspace` từ 1 đến 10 và một danh sách `classes`. Các mục trong `classes` là các biểu thức chính quy được so khớp với lớp cửa sổ (phân biệt chữ hoa chữ thường), ví dụ `[Cc]ode.*` hoặc `jetbrains-.*`. Chỉ chấp nhận chữ cái, chữ số và `._*+?-[]()|^$`. `argvus-config` ghi các quy tắc vào `generated/hypr/window-rules.lua`, mà cấu hình Hyprland tải. Để thay thế các quy tắc mà không thay đổi mặc định, thêm các lệnh gọi `hl.window_rule` vào `rules.lua` trong thư mục dữ liệu ARGVUS của bạn; những lệnh này sẽ được tải sau các quy tắc đã tạo.

## Thay đổi gì trước

- Nếu các cửa sổ cảm thấy chật chội, tăng khoảng cách giữa các cửa sổ hoặc sử dụng chế độ Spaced.
- Nếu các cửa sổ có vẻ quá xa mép màn hình, giảm khoảng cách ngoài/thanh tác vụ hoặc sử dụng chế độ Sticky.
- Nếu thanh tác vụ xuất hiện lệch sau khi thay đổi vị trí của nó, hãy xem lại vị trí thanh tác vụ và cả bốn lề thanh tác vụ/giao diện cùng lúc.
- Nếu các cửa sổ chồng lên một bảng trực quan, hãy kiểm tra cài đặt bố cục của bảng và thanh tác vụ trước khi thay đổi khoảng cách cửa sổ.

Các thay đổi được áp dụng thông qua tích hợp giao diện/phiên ARGVUS. Sử dụng hành động đặt lại trên trang khi có sẵn; không chỉnh sửa trực tiếp các tệp Hyprland được tạo tự động.

## Liên quan


## Lắc cửa sổ

Mở **Desktop & Input → Hyprland → Animations → Windows** và sử dụng
các điều khiển **Lắc**. Tìm kiếm `wobble`, hoặc mở trang trực tiếp:

```sh
argvus control-center hyprland animations windows
```

Wobble bị tắt theo mặc định. Giá trị mặc định ARGVUS của nó là độ cứng `100`, giảm chấn
`10`, khối lượng `1`, cường độ `1` và độ phân giải lưới `8`. Độ cứng và khối lượng chấp nhận
`0.0001–1000`, giảm chấn `0–1000`, cường độ `0–2`, và lưới một số nguyên `2–32`.
Độ phân giải lưới cao hơn làm tăng chi phí kết xuất. Sử dụng các phím mũi tên để điều chỉnh giá trị
hoặc nhấn Enter để nhập chúng. **Khôi phục mặc định Wobble** thay đổi bản nháp;
**Áp dụng** lưu tất cả các chỉnh sửa hoạt ảnh đang chờ và tải lại Hyprland một lần, mà không cần
khởi động lại phiên. Quay lại trong phần Hoạt ảnh giữ nguyên bản nháp chia sẻ.

Công tắc Animations toàn cầu ức chế Wobble trong khi vẫn giữ các cài đặt riêng lẻ của
. Các giá trị chuẩn nằm dưới `effects.wobble_*` trong trạng thái ARGVUS;
`hypr/state.lua` được tạo ra và không được chỉnh sửa thủ công.

Điều này yêu cầu Hyprland **0.57.0 hoặc mới hơn**, được thực thi bởi `argvus-hyprland`'s
phụ thuộc vào gói. Phiên bản 0.56 không được hỗ trợ cho cấu hình này. Cường độ tối đa
giới hạn nó ở `2`, mặc dù tài liệu mới hơn có thể liệt kê `3`. Chế độ cửa sổ toàn cầu

##

Mở **Control Center → Desktop & Input → Hyprland → Windows → Mode** và chọn **Tile Windows (Mặc định)** hoặc **Floating Windows**. Bộ chọn tương tự cũng có sẵn từ biểu tượng chế độ cửa sổ trong nhóm tiện ích thanh tác vụ.

Tùy chọn này áp dụng cho mọi màn hình và không gian làm việc và được ghi nhớ sau khi đăng xuất. Chế độ nổi chuyển đổi các cửa sổ ứng dụng hiện có và các cửa sổ mới được mở. Chế độ ghép lại chỉ phục hồi các cửa sổ mà chính sách này đã chuyển đổi; các hộp thoại và các cửa sổ khác vốn đã ở chế độ nổi vẫn giữ nguyên nổi. Một cửa sổ được ghim rõ ràng khi chế độ nổi đang hoạt động cũng vẫn giữ ở chế độ nổi để bảo toàn việc ghim. Bố cục ghép lại được tính toán lại; cây phân chia chính xác trước đó sẽ không được khôi phục.

`SUPER + SHIFT + Space` giữ hành vi bình thường theo cửa sổ trong Tile. Ở chế độ Floating, nó không chuyển một cửa sổ trở lại chế độ tiling. Các panel, thanh tác vụ và thông báo là các bề mặt layer-shell và không bị ảnh hưởng. Chế độ toàn màn hình tiếp tục sử dụng hành vi bình thường của Hyprland; phóng to ARGVUS giữ nguyên các lề trong Spaced.

Sự ưu tiên chuẩn là `/hyprland/window_mode` trong `$XDG_CONFIG_HOME/argvus/config/hyprland.json`. Phép chiếu được tạo ra của nó là `data/generated/hypr/window-mode.lua`; không chỉnh sửa nó. Đăng ký khôi phục theo cửa sổ nằm dưới `$XDG_RUNTIME_DIR/argvus`, phạm vi thuộc về phiên bản bộ tổng hợp, và tồn tại sau khi tái tải cấu hình. Nó không được sử dụng lại trong một phiên mới.

Nếu ứng dụng đang chờ xử lý hoặc thất bại, giao diện sẽ phân biệt điều này với sở thích đã lưu. Chọn lại tùy chọn để thử lại. Nếu không có bộ ghép ảnh, sở thích sẽ được lưu cho lần đăng nhập tiếp theo. Nút cửa sổ và thanh ứng dụng

##

Chế độ nổi thêm một thanh tiêu đề ARGVUS với **Thu nhỏ**, **Phóng to / Khôi phục** và **Đóng** cho các cửa sổ ứng dụng bình thường. Nháy đúp vào thanh tiêu đề sẽ chuyển đổi giữa trạng thái phóng to và khôi phục. Trang trí bổ sung này sẽ ẩn trong chế độ Tile và toàn màn hình. Các ứng dụng tự vẽ các điều khiển của riêng chúng có thể hiển thị cả hai thanh; các điều khiển ARGVUS đồng bộ là có chủ ý.

Một thanh Waybar thứ hai xuất hiện trên mỗi màn hình, ở cạnh đối diện với thanh tác vụ chính. Nó chỉ liệt kê các cửa sổ của không gian làm việc hiện tại trên màn hình đó, bao gồm cả các cửa sổ bị thu nhỏ. Các tab nhóm ẩn không tạo thêm mục bổ sung. Các mục bị thu nhỏ giữ nguyên liên kết màn hình/không gian làm việc ban đầu của chúng. Nhấp vào cửa sổ không hoạt động để kích hoạt nó, cửa sổ đang hoạt động để thu nhỏ nó, hoặc cửa sổ đang thu nhỏ để khôi phục nó; menu ngữ cảnh của cửa sổ cung cấp các tùy chọn khôi phục, thu nhỏ, phóng to/khôi phục và đóng. Biểu tượng ứng dụng không xác định sẽ hiển thị biểu tượng cửa sổ thay thế. Kích hoạt hoặc khôi phục mục giữ nguyên vị trí con trỏ. Thanh phụ sử dụng CSS chính hiệu quả (màu sắc, phông chữ, viền và bo góc), với chiều cao và lề phản chiếu ở cạnh đối diện.

`SUPER + Alt + Up` đặt thanh chính ở trên cùng và thanh cửa sổ ở dưới cùng. `SUPER + Alt + Down` làm ngược lại. Lặp lại một hướng sẽ giữ nguyên vị trí. Tile chỉ có thanh chính. Quay lại Tile sẽ khôi phục tất cả các cửa sổ đã thu nhỏ trước khi loại bỏ thanh cửa sổ, sau đó giữ nguyên chính sách xếp gạch/lơ lửng ban đầu.

Việc thu gọn sử dụng không gian làm việc `special:argvus-minimized` đã được dành riêng. Không sử dụng không gian làm việc đó một cách thủ công. Quá trình `argvus windows service` ghi nhận danh tính, không gian làm việc/màn hình gốc, hình học, chế độ toàn màn hình/tối đa hóa và trạng thái ghim trong một đăng ký thời gian chạy cụ thể cho từng phiên bản compositor dưới `$XDG_RUNTIME_DIR/argvus`. Bản ghi tồn tại sau khi dịch vụ khởi động lại hoặc tải lại cấu hình, nhưng không vượt quá các phiên bản compositor. Đóng cửa sổ sẽ xóa bản ghi của nó. Nếu một màn hình biến mất, việc khôi phục sẽ sử dụng một đầu ra có sẵn. Thanh phục hồi bị mất hoặc thất bại sẽ ngăn việc thu gọn mới; việc khôi phục thất bại sẽ giữ lại bản ghi và thanh phục hồi.

Phiên làm việc sở hữu `argvus-windows.service` và `argvus-window-bar.service`. Cái sau giữ con Waybar của nó trong trạng thái ngủ trong Tile. Plugin hyprbars được đóng gói bởi `argvus-hyprland`, được xây dựng cho ABI Hyprland 0.57.0 trên x86_64; nó không được biên dịch trong thư mục nhà của người dùng. Xây dựng lại plugin với cập nhật ABI trình hợp nhất.

Commands: `argvus windows list --json`, `watch --json`, `position top|bottom`, `restore-all`, và `minimize|restore|activate|maximize|close ADDRESS`. Các địa chỉ cửa sổ được lấy từ danh sách. `position top --persist` lưu/truyền sở thích mà không cần khởi động lại thanh chính. Chi tiết cấu hình và lỗi thời gian chạy được ghi vào nhật ký; các thất bại hành động hiển thị cũng hiện thông báo đã được dịch.

Trong **Spaced + Floating**, các cửa sổ tuân theo khoảng trống bên ngoài và các khu vực được cả hai thanh dành riêng. Phạm vi bao gồm viền và tiêu đề, nằm bên trong cùng một viền cửa sổ. Phóng to thông qua điều khiển ARGVUS sẽ lấp đầy khu vực này với các lề; khôi phục sẽ lấy lại hình học trước đó, bao gồm cả sau khi khởi động lại dịch vụ. Toàn màn hình vẫn sử dụng toàn bộ đầu ra. Các cửa sổ nổi có thể chồng lên nhau; khoảng trống bên trong khi xếp gạch không tách chúng ra.

`SUPER + Alt + Space` chuyển đổi chế độ Toàn cầu Tile/Nổi, sử dụng cùng một tùy chọn với thanh tác vụ và Trung tâm Điều khiển. Lệnh tương đương là `argvus config window-mode toggle`. Các lần gọi đồng thời được xếp hàng; việc chuyển đổi sử dụng tùy chọn đã lưu ngay cả khi ứng dụng đang chờ. Phím tắt có thể được thay đổi hoặc vô hiệu hóa trong Phím tắt Bàn phím; `SUPER + Shift + Space` giữ hành động cho từng cửa sổ riêng lẻ.

Mỗi quy tắc có một không gian làm việc từ 1 đến 10 và một danh sách lớp. Các mục trong lớp là các biểu thức chính quy được khớp với lớp cửa sổ (phân biệt chữ hoa chữ thường), ví dụ: [Cc]ode.* hoặc jetbrains-.*. Chỉ chấp nhận các chữ cái, chữ số và ._*+?-|^$. argvus-config ghi các quy tắc vào generate/hypr/window-rules.lua, cấu hình Hyprland sẽ tải. Để thay thế các quy tắc mà không thay đổi giá trị mặc định, hãy thêm lệnh gọi hl.window_rule vào quy tắc.lua trong thư mục dữ liệu ARGVUS của bạn; những tải đó sau các quy tắc được tạo.
 cho các đường dẫn cài đặt và người dùng. cho đường dẫn đã cài đặt và người dùng.(https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),

Các cửa sổ lát gạch được sắp xếp theo Hyprland trên không gian làm việc đang hoạt động. ARGVUS cũng hỗ trợ các cửa sổ tiện ích nổi; SUPER + SHIFT + Space chuyển đổi cửa sổ tập trung giữa bố cục xếp chồng và bố cục nổi. Chuyển động của không gian làm việc và tiêu điểm cửa sổ được kiểm soát bởi bảng kê khai liên kết phím đang hoạt động; xem [Phím tắt](/docs/argvus-hyprland/keyboard-shortcuts/).
- [Bề ngoài](/docs/user-guide/appearance/)
- [Chủ đề](/docs/user-guide/appearance/)
- [Thanh tác vụ](/docs/argvus-taskbar/taskbar/)
- [Bảng điều khiển](/docs/argvus-control-panel/)
cường độ tối đa theo[phát hành mã nguồn 0.57.0](https://github.com/hyprwm/Hyprland/blob/v0.57.0/src/config/values/ConfigValues.cpp),
