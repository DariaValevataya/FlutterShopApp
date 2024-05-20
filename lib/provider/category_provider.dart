import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/categoryicon.dart';
import '../models/product.dart';

class CategoryProvider extends ChangeNotifier {
  List<Product> shirts = [];//майки
  late Product shitrsData;
  List<Product> hoodies = [];//худи
  late Product hoodieData;
  List<Product> sweatshirts = [];//свитшоты
  late Product sweatshirtData;
  List<CategoryIcon> categoryIcon = [];
  late CategoryIcon categoryiconData;

  Future<void> getCategoryIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot categoryicon =
        await FirebaseFirestore.instance.collection("categoryicon").get();

    categoryicon.docs.forEach(
      (element) {
        categoryiconData = CategoryIcon(
          image: element.get("image"),
          name: element.get("name"),
        );
        newList.add(categoryiconData);
      },
    );
    categoryIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> getCategoryIconList() {
    return categoryIcon;
  }

  Future<void> getShirtsData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("7fsF0Jmgg0p4tyJUeMu3")
        .collection("shirts")
        .get();

    shirtSnapshot.docs.forEach(
      (element) {
        shitrsData = Product(
          image: element.get("image"),
          name: element.get("name"),
          price: element.get("price"),
          description: element.get("description"),
        );
        newList.add(shitrsData);
      },
    );
    shirts = newList;
    notifyListeners();
  }

  List<Product> getShirtList() {
    return shirts;
  }
  Future<void> getHoodieData() async {
    List<Product> newList = [];
    QuerySnapshot hoodieSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("7fsF0Jmgg0p4tyJUeMu3")
        .collection("hoodies")
        .get();

    hoodieSnapshot.docs.forEach(
          (element) {
        hoodieData = Product(
          image: element.get("image"),
          name: element.get("name"),
          price: element.get("price"),
          description: element.get("description"),
        );
        newList.add(hoodieData);
      },
    );
    hoodies = newList;
    notifyListeners();
  }

  List<Product> getHoodieList() {
    return hoodies;
  }
  Future<void> getSweatshirtsData() async {
    List<Product> newList = [];
    QuerySnapshot sweatshirtSnapshot = await FirebaseFirestore.instance
        .collection("category")
        .doc("7fsF0Jmgg0p4tyJUeMu3")
        .collection("sweatshirts")
        .get();

    sweatshirtSnapshot.docs.forEach(
          (element) {
        sweatshirtData = Product(
          image: element.get("image"),
          name: element.get("name"),
          price: element.get("price"),
          description: element.get("description"),
        );
        newList.add(sweatshirtData);
      },
    );
    sweatshirts = newList;
    notifyListeners();
  }

  List<Product> getSweatshirtsList() {
    return sweatshirts;
  }


  List<Product> searchList = [];
  void getSearchList({required List<Product> List}) {
    searchList = List;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchShirt = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query) ||
          element.name.contains(query);
    }).toList();
    return searchShirt;
  }
}
