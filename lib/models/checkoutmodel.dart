import 'package:flutter/material.dart';

class CheckOutModel {
  late String name;
  late String image;
  late String size;
  late int quantity;
  late int price;

  CheckOutModel({
    required this.name,
    required this.image,
    required this.size,
    required this.quantity,
    required this.price,
  });
}
