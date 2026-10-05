import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LayoutDemo()));

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});
  @override
  Widget build(BuildContext context) {
    final titles = List.generate(20, (i) => 'Movie ${i + 1}');
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 3 • Layout')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.local_movies),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Popular movies',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('Scroll the list to discover more movies.'),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.movie_outlined),
                        title: Text(titles[index]),
                        subtitle: Text('Item ${index + 1} of ${titles.length}'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
