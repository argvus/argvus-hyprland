---
title: Chuột và bàn di chuột
description: Cấu hình hành vi của con trỏ và bàn di chuột trong ARGVUS.
---

Mở **Trung tâm điều khiển → Ngôn ngữ & Vùng → Chuột & Bàn di chuột**, hoặc chạy `argvus control-center input`.

## Chuột

Khi phát hiện chuột, trang hiển thị:

- độ nhạy từ `-1.0` đến `1.0`;
- hồ sơ tăng tốc thích ứng hoặc phẳng;
- hệ số cuộn từ `0.1` đến `10.0`;
- cuộn tự nhiên;
- bố cục phím dành cho người thuận tay trái.

Độ nhạy, hệ số cuộn và các chuyển đổi áp dụng thông qua Hyprland khi trang đang mở, sau đó toàn bộ trạng thái đầu vào được lưu. Trang đọc giá trị bộ kết xuất hiện tại khi không có tệp đầu vào ARGVUS.

## Bàn di chuột

Khi phát hiện bàn di chuột, trang sẽ hiển thị cuộn tự nhiên, chạm để nhấp, chạm và kéo, nhấp chuột phải hai ngón và vô hiệu hóa khi đang gõ. Các tùy chọn này chỉ được hiển thị như các điều khiển hữu ích khi phiên đang chạy báo cáo có bàn di chuột.

## Điều khiển phụ thuộc phần cứng

Các điều khiển chuột nâng cao được hỗ trợ bởi `ratbag` chỉ hiển thị cho các thiết bị được hỗ trợ. ARGVUS không khẳng định rằng mọi con chuột đều hỗ trợ DPI, hồ sơ hoặc thay đổi tốc độ lấy mẫu. Nếu một thiết bị không được phát hiện hoặc dịch vụ thiết bị tùy chọn không khả dụng, những điều khiển đó không thể được áp dụng bởi trang này.

## Tính bền bỉ và đặt lại

Các cài đặt được lưu trữ dưới dạng trạng thái người dùng và một đoạn nhập Hyprland được tạo ra sẽ được tái sinh cho phiên làm việc. Sử dụng hành động đặt lại của trang khi có; không chỉnh sửa trực tiếp đoạn tạo sẵn. Một cài đặt chỉ có thể áp dụng cho bộ xử lý hiện tại khi phiên làm việc không thể tải lại trạng thái thiết bị liên quan.

Xem [Trung tâm điều khiển](/docs/components/argvus-control-center/) và [Nơi cấu hình các mục](/docs/user-guide/where-to-configure/).
