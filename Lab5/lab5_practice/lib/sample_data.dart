import 'movie.dart';

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
