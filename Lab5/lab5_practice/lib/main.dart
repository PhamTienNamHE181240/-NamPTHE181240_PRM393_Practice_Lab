import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() => runApp(const MovieApp());

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Lab 5 Movies',
    theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
    home: const HomeScreen(),
  );
}
