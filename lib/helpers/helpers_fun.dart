import 'package:flutter/material.dart';

class HelpersFun {
  IconData getCategoryIcon(String category) {
    final key = category.toLowerCase();
    if (key.contains('groceries')) return Icons.shopping_cart;
    if (key.contains('transport')) return Icons.directions_car;
    if (key.contains('gas')) return Icons.gas_meter;
    if (key.contains('entertain')) return Icons.movie;
    if (key.contains('rent')) return Icons.attach_money;
    if (key.contains('travel')) return Icons.flight;
    if (key.contains('shopping')) return Icons.shopping_bag;
    if (key.contains('news')) return Icons.newspaper;

    return Icons.category; // fallback
  }

  Color getCategoryColor(String category) {
    final key = category.toLowerCase();
    if (key.contains('entertain')) return Colors.purple;
    if (key.contains('groc')) return Colors.blue;
    if (key.contains('transport')) return Colors.blueGrey;
    if (key.contains('shop')) return Colors.pink;
    if (key.contains('gas')) return Colors.pink;
    if (key.contains('rent')) return Colors.red;
    if (key.contains('news')) return Colors.amberAccent;
    return Colors.blueGrey; // fallback
  }
}
