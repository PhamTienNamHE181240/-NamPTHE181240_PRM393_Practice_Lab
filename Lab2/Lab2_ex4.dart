class Car {
  String brand;
  double price;
  bool isLuxury;

  // Constructor thuong, mac dinh khong phai xe hang sang.
  Car(this.brand, this.price) : isLuxury = false;

  // Named constructor tao xe hang sang.
  Car.luxuryCar(this.brand, this.price) : isLuxury = true;

  void showInfo() {
    print('Brand: $brand');
    print('Price: $price');
    print('Is luxury: $isLuxury');
  }
}

class ElectricCar extends Car {
  double batteryCapacity;

  // super goi constructor cua lop cha de khoi tao brand va price.
  ElectricCar(String brand, double price, this.batteryCapacity)
      : super(brand, price);

  // Ghi de phuong thuc de hien thi thong tin rieng cua xe dien.
  @override
  void showInfo() {
    print('Brand: $brand');
    print('Price: $price');
    print('Battery capacity: $batteryCapacity kWh');
  }
}

void main() {
  Car myCar = Car('Toyota', 20000);
  myCar.showInfo();
  print('');

  Car myLuxuryCar = Car.luxuryCar('Mercedes', 50000);
  myLuxuryCar.showInfo();
  print('');

  ElectricCar myElectricCar = ElectricCar('VinFast', 60000, 100);
  myElectricCar.showInfo();
}