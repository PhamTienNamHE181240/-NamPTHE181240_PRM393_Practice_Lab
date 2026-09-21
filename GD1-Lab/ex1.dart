//TODO 1:
class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void startEngine() {
    print("Phuong tien khoi dong");
  }
} //TODO 2:

class Car extends Vehicle {
  bool isElectric;

  Car(String brand, int year, this.isElectric) : super(brand, year);

  // Viết Named Constructor: Car.tesla(int year) thiết lập sẵn brand="Tesla" và isElectric=true. TODO 3:
  Car.tesla(int year) : isElectric = true, super('Tesla', year);

  //TODO 4:
  @override
  void startEngine() {
    if (isElectric) {
      print('${brand} - ${year} khoi dong bang dong co dien');
    } else {
      print('${brand} - ${year} khoi dong bang dong co xang');
    }
  }
} //TODO 5:

void main() {
  Car car = Car('Toyota', 2000, false);
  car.startEngine();
  //TODO 6:
  Car teslaCar = Car.tesla(2024);
  teslaCar.startEngine();
}
