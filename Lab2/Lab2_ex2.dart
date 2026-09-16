void main() {
  // List co thu tu, chi so bat dau tu 0.
  List<int> numbers = [1, 2, 3, 4, 5];
  print('First number: ${numbers[0]}');
  numbers.remove(1);
  numbers.add(6);
  print('List after modifications: $numbers');
  print('Length of the list: ${numbers.length}');

  // Set chi luu gia tri duy nhat, Apple khong bi lap lai.
  Set<String> fruits = {'Apple', 'Banana', 'Orange'};
  fruits.add('Apple');
  print('Set of fruits: $fruits');

  // Map luu cac cap khoa - gia tri.
  Map<String, int> ages = {'Nam': 20, 'Huyen': 25, 'Hoa': 30};
  print("Hoa's age: ${ages['Hoa']}");
  ages['Nam'] = 21;
  print("Nam's updated age: ${ages['Nam']}");

  // Toan tu so hoc, so sanh, logic va ba ngoi.
  int a = 10;
  int b = 5;
  print('Sum of a and b: ${a + b}');
  print('Difference of a and b: ${a - b}');
  print('a equals b: ${a == b}');
  print('Both are positive: ${a > 0 && b > 0}');
  print(a > b ? 'a is greater than b' : 'a is not greater than b');
}