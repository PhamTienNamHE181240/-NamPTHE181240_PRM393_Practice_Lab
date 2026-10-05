import 'package:flutter/material.dart';

/// LAB 4 - EXERCISE 1: các widget hiển thị cơ bản.
/// Chạy: flutter run -d chrome -t lib/core_widgets_demo.dart
/// Cây widget: MaterialApp → Scaffold → SafeArea → ListView.
/// StatelessWidget phù hợp vì màn hình này không có dữ liệu thay đổi.
void main() => runApp(const MaterialApp(home: CoreWidgetsDemo()));

class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 1 • Core widgets')),
      // SafeArea tránh phần tai thỏ. ListView cho phép cuộn khi màn hình thấp.
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // TextStyle điều khiển cỡ chữ và độ đậm.
            Text(
              'Welcome to Flutter!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            // Icon dùng font Material Icons, không cần tải ảnh.
            const Icon(Icons.movie, size: 72, color: Colors.deepPurple),
            const SizedBox(height: 16),
            // Image.network tải ảnh qua Internet; errorBuilder giữ UI hoạt động
            // nếu mạng lỗi. Có thể đổi URL để thử ảnh khác.
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://picsum.photos/seed/flutterlab4/800/400',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.broken_image, size: 64)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Card tạo một vùng nội dung; ListTile sắp xếp icon, tiêu đề, mô tả.
            const Card(
              child: ListTile(
                leading: Icon(Icons.school),
                title: Text('Flutter UI Fundamentals'),
                subtitle: Text('Text • Image • Icon • Card • ListTile'),
                trailing: Icon(Icons.check_circle, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Tự kiểm tra: thấy đủ 5 loại widget; thu nhỏ chiều cao vẫn cuộn được.
