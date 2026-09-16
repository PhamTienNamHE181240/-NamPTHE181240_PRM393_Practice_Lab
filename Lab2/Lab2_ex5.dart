// Future tra ve mot ket qua sau khi hoan thanh tac vu bat dong bo.
Future<String> fetchGreeting() async {
  await Future<void>.delayed(const Duration(seconds: 2));
  return 'Loading completed!';
}

// Stream phat nhieu gia tri, moi gia tri cach nhau 500 ms.
Stream<int> countStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    yield i;
  }
}

// Kieu String? cho phep tra ve null.
String? findFood(bool available) => available ? 'Pho' : null;

Future<void> main() async {
  String? food = findFood(false);

  // ?? cung cap gia tri thay the khi food la null.
  print('Favorite food: ${food ?? "No favorite selected"}');

  // ?. chi truy cap length neu food khong null.
  print('Initial food name length: ${food?.length ?? 0}');

  food = findFood(true);
  // ! khang dinh khong null: o day findFood(true) tra ve Pho.
  // Neu gia tri thuc su la null, dung ! se gay loi khi chay.
  print('Selected food: ${food!.toUpperCase()}');
  print('');

  print('Loading...');
  String message = await fetchGreeting();
  print(message);

  // listen nhan tung gia tri; asFuture cho phep cho stream ket thuc.
  await countStream().listen((number) {
    print('Count: $number');
  }).asFuture<void>();
  print('Stream finished.');
}