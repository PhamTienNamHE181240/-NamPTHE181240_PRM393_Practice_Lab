import 'package:flutter/material.dart';

import 'core_widgets_demo.dart';
import 'Lab4_ex2.dart';
import 'Lab4_ex3.dart';
import 'Lab4_ex4.dart';
import 'Lab4_ex5.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
    home: const Lab4Menu(),
  ),
);

class Lab4Menu extends StatelessWidget {
  const Lab4Menu({super.key});
  @override
  Widget build(BuildContext context) {
    final pages = <(String, Widget)>[
      ('Exercise 1 • Core Widgets', const CoreWidgetsDemo()),
      ('Exercise 2 • Input Controls', const InputControlsDemo()),
      ('Exercise 3 • Layout', const LayoutDemo()),
      ('Exercise 4 • Structure & Theme', const StructureApp()),
      ('Exercise 5 • UI Fixes', const FixesDemo()),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Lab 4 • Flutter UI')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final page in pages)
            Card(
              child: ListTile(
                title: Text(page.$1),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => Scaffold(
                      appBar: page.$2 is StructureApp
                          ? AppBar(title: const Text('Back to exercises'))
                          : null,
                      body: page.$2,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
