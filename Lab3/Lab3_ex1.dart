import 'dart:async';

// Mo ta mot san pham.
class Product {
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price}';
  }
}

// Quan ly danh sach va phat thong bao san pham moi.
class ProductRepository {
  final List<Product> _products = [
    Product(1, 'Laptop', 1200.0),
    Product(2, 'Smartphone', 800.0),
    Product(3, 'Tablet', 500.0),
  ];

  final StreamController<Product> _controller =
      StreamController<Product>.broadcast();

  // Lay danh sach bat dong bo theo yeu cau de.
  Future<List<Product>> getAll() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return List<Product>.from(_products);
  }

  // Tra ve null neu khong tim thay san pham.
  Product? findProductById(int id) {
    for (final product in _products) {
      if (product.id == id) {
        return product;
      }
    }
    return null;
  }

  // Cung cap stream de lang nghe san pham moi.
  Stream<Product> liveAdded() {
    return _controller.stream;
  }

  // Them vao repository hien tai, khong tao repository moi.
  void addProduct(Product product) {
    _products.add(product);
    _controller.add(product);
  }

  // Dong controller khi su dung xong.
  Future<void> dispose() async {
    await _controller.close();
  }
}

Future<void> main() async {
  final repository = ProductRepository();
  print('Loading...');

  // Goi ham getAll() tra ve Future<List<Product>>.
  final products = await repository.getAll();

  for (final product in products) {
    print(product);
  }

  // Dang ky lang nghe truoc khi them san pham.
  final subscription = repository.liveAdded().listen((product) {
    print('New product added: $product');
  });

  print('Adding new products...');

  await Future<void>.delayed(const Duration(seconds: 1));
  repository.addProduct(Product(4, 'Smartwatch', 300.0));

  await Future<void>.delayed(const Duration(seconds: 1));
  repository.addProduct(Product(5, 'Headphones', 150.0));

  await repository.dispose();
  await subscription.cancel();
}
