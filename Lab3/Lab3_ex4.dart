// Exercise 4: bien doi va loc cac gia tri cua Stream.
Future<void> main() async {
  // Stream phat lan luot cac so tu 1 den 5.
  final Stream<int> numbers = Stream<int>.fromIterable([1, 2, 3, 4, 5]);

  // map binh phuong moi so; where chi giu ket qua chan.
  final Stream<int> evenSquares = numbers
      .map((number) => number * number)
      .where((square) => square % 2 == 0);

  print('Original numbers: 1, 2, 3, 4, 5');
  print('Even squares:');

  // Lang nghe tung ket qua va cho stream ket thuc.
  await evenSquares.listen((value) {
    print(value); // Ket qua: 4, 16.
  }).asFuture<void>();

  print('Stream finished.');
}