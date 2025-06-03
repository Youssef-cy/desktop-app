import 'dart:io';
import 'package:flutter/material.dart';

class InventoryItem {
  final String name;
  final String price;
  final String quantity;
  final File? image;

  InventoryItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}

ValueNotifier<List<InventoryItem>> inventoryListNotifier = ValueNotifier([]);
