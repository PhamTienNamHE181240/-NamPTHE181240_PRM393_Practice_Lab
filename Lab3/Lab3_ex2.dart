import 'dart:convert';

// Mo ta nguoi dung.
class User {
  final String name;
  final String email;

  User(this.name, this.email);

  // Chuyen Map lay tu JSON thanh doi tuong User.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name'] as String, json['email'] as String);
  }

  @override
  String toString() {
    return 'Name: $name, Email: $email';
  }
}

// Gia lap lay du lieu nguoi dung tu API.
class UserRepository {
  Future<List<User>> getAll() async {
    // Gia lap thoi gian cho phan hoi.
    await Future<void>.delayed(const Duration(seconds: 1));

    // Chuoi JSON gia lap do API tra ve.
    const String response = '''
    [
      {"name": "Nam", "email": "nam@example.com"},
      {"name": "An", "email": "an@example.com"},
      {"name": "Linh", "email": "linh@example.com"}
    ]
    ''';

    // Giai ma chuoi JSON thanh danh sach.
    final List<dynamic> data = jsonDecode(response) as List<dynamic>;

    // Chuyen tung Map thanh User, sau do tao List<User>.
    return data.map((item) {
      return User.fromJson(item as Map<String, dynamic>);
    }).toList();
  }
}

Future<void> main() async {
  final repository = UserRepository();

  print('Loading users...');

  // Cho lay va chuyen doi du lieu xong.
  final List<User> users = await repository.getAll();

  for (final user in users) {
    print(user);
  }

  print('Total users: ${users.length}');
}
