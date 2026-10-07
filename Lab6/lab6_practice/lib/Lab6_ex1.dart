import 'package:flutter/material.dart';

const int stage = 1;
void main() => runApp(const ResponsiveMovieApp());

class Movie {
  final String title, posterUrl;
  final int year;
  final List<String> genres;
  final double rating;
  const Movie(this.title, this.year, this.genres, this.rating, this.posterUrl);
}

const allMovies = <Movie>[
  Movie(
    'Dune: Part Two',
    2024,
    ['Sci-Fi', 'Drama'],
    8.6,
    'https://picsum.photos/seed/dune/240/360',
  ),
  Movie(
    'Inside Out 2',
    2024,
    ['Animation', 'Comedy'],
    7.6,
    'https://picsum.photos/seed/insideout/240/360',
  ),
  Movie(
    'The Dark Knight',
    2008,
    ['Action', 'Drama'],
    9.0,
    'https://picsum.photos/seed/batman/240/360',
  ),
  Movie(
    'Interstellar',
    2014,
    ['Sci-Fi', 'Drama'],
    8.7,
    'https://picsum.photos/seed/space/240/360',
  ),
  Movie(
    'The Grand Budapest Hotel',
    2014,
    ['Comedy', 'Drama'],
    8.1,
    'https://picsum.photos/seed/hotel/240/360',
  ),
  Movie(
    'Spider-Man: Into the Spider-Verse',
    2018,
    ['Action', 'Animation'],
    8.4,
    'https://picsum.photos/seed/spider/240/360',
  ),
];

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.deepPurple),
    home: const GenreScreen(),
  );
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});
  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  final _searchController = TextEditingController();
  String _query = '';
  final Set<String> _selectedGenres = {};
  String _sort = 'A–Z';
  static const _genres = ['Action', 'Drama', 'Comedy', 'Sci-Fi', 'Animation'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Movie> get _visibleMovies {
    final query = _query.trim().toLowerCase();
    final movies = allMovies.where((movie) {
      final matchesText = movie.title.toLowerCase().contains(query);
      final matchesGenre =
          _selectedGenres.isEmpty || movie.genres.any(_selectedGenres.contains);
      return matchesText && matchesGenre;
    }).toList();
    switch (_sort) {
      case 'Z–A':
        movies.sort((a, b) => b.title.compareTo(a.title));
      case 'Year':
        movies.sort(
          (a, b) => b.year != a.year
              ? b.year.compareTo(a.year)
              : a.title.compareTo(b.title),
        );
      case 'Rating':
        movies.sort((a, b) => b.rating.compareTo(a.rating));
      default:
        movies.sort((a, b) => a.title.compareTo(b.title));
    }
    return movies;
  }

  void _clear() {
    _searchController.clear();
    setState(() {
      _query = '';
      _selectedGenres.clear();
      _sort = 'A–Z';
    });
  }

  Widget _heading(bool wide) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      padding: EdgeInsets.all(wide ? 24 : 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff4527a0), Color(0xff1565c0)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.movie_filter, color: Colors.white, size: 36),
          const SizedBox(height: 12),
          Text(
            'Find a Movie',
            style: TextStyle(
              color: Colors.white,
              fontSize: wide ? 36 : 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Discover stories for your next movie night.',
            style: TextStyle(color: Colors.white),
          ),
          if (stage == 1) ...[
            const SizedBox(height: 12),
            Text(
              'Viewport: ${screenWidth.round()} px • ${wide ? "Wide" : "Compact"}',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }

  Widget _controls(bool wide) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _heading(wide),
      const SizedBox(height: 16),
      TextField(
        controller: _searchController,
        decoration: const InputDecoration(
          labelText: 'Search movies',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        onChanged: (value) => setState(() => _query = value),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final genre in _genres)
            FilterChip(
              label: Text(genre),
              selected: _selectedGenres.contains(genre),
              onSelected: (selected) => setState(() {
                if (selected) {
                  _selectedGenres.add(genre);
                } else {
                  _selectedGenres.remove(genre);
                }
              }),
            ),
        ],
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text('Sort:'),
          DropdownButton<String>(
            value: _sort,
            items: ['A–Z', 'Z–A', 'Year', 'Rating']
                .map(
                  (value) => DropdownMenuItem(value: value, child: Text(value)),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _sort = value);
            },
          ),
          TextButton(onPressed: _clear, child: const Text('Clear filters')),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final movies = _visibleMovies;
    return Scaffold(
      appBar: AppBar(title: Text('Lab 6.$stage • Responsive movies')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 800;
            final padding = wide ? 24.0 : 16.0;
            if (stage == 1) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(padding),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: SizedBox(
                      width: double.infinity,
                      child: _heading(wide),
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: (constraints.maxHeight - padding * 2) * 0.55,
                    ),
                    child: SingleChildScrollView(child: _controls(wide)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${movies.length} movies • ${_selectedGenres.length} genres selected',
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: movies.isEmpty
                        ? const Center(
                            child: Text('No movies match your filters.'),
                          )
                        : stage == 2
                        // Mốc 6.2: xem kết quả dạng text để học lọc/sắp xếp trước.
                        ? ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (_, i) => ListTile(
                              title: Text(movies[i].title),
                              subtitle: Text(
                                '${movies[i].year} • ★ ${movies[i].rating}',
                              ),
                            ),
                          )
                        : wide
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  mainAxisExtent:
                                      160 +
                                      45 *
                                          MediaQuery.textScalerOf(context)
                                              .scale(1),
                                ),
                            itemCount: movies.length,
                            itemBuilder: (_, i) => MovieCard(movie: movies[i]),
                          )
                        : ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (_, i) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: MovieCard(movie: movies[i]),
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    // Đo chiều rộng của CARD, không suy ra từ tên thiết bị.
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth < 400 ? 64.0 : 90.0;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.posterUrl,
                    width: imageWidth,
                    height: imageWidth * 1.4,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stack) => SizedBox(
                      width: imageWidth,
                      height: imageWidth * 1.4,
                      child: const Icon(Icons.movie_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text('${movie.year} • ★ ${movie.rating}'),
                      Text(
                        movie.genres.join(', '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
// Tự kiểm tra: 390/800/1200 px; tìm DUNE; chọn Drama + Comedy (OR);
// sort Rating/Year giảm dần; gõ tên không có kết quả; Clear filters.
