import 'package:ecom_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/constants/app_colors.dart';
import 'package:ecom_app/constants/app_typography.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:ecom_app/models/product.dart';
import 'package:ecom_app/data/cart_manager.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _selectedSize;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.product.sizes.first;
    _selectedColor = widget.product.colors.first;
  }

  void _selectSize(String size) {
    setState(() {
      _selectedSize = size;
    });
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Stack(
        children: [
          // Product Image Section
          Positioned.fill(
            child: Container(
              color: const Color.fromRGBO(204, 204, 204, 0.2),
              child: Image.network(
                widget.product.imageUrls.first,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Product Details Card
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(128, 128, 128, 0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name, style: AppTypography.titleStyle),
                  const SizedBox(height: 8),
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                            (index) => Icon(
                          index < widget.product.rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: AppColors.primaryOrange,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.rating.toString()} total',
                        style: AppTypography.bodyText,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Colors',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: widget.product.colors
                        .map((color) => _buildColorOption(color))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Size',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: widget.product.sizes
                        .map((size) => _buildSizeOption(size))
                        .toList(),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            CartManager.increment(widget.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${widget.product.name} added to cart!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomButton(
                          text: 'Buy Now',
                          onPressed: () {
                            CartManager.increment(widget.product);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartScreen(),
                              ),
                            );
                          },
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Top bar with back and favorite icons
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.backgroundWhite,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: AppColors.darkGrey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.backgroundWhite,
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border,
                        color: AppColors.darkGrey),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Added to favorites!')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return GestureDetector(
      onTap: () => _selectColor(color),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: _selectedColor == color
              ? Border.all(color: AppColors.primaryOrange, width: 2)
              : null,
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    return GestureDetector(
      onTap: () => _selectSize(size),
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.only(right: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _selectedSize == size
              ? AppColors.primaryOrange
              : AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: _selectedSize == size
                ? AppColors.backgroundWhite
                : AppColors.darkGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
