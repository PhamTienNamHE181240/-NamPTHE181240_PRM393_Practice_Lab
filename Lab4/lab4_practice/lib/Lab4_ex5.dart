import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: FixesDemo()));

class FixesDemo extends StatefulWidget {
  const FixesDemo({super.key});
  @override
  State<FixesDemo> createState() => _FixesDemoState();
}

class _FixesDemoState extends State<FixesDemo> {
  int _count = 0;
  DateTime? _date;

  Future<void> _chooseDate() async {
    // LỖI 4: dùng context phía trên MaterialApp không có Navigator.
    // SỬA: context của FixesDemo thuộc cây bên dưới MaterialApp.
    final result = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (mounted && result != null) setState(() => _date = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 5 • UI fixes')),
      // LỖI 2: Column dài hơn màn hình gây RenderFlex overflow.
      // SỬA: cho toàn trang cuộn. Không đặt Expanded trực tiếp trong scroll này,
      // vì trục cuộn không có chiều cao tối đa hữu hạn.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('1. ListView inside Column'),
              const SizedBox(height: 8),
              // LỖI 1: ListView trong Column nhận chiều cao không giới hạn.
              // SỬA: khung SizedBox hữu hạn → Column → Expanded → ListView.
              SizedBox(
                height: 220,
                child: Column(
                  children: [
                    const Text('A bounded, independently scrollable list'),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, i) =>
                            ListTile(title: Text('Item ${i + 1}')),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('2. This whole page can scroll on a short screen.'),
              const SizedBox(height: 16),
              Text('3. State counter: $_count'),
              FilledButton(
                // LỖI 3: chỉ _count++ làm dữ liệu đổi nhưng UI chưa được rebuild.
                // SỬA: thay đổi trong setState để Flutter cập nhật giao diện.
                onPressed: () => setState(() => _count++),
                child: const Text('Increase'),
              ),
              const SizedBox(height: 16),
              const Text('4. DatePicker with a valid context'),
              OutlinedButton(
                onPressed: _chooseDate,
                child: const Text('Choose date'),
              ),
              Text(
                _date == null
                    ? 'No date selected'
                    : _date!.toIso8601String().split('T').first,
              ),
              const SizedBox(height: 24),
              const Text(
                'Try a short window, scrolling, the counter and the date dialog.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
