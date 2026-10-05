# Lab 4 — Hướng dẫn học và chạy

Mở đúng thư mục `lab4_practice` trong VS Code (nơi có pubspec.yaml).
Đây là ứng dụng Flutter có giao diện, không chạy bằng `dart run`.

```powershell
flutter pub get
flutter run -d chrome
```

Android: khởi động emulator, dùng `flutter devices`, rồi `flutter run -d <device-id>`.
Sau khi sửa file, Ctrl+S và nhấn r trong terminal chạy Flutter để Hot Reload.
Nếu đổi entry point (-t), dừng lần chạy cũ bằng q và chạy lại.
Ảnh cần Internet; khi lỗi tải ảnh, ứng dụng hiển thị icon dự phòng.

## Từng exercise
- Ex1: `flutter run -d chrome -t lib/Lab4_ex1.dart`. Code chính là core_widgets_demo.dart đúng tên đề.
- Ex2: `flutter run -d chrome -t lib/Lab4_ex2.dart`.
- Ex3: `flutter run -d chrome -t lib/Lab4_ex3.dart`.
- Ex4: `flutter run -d chrome -t lib/Lab4_ex4.dart`.
- Ex5: `flutter run -d chrome -t lib/Lab4_ex5.dart`.
- Mặc định main.dart mở menu cả 5 bài.

## Cách học
1. Ex1: đọc cây widget và thay Text, Icon, URL ảnh.
2. Ex2: quan sát state trước/sau setState; đổi slider, switch, radio và ngày.
   RadioGroup dùng API Flutter mới; project được kiểm tra với Flutter 3.47.2.
3. Ex3: tìm Expanded bao ListView, thử tăng danh sách lên 100 phần tử.
4. Ex4: phân biệt ThemeData (bộ màu) và themeMode (chọn sáng/tối).
5. Ex5: comment giải thích nguyên nhân và sửa từng lỗi. Kiểm tra cửa sổ thấp.

## Giải thích bốn bản sửa Ex5
- ListView trong Column: Expanded cấp viewport hữu hạn.
- Nội dung cao hơn màn hình: SingleChildScrollView cho phép cuộn.
- UI không cập nhật: thay đổi biến trong setState.
- DatePicker thiếu context: gọi từ widget nằm dưới MaterialApp, kiểm tra mounted sau await.
Chụp ảnh mỗi exercise; với Ex4 chụp cả chế độ sáng/tối.

