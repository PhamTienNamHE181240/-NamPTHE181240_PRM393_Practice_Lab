import 'package:flutter/material.dart';

import 'movie_detail_screen.dart';
import 'sample_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sampleMovies.length,
              itemBuilder: (context, index) {
                final movie = sampleMovies[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Hero(
                      tag: movie.id,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.posterUrl,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (_, error, stack) => const SizedBox(
                            width: 64,
                            height: 64,
                            child: Icon(Icons.movie),
                          ),
                        ),
                      ),
                    ),
                    title: Text(movie.title),
                    subtitle: Text(
                      '★ ${movie.rating} • ${movie.genres.join(", ")}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        // Truyền chính đối tượng Movie của item vừa được bấm.
                        builder: (_) => MovieDetailScreen(movie: movie),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
