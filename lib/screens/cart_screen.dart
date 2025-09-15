import 'package:flutter/material.dart';
import 'package:ecom_app/constants/app_colors.dart';
import 'package:ecom_app/constants/app_typography.dart';
import 'package:ecom_app/data/cart_manager.dart';
import 'package:ecom_app/widgets/custom_text_field.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:ecom_app/models/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartManager.items;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.darkGrey,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cart',
          style: AppTypography.titleStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: cartItems.isEmpty
                  ? const Center(
                child: Text(
                  "Your cart is empty",
                  style: AppTypography.bodyText,
                ),
              )
                  : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems.keys.elementAt(index);
                  final quantity = cartItems.values.elementAt(index);
                  return _buildCartItem(product, quantity);
                },
              ),
            ),
            _buildCouponSection(),
            const SizedBox(height: 20),
            _buildOrderSummary(),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Checkout',
              onPressed: () {
                // Checkout logic
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(Product product, int quantity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(product.imageUrls[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTypography.bodyText,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGrey,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          CartManager.decrement(product);
                        });
                      },
                      icon: const Icon(Icons.remove, color: AppColors.darkGrey),
                    ),
                    Text(
                      quantity.toString(),
                      style: AppTypography.bodyText
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          CartManager.increment(product);
                        });
                      },
                      icon: const Icon(Icons.add, color: AppColors.darkGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                CartManager.removeItem(product);
              });
            },
            icon: const Icon(Icons.delete_outline),
            color: AppColors.darkGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildCouponSection() {
    return Row(
      children: [
        const Expanded(
          child: CustomTextField(
            hintText: 'Coupon code',
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Apply',
            style: AppTypography.linkText,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Subtotal', style: AppTypography.bodyText),
            Text(
              '\$${CartManager.subtotal.toStringAsFixed(2)}',
              style: AppTypography.bodyText,
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shipping', style: AppTypography.bodyText),
            Text('\$5.00', style: AppTypography.bodyText),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGrey,
              ),
            ),
            Text(
              '\$${CartManager.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryOrange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
