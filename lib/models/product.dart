import 'package:flutter/material.dart';

class Product {
  final String id;
  final String category;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final List<Color> colors;
  final List<String> sizes;
  final double rating;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.colors,
    required this.sizes,
    required this.rating,
  });
}
