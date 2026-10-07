import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5_practice/main.dart';

void main() {
  testWidgets('Navigation, favorite, rating, back, different movie', (t) async {
    await t.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(const MovieApp());
    await t.pumpAndSettle();
    await t.tap(find.text('Dune: Part Two'));
    await t.pumpAndSettle();
    expect(find.text('Official Trailer #1'), findsOneWidget);
    await t.ensureVisible(find.byTooltip('Add favorite'));
    await t.tap(find.byTooltip('Add favorite'));
    await t.pump();
    expect(find.text('Favorited'), findsOneWidget);
    await t.tap(find.byTooltip('Rate movie'));
    await t.pumpAndSettle();
    await t.tap(find.text('4 / 5 stars'));
    await t.pumpAndSettle();
    expect(find.text('4 / 5'), findsOneWidget);
    await t.tap(find.byType(BackButton));
    await t.pumpAndSettle();
    expect(find.text('Movies'), findsOneWidget);
    await t.tap(find.text('Deadpool & Wolverine'));
    await t.pumpAndSettle();
    expect(find.text('Behind the Scenes'), findsOneWidget);
    expect(t.takeException(), isNull);
  });
}
