import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'movie.dart';

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
      // Navigator.push tự cung cấp nút Back trên AppBar.
      appBar: AppBar(title: Text(movie.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero nối hai ảnh cùng tag giữa Home và Detail.
                  // Stack xếp gradient lên ảnh để phần chữ phía dưới dễ đọc.
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
