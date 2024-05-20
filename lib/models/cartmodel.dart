import 'package:flutter/material.dart';

class CartModel {
  late String name;
  late String image;
  late String size;
  late int quantity;
  late int price;
  CartModel({
    required this.name,
    required this.image,
    required this.size,
    required this.quantity,
    required this.price,
  });
}
