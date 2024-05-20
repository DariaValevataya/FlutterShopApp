import 'package:flutter/material.dart';

class UserModel {
  String UserName;
  String UserEmail;
  String UserPhoneNumber;
  String UserAddress;

  UserModel({
    required this.UserName,
    required this.UserAddress,
    required this.UserEmail,
    required this.UserPhoneNumber,
  });
}
