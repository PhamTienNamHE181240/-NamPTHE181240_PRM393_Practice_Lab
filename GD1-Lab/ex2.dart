abstract class Employee {
  String name;

  Employee(this.name);

  void work();
}

// TODO 1
mixin CheckInAbility on Employee {
  void checkIn() {
    print("$name da diem danh");
  }
}

// TODO 2
class Developer extends Employee with CheckInAbility {
  Developer(String name) : super(name);

  @override
  void work() {
    print("$name dang viet code.");
  }
}

void main() {
  List<Developer> teamA = [Developer("Hoa"), Developer("Nam")];

  List<Developer> teamB = [Developer("Duc")];

  // TODO 3
  List<Developer> allStaff = [...teamA, ...teamB];

  // TODO 4
  for (var person in allStaff) {
    person.checkIn();
  }
}
