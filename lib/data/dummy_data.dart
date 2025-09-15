import 'package:flutter/material.dart';
import 'package:ecom_app/models/product.dart';

// Your product categories
const List<Map<String, dynamic>> categories = [
  {'name': 'Clothing', 'icon': Icons.dry_cleaning_outlined},
  {'name': 'Electronics', 'icon': Icons.devices_other_outlined},
  {'name': 'Home', 'icon': Icons.home_outlined},
  {'name': 'Shoes', 'icon': Icons.shopping_bag_outlined},
  {'name': 'Beauty', 'icon': Icons.face},
];

// Your product list with local asset images
final List<Product> dummyProducts = [
  Product(
    id: 'p1',
    category: 'Clothing',
    name: 'Classic Orange T-Shirt',
    description:
    'A timeless, comfortable t-shirt made from 100% organic cotton. A versatile piece for any wardrobe.',
    price: 25.00,
    imageUrls: [
      ('https://www.pngarts.com/files/5/Plain-Orange-T-Shirt-PNG-Photo.png'),
      ('https://www.pngplay.com/wp-content/uploads/6/Electronic-Transparent-Background.png'),
    ],
    colors: [Colors.white, Colors.black, Colors.grey],
    sizes: ['S', 'M', 'L', 'XL'],
    rating: 4.8,
  ),
  Product(
    id: 'p2',
    category: 'Clothing',
    name: 'Slim Fit Chinos',
    description:
    'Stylish and comfortable slim fit chinos, perfect for both casual and semi-formal occasions. Made with a flexible, breathable fabric.',
    price: 60.00,
    imageUrls: [
      ('https://i.pinimg.com/originals/96/b2/6b/96b26bdf117bc4d1e607391399720c93.jpg'),
      ('https://i.ebayimg.com/00/s/OTAwWDkwMA==/z/M5MAAOSw9j5gGAmW/.JPG?set_id=8800005007'),
    ],
    colors: [Colors.blue, Colors.black, Colors.grey],
    sizes: ['28', '30', '32', '34'],
    rating: 4.5,
  ),
  Product(
    id: 'p3',
    category: 'Shoes',
    name: 'Casual Sneakers',
    description:
    'Lightweight and breathable sneakers designed for all-day comfort. Features a cushioned sole and a stylish, versatile design.',
    price: 90.00,
    imageUrls: [
      ('https://cf.shopee.co.th/file/adcdeae539f158a0435d5942bc54691a'),
      ('https://wallpapers.com/images/hd/orange-casual-sneakers-vector-6976rc92yvxyj2eq.png'),
    ],
    colors: [Colors.white, Colors.black, Colors.blue],
    sizes: ['7', '8', '9', '10'],
    rating: 4.9,
  ),
  Product(
    id: 'p4',
    category: 'Electronics',
    name: 'Wireless Bluetooth Earbuds',
    description:
    'Experience crystal-clear audio with these ergonomic wireless earbuds. Features a long-lasting battery and touch controls.',
    price: 150.00,
    imageUrls: [
      ('https://m.media-amazon.com/images/I/716gAr0KA6L.jpg'),
      ('https://m.media-amazon.com/images/I/61jXyRRMssL._AC_SL1500_.jpg'),
    ],
    colors: [Colors.black, Colors.white],
    sizes: ['One Size'],
    rating: 4.7,
  ),
  Product(
    id: 'p5',
    category: 'Bags',
    name: 'Travel Backpack',
    description:
    'A durable and spacious backpack with multiple compartments, perfect for travel or daily commutes. Features padded straps for comfort.',
    price: 85.00,
    imageUrls: [
      ('https://m.media-amazon.com/images/I/812A49jPRsL._AC_SL1500_.jpg'),
      ('https://images-na.ssl-images-amazon.com/images/I/91BYaohpdgL.jpg'),
    ],
    colors: [Colors.black, Colors.grey, Colors.blue],
    sizes: ['One Size'],
    rating: 4.6,
  ),
  Product(
    id: 'p6',
    category: 'Home',
    name: 'Smart Coffee Maker',
    description:
    'Brew your favorite coffee from your phone with this smart coffee maker. Customizable settings and a self-cleaning feature.',
    price: 199.99,
    imageUrls: [
      ('https://tse1.mm.bing.net/th/id/OIP.5YOra44zHUiTgoZ7JbQfGQHaHa?pid=Api&h=220&P=0'),
      ('https://tencoffees.com/wp-content/uploads/2023/09/smart-coffee-machine.png'),
    ],
    colors: [Colors.black, Colors.white, Colors.brown],
    sizes: ['One Size'],
    rating: 4.7,
  ),
  Product(
    id: 'p7',
    category: 'Beauty',
    name: 'Natural Face Serum',
    description:
    'A hydrating face serum with all-natural ingredients to give your skin a healthy glow. Suitable for all skin types.',
    price: 45.00,
    imageUrls: [
      ('https://img.etsystatic.com/il/4ece18/1409789062/il_fullxfull.1409789062_hzns.jpg?version=2'),
      ('https://www.sustainablejungle.com/wp-content/uploads/2023/05/Image-by-Little-Seed-Farm-3.jpg'),
    ],
    colors: [],
    sizes: ['30ml'],
    rating: 4.9,
  ),
];

// Filter products by category
List<Product> getProductsByCategory(String category) {
  return dummyProducts
      .where((product) => product.category == category)
      .toList();
}
