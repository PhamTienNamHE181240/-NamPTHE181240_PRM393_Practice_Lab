import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab4_practice/Lab4_ex2.dart';
import 'package:lab4_practice/Lab4_ex3.dart';
import 'package:lab4_practice/Lab4_ex4.dart';
import 'package:lab4_practice/Lab4_ex5.dart';

void main() {
  testWidgets('Inputs and valid DatePicker context', (t) async {
    await t.pumpWidget(const MaterialApp(home: InputControlsDemo()));
    await t.tap(find.text('4K'));
    await t.pump();
    expect(find.text('Quality: 4K'), findsOneWidget);
    await t.tap(find.byType(Switch));
    await t.pumpAndSettle();
    expect(find.text('Off'), findsOneWidget);
    await t.ensureVisible(find.text('Choose date'));
    await t.tap(find.text('Choose date'));
    await t.pumpAndSettle();
    expect(find.byType(DatePickerDialog), findsOneWidget);
    await t.tap(find.text('Cancel'));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });
  testWidgets('Bounded ListView on small screen', (t) async {
    await t.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(const MaterialApp(home: LayoutDemo()));
    await t.drag(find.byType(ListView), const Offset(0, -400));
    await t.pumpAndSettle();
    expect(t.takeException(), isNull);
  });
  testWidgets('Theme preserves counter', (t) async {
    await t.pumpWidget(const StructureApp());
    await t.tap(find.byType(FloatingActionButton));
    await t.pump();
    await t.tap(find.byType(Switch));
    await t.pumpAndSettle();
    expect(find.text('FAB pressed: 1 times'), findsOneWidget);
    expect(
      t.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });
  testWidgets('Fixes page scroll and state', (t) async {
    await t.binding.setSurfaceSize(const Size(320, 300));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(const MaterialApp(home: FixesDemo()));
    await t.ensureVisible(find.text('Increase'));
    await t.tap(find.text('Increase'));
    await t.pump();
    expect(find.text('3. State counter: 1'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
}
