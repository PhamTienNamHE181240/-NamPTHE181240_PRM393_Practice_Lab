import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Movie {
  final String id, title, posterUrl, overview;
  final List<String> genres;
  final double rating;
  final List<Trailer> trailers;
  const Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
  });
}

class Trailer {
  final String title;
  const Trailer(this.title);
}

const sampleMovies = <Movie>[
  Movie(
    id: 'dune',
    title: 'Dune: Part Two',
    posterUrl: 'https://picsum.photos/seed/dune/800/450',
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: [Trailer('Official Trailer #1'), Trailer('IMAX Sneak Peek')],
  ),
  Movie(
    id: 'deadpool',
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://picsum.photos/seed/deadpool/800/450',
    overview: 'Two unlikely allies join forces on an adventure across worlds.',
    genres: ['Action', 'Comedy'],
    rating: 8.3,
    trailers: [Trailer('Official Trailer'), Trailer('Behind the Scenes')],
  ),
  Movie(
    id: 'insideout',
    title: 'Inside Out 2',
    posterUrl: 'https://picsum.photos/seed/insideout/800/450',
    overview: 'Riley enters a new stage of life as new emotions arrive at headquarters.',
    genres: ['Animation', 'Family'],
    rating: 7.6,
    trailers: [Trailer('Teaser Trailer')],
  ),
];

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

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});
  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  bool _favorite = false;
  int? _rating;

  Future<void> _rate() async {
    final value = await showDialog<int>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Your rating'),
        children: [
          for (var i = 1; i <= 5; i++)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(dialogContext, i),
              child: Text('$i / 5 stars'),
            ),
        ],
      ),
    );
    if (!mounted || value == null) return;
    setState(() => _rating = value);
  }

  Future<void> _share() async {
    try {
      await Clipboard.setData(
        ClipboardData(
          text: '${widget.movie.title} — rating ${widget.movie.rating}/10',
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Movie information copied.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Clipboard is unavailable on this device.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Hero(
                        tag: movie.id,
                        child: Image.network(
                          movie.posterUrl,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, error, stack) => const SizedBox(
                            height: 250,
                            child: Center(child: Icon(Icons.movie, size: 72)),
                          ),
                        ),
                      ),
                      const Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black87],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        right: 16,
                        bottom: 16,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final genre in movie.genres)
                              Chip(label: Text(genre)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          movie.overview,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 24,
                          runSpacing: 8,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: _favorite
                                      ? 'Remove favorite'
                                      : 'Add favorite',
                                  onPressed: () =>
                                      setState(() => _favorite = !_favorite),
                                  icon: Icon(
                                    _favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: _favorite ? Colors.red : null,
                                  ),
                                ),
                                Text(_favorite ? 'Favorited' : 'Favorite'),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Rate movie',
                                  onPressed: _rate,
                                  icon: const Icon(Icons.star),
                                ),
                                Text(_rating == null ? 'Rate' : '$_rating / 5'),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  tooltip: 'Copy movie information',
                                  onPressed: _share,
                                  icon: const Icon(Icons.share),
                                ),
                                const Text('Share'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Trailers',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: movie.trailers.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: const Icon(Icons.play_circle),
                            title: Text(movie.trailers[index].title),
                            onTap: () => showDialog<void>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(movie.trailers[index].title),
                                content: const Text(
                                  'Static trailer sample. No video source is configured.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
