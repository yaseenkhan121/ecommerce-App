import 'package:ecom_app/models/product.dart';

class CartManager {
  // A private static map to store cart items and their quantities.
  static final Map<Product, int> _items = {};

  // Public getter to access the cart items.
  static Map<Product, int> get items => _items;

  // Method to add or increment a product in the cart.
  static void increment(Product product) {
    if (_items.containsKey(product)) {
      _items[product] = _items[product]! + 1;
    } else {
      _items[product] = 1;
    }
  }

  // Method to decrement a product's quantity, removing it if quantity drops to 0.
  static void decrement(Product product) {
    if (_items.containsKey(product)) {
      if (_items[product]! > 1) {
        _items[product] = _items[product]! - 1;
      } else {
        _items.remove(product);
      }
    }
  }

  // Method to completely remove a product from the cart.
  static void removeItem(Product product) {
    _items.remove(product);
  }

  // Getter to calculate the subtotal of all items in the cart.
  static double get subtotal {
    return _items.keys.fold(0.0, (sum, product) => sum + product.price * _items[product]!);
  }

  // Getter to calculate the total cost including a flat shipping rate.
  static double get total {
    const double shipping = 5.00;
    return subtotal + shipping;
  }
}
