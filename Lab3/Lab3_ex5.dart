// Exercise 5: factory constructor tra ve mot instance dung chung.
class Settings {
  // static: thuoc ve class; final: chi gan tham chieu mot lan.
  static final Settings _instance = Settings._internal();

  // Constructor private theo pham vi library.
  Settings._internal();

  // Moi lan goi Settings() deu tra ve cung instance da luu.
  factory Settings() {
    return _instance;
  }

  String theme = 'Light';
}

void main() {
  final Settings a = Settings();
  final Settings b = Settings();

  // identical kiem tra hai bien co tro den cung doi tuong khong.
  print('Same instance: ${identical(a, b)}'); // true.
  print('Initial theme of a: ${a.theme}');
  print('Initial theme of b: ${b.theme}');

  // Thay doi qua a cung duoc nhin thay qua b.
  a.theme = 'Dark';
  print('Theme of a after change: ${a.theme}');
  print('Theme of b after change: ${b.theme}'); // Dark.
}