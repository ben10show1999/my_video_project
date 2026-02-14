import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles { 
  static const TextStyle headlineLarge = TextStyle(
    color: AppColors.textPrimary, 
    fontSize: 26, 
    fontWeight: FontWeight.bold, 
    height: 1.2
  ); 
  
  static const TextStyle headlineMedium = TextStyle(
    color: AppColors.textPrimary, 
    fontSize: 20, 
    fontWeight: FontWeight.bold
  ); 
  
  static const TextStyle tagText = TextStyle(
    color: AppColors.textPrimary, 
    fontSize: 11, 
    fontWeight: FontWeight.w600
  ); 
}
