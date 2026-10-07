# Lab 6 — Hướng dẫn học và chạy

Mở đúng thư mục `lab6_practice` trong VS Code (nơi có pubspec.yaml).
Đây là ứng dụng Flutter có giao diện, không chạy bằng `dart run`.

```powershell
flutter pub get
flutter run -d chrome
```

Android: khởi động emulator, dùng `flutter devices`, rồi `flutter run -d <device-id>`.
Sau khi sửa file, Ctrl+S và nhấn r trong terminal chạy Flutter để Hot Reload.
Nếu đổi entry point (-t), dừng lần chạy cũ bằng q và chạy lại.
Ảnh cần Internet; khi lỗi tải ảnh, ứng dụng hiển thị icon dự phòng.

## Ba mốc tích lũy
- 6.1: `flutter run -d chrome -t lib/Lab6_ex1.dart` — hero/heading responsive.
- 6.2: `flutter run -d chrome -t lib/Lab6_ex2.dart` — search, chips, sort; kết quả text.
- 6.3: `flutter run -d chrome -t lib/Lab6_ex3.dart` — toàn bộ card, list/grid.
- main.dart mở 6.3. Mỗi file Lab6_exN.dart tự chứa toàn bộ mã, dán được vào DartPad Flutter.
  Các file giống nhau có chủ ý để chạy độc lập; hằng stage bật dần từng mốc.

## Tự kiểm tra
- Chiều rộng dưới 800: list một cột; từ 800 trở lên: grid hai cột (logical pixels).
- Search DUNE và dune cho cùng kết quả.
- Chọn Drama + Comedy: phim thuộc ít nhất một thể loại được giữ (OR).
- Search và thể loại kết hợp bằng AND.
- A–Z/Z–A theo tên; Year mới nhất trước; Rating cao nhất trước.
- Không có kết quả hiển thị thông báo; Clear filters xóa tìm kiếm, thể loại và reset sort.
- Màn hình thấp: phần điều khiển cuộn riêng để giữ chỗ cho kết quả.
- Thử 390x844, 800x900, 1200x800, 320x568 và chữ lớn.

## Giải thích
MediaQuery đọc viewport/text scale. LayoutBuilder nhận constraints từ widget cha.
Wrap xuống dòng chip; Expanded cấp chiều cao cho vùng danh sách.
State giữ query/selectedGenres/sort; setState kích hoạt tính lại danh sách.
where lọc, toList tạo bản sao, sort sắp xếp bản sao để không sửa dữ liệu mẫu.
Chụp ba mốc, bản 6.3 trên màn hình hẹp/rộng và kết quả lọc.

