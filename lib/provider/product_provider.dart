import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work/models/ordermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cartmodel.dart';
import '../models/checkoutmodel.dart';
import '../models/product.dart';
import '../models/usermodel.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  late Product productData;

  List<CartModel> cartModelList = [];
  late CartModel cartModel;

  List<UserModel> UserModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      QuerySnapshot UserSnapshot =
          await FirebaseFirestore.instance.collection("users").get();

      UserSnapshot.docs.forEach(
        (element) {
          Map<String, dynamic> data = element.data() as Map<String, dynamic>;
          var local = currentUser.uid;
          if (local == data["id"]) {
            userModel = UserModel(
              UserAddress: data["address"],
              UserName: data["username"],
              UserEmail: data["email"],
              UserPhoneNumber: data["phone"],
            );
            newList.add(userModel);
          }
          UserModelList = newList;
        },
      );
    }
  }

  List<UserModel> get getUserModelList {
    return UserModelList;
  }

  void getCartData({
    required String name,
    required String size,
    required String image,
    required int quantity,
    required int price,
  }) {
    cartModel = CartModel(
      name: name,
      size: size,
      image: image,
      quantity: quantity,
      price: price,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCartModelList {
    return List.from(cartModelList);
  }

  int getCartModelListLength() {
    return cartModelList.length;
  }

  void deleteCartProduct(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  //
  List<OrderModel> orderModeList = [];
  late OrderModel orderModel;

  Future<void> getOrderModelData() async {
    List<OrderModel> newList = [];
    DocumentSnapshot ordersSnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic> orderData =
        ordersSnapshot.data() as Map<String, dynamic>;
    List<dynamic> orderItems = orderData['orderItems'];
    orderItems.forEach(
      (element) {
        orderModel = OrderModel(
          name: element["name"],
          image: element["image"],
          price: element["price"],
          size: element["size"],
          quantity: element["quantity"],
        );
        newList.add(orderModel);
      },
    );
    orderModeList = newList;
    notifyListeners();
  }

  List<OrderModel> get getOrderModelList {
    return List.from(orderModeList);
  }

  Future<void> deleteOrderProduct(int index) async {
    DocumentReference ordersSnapshot = await FirebaseFirestore.instance
        .collection("orders")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ordersSnapshot.get();

    Map<String, dynamic> orderData = snapshot.data() as Map<String, dynamic>;
    List<dynamic> orderItems = orderData['orderItems'];
    orderItems.removeAt(index);
    await ordersSnapshot.update({
      'orderItems': orderItems,
    });
    orderModeList.removeAt(index);
    notifyListeners();
  }

  int gerOrderListLength() {
    return orderModeList.length;
  }

  //

  List<CheckOutModel> checkOutModelList = [];
  late CheckOutModel checkOutModel;

  void getcheckOutModelData({
    required String name,
    required String image,
    required String size,
    required int quantity,
    required int price,
  }) {
    checkOutModel = CheckOutModel(
      name: name,
      image: image,
      size: size,
      quantity: quantity,
      price: price,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CheckOutModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int getCheckOutListLength() {
    return checkOutModelList.length;
  }

  void deleteCheckoutProduct(int index) {
    checkOutModelList.removeAt(index);
    notifyListeners();
  }

  void clearCheckoutProduct() {
    checkOutModelList.clear();
    notifyListeners();
  }

  void clearCartProduct() {
    cartModelList.clear();
    notifyListeners();
  }

  Future<void> getProductData() async {
    List<Product> newList = [];
    QuerySnapshot popularSnapshot =
        await FirebaseFirestore.instance.collection("products").get();

    popularSnapshot.docs.forEach(
      (element) {
        productData = Product(
          image: element.get("image"),
          name: element.get("name"),
          price: element.get("price"),
          description: element.get("description"),
        );
        newList.add(productData);
      },
    );
    products = newList;
    notifyListeners();
  }

  Future<void> addProduct(name, price, description, imageUrl) async {
    await FirebaseFirestore.instance.collection("products").add({
      "image": imageUrl,
      "name": name,
      "price": price,
      "description": description,
    });
    // После успешного добавления продукта, обновите список продуктов
    QuerySnapshot popularSnapshot =
        await FirebaseFirestore.instance.collection("products").get();
    List<Product> newList = [];
    popularSnapshot.docs.forEach((element) {
      Product productData = Product(
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price"),
        description: element.get("description"),
      );
      newList.add(productData);
    });
    products = newList;
    notifyListeners();
  }
Future <void> deleteProduct(name) async{
  CollectionReference productsRef = FirebaseFirestore.instance.collection("products");
  // Получаем документы, где "name" соответствует productName
  QuerySnapshot querySnapshot = await productsRef.where("name", isEqualTo: name).get();

  // Удаляем документы, соответствующие запросу
  for (QueryDocumentSnapshot document in querySnapshot.docs) {
    await document.reference.delete();
  }
  QuerySnapshot popularSnapshot = await productsRef.get();
  List<Product> newList = [];
  popularSnapshot.docs.forEach((element) {
    Product productData = Product(
      image: element.get("image"),
      name: element.get("name"),
      price: element.get("price"),
      description: element.get("description"),
    );
    newList.add(productData);
  });
  products = newList;
  notifyListeners();
}
  List<Product> getProductsList() {
    return products;
  }

  List<Product> homeProducts = [];
  late Product homeProductData;

  Future<void> getHomeProductData() async {
    List<Product> newList = [];
    QuerySnapshot homeproductSnapshot =
        await FirebaseFirestore.instance.collection("homeproducts").get();

    homeproductSnapshot.docs.forEach(
      (element) {
        homeProductData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"),
            description: element.get("description"));
        newList.add(homeProductData);
      },
    );
    homeProducts = newList;
    notifyListeners();
  }

  List<Product> getHomeProductList() {
    return homeProducts;
  }

  List<Product> searchList = [];

  void getSearchList({required List<Product> List}) {
    searchList = List;
  }

  List<Product> searchProductList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query) ||
          element.name.contains(query);
    }).toList();
    return searchShirt;
  }

  List<Product> sortList = [];

  List<Product> sortProductList(List<Product> Llist, String sort) {
    List<Product> sortProductList = Llist;
    if (sort == "asc") {
      sortProductList.sort((a, b) => a.price.compareTo(b.price));
    } else if (sort == "desc") {
      sortProductList.sort((a, b) => b.price.compareTo(a.price));
    }
    return sortProductList;
  }
}
