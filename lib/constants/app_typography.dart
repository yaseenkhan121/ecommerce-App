import 'package:flutter/material.dart';
import 'package:ecom_app/constants/app_colors.dart';

class AppTypography {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkGrey,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.darkGrey,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: AppColors.darkGrey,
  );

  static const TextStyle linkText = TextStyle(
    fontSize: 14,
    color: AppColors.primaryOrange,
    fontWeight: FontWeight.bold,
  );
}
