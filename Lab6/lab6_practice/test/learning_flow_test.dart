import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab6_practice/Lab6_ex3.dart';

void main() {
  for (final size in [
    const Size(320, 568),
    const Size(390, 844),
    const Size(800, 900),
    const Size(1200, 800),
  ]) {
    testWidgets('Viewport ${size.width}', (t) async {
      await t.binding.setSurfaceSize(size);
      addTearDown(() => t.binding.setSurfaceSize(null));
      await t.pumpWidget(const ResponsiveMovieApp());
      await t.pumpAndSettle();
      expect(
        find.byType(GridView),
        size.width >= 800 ? findsOneWidget : findsNothing,
      );
      expect(t.takeException(), isNull);
    });
  }
  testWidgets('Search, empty, clear, genre OR, rating sort', (t) async {
    await t.binding.setSurfaceSize(const Size(1200, 1000));
    addTearDown(() => t.binding.setSurfaceSize(null));
    await t.pumpWidget(const ResponsiveMovieApp());
    await t.pumpAndSettle();
    await t.enterText(find.byType(TextField), 'DUNE');
    await t.pumpAndSettle();
    expect(find.text('1 movies • 0 genres selected'), findsOneWidget);
    await t.enterText(find.byType(TextField), 'not-a-movie');
    await t.pumpAndSettle();
    expect(find.text('No movies match your filters.'), findsOneWidget);
    await t.tap(find.text('Clear filters'));
    await t.pumpAndSettle();
    await t.tap(find.widgetWithText(FilterChip, 'Drama'));
    await t.pumpAndSettle();
    await t.tap(find.widgetWithText(FilterChip, 'Comedy'));
    await t.pumpAndSettle();
    expect(find.text('5 movies • 2 genres selected'), findsOneWidget);
    await t.tap(find.byType(DropdownButton<String>));
    await t.pumpAndSettle();
    await t.tap(find.text('Rating').last);
    await t.pumpAndSettle();
    expect(
      t.widgetList<MovieCard>(find.byType(MovieCard)).first.movie.title,
      'The Dark Knight',
    );
    expect(t.takeException(), isNull);
  });
}
