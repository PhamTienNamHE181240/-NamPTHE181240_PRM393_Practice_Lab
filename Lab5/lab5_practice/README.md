# Lab 5 — Hướng dẫn học và chạy

Mở đúng thư mục `lab5_practice` trong VS Code (nơi có pubspec.yaml).
Đây là ứng dụng Flutter có giao diện, không chạy bằng `dart run`.

```powershell
flutter pub get
flutter run -d chrome
```

Android: khởi động emulator, dùng `flutter devices`, rồi `flutter run -d <device-id>`.
Sau khi sửa file, Ctrl+S và nhấn r trong terminal chạy Flutter để Hot Reload.
Nếu đổi entry point (-t), dừng lần chạy cũ bằng q và chạy lại.
Ảnh cần Internet; khi lỗi tải ảnh, ứng dụng hiển thị icon dự phòng.

## Đề gồm 5 bước, không phải 5 exercise độc lập
1. Thiết lập project: lib/main.dart.
2. Model và dữ liệu: lib/movie.dart, lib/sample_data.dart.
3. Home: lib/home_screen.dart.
4. Detail: lib/movie_detail_screen.dart.
5. Kiểm tra và hoàn thiện: danh sách sau.

## Tự kiểm tra
- Home có 3 phim, mỗi phim có ảnh, tên, rating.
- Bấm từng phim: đúng tên, thể loại, mô tả và trailer tương ứng.
- Back trở lại Home.
- Favorite thay đổi màu/icon; Rate mở hộp thoại và hiển thị lựa chọn.
- Share sao chép thông tin phim, không mở native share sheet.
- Trailer hiển thị dữ liệu static; bấm mở thông báo demo, không phát video thật.
- Thu cửa sổ về 320 px: trang cuộn, các chip/action tự xuống hàng.
- Favorite/rating chỉ tồn tại trong phiên mở detail, chưa lưu lâu dài.

## Luồng để học
main → HomeScreen → onTap → Navigator.push → MovieDetailScreen(movie: movie).
Navigator.pop hoặc nút Back bỏ route trên cùng.
Hero dùng cùng movie.id ở hai màn hình để nối ảnh.
Đọc comment tại từng file trước khi thay đổi code.
Chụp Home, Detail và một trạng thái favorite/rating.


## DartPad
Dán toàn bộ lib/dartpad_demo.dart vào DartPad Flutter. Đây là bản gộp của các file học theo bước; nếu sửa bản chia file, cần cập nhật bản gộp tương ứng.
