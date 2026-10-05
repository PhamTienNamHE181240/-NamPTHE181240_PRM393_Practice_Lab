import 'package:flutter/material.dart';

void main() => runApp(const StructureApp());

class StructureApp extends StatefulWidget {
  const StructureApp({super.key});
  @override
  State<StructureApp> createState() => _StructureAppState();
}

class _StructureAppState extends State<StructureApp> {
  bool _dark = false;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(title: const Text('Exercise 4 • Theme')),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Dark mode'),
                value: _dark,
                onChanged: (value) => setState(() => _dark = value),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('FAB pressed: $_count times'),
                ),
              ),
            ],
          ),
        ),
        // FAB cập nhật state; theme lấy màu từ MaterialApp.
        floatingActionButton: FloatingActionButton(
          tooltip: 'Increase counter',
          onPressed: () => setState(() => _count++),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
// Tự kiểm tra: bật dark mode đổi toàn màn hình; số đếm giữ nguyên khi đổi theme.
