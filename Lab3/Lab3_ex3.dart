import 'dart:async';

void main() {
  // Code dong bo: chay ngay.
  print('1. Main starts');

  // Dua callback vao event queue, chua chay ngay.
  Future<void>(() {
    print('5. Future event');

    // Microtask nay duoc tao trong luc xu ly event.
    scheduleMicrotask(() {
      print('6. Microtask inside Future');
    });
  });

  // Dua callback vao microtask queue.
  scheduleMicrotask(() {
    print('3. First microtask');
  });

  // Microtask duoc xu ly theo thu tu dang ky.
  scheduleMicrotask(() {
    print('4. Second microtask');
  });

  // Them mot callback vao event queue.
  Future<void>(() {
    print('7. Second Future event');
  });

  // Van la code dong bo nen chay truoc cac callback tren.
  print('2. Main ends');
}
