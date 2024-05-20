import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../common_widget/bottom_navigation_bar.dart';
import '../common_widget/slider.dart';
import '../models/categoryicon.dart';
import '../models/product.dart';
import '../provider/category_provider.dart';
import '../provider/product_provider.dart';
import 'catalog/catalog_screen.dart';
import 'catalog/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

late CategoryProvider categoryprovider;
late ProductProvider productprovider;

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  User? user;
  Widget buildCategory() {
    List<Product> hoodies = categoryprovider.getHoodieList();
    List<Product> shirts = categoryprovider.getShirtList();
    List<Product> sweatshirts = categoryprovider.getSweatshirtsList();
    List<CategoryIcon> categoryIcon = categoryprovider.getCategoryIconList();
    List category = [sweatshirts, hoodies, shirts];
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Категории",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            scrollDirection: Axis.horizontal,
            children: List.generate(categoryIcon.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => CatalogScreen(
                        isCategory: true,
                        name: "${categoryIcon[index].name}",
                        snapshot: category[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                child: Image(
                                  image: NetworkImage(
                                      "${categoryIcon[index].image}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              "${categoryIcon[index].name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget buildHomeProducts() {
    List<Product> products = productprovider.getProductsList();
    List<Product> homeproducts = productprovider.getHomeProductList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Новая коллекция",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CatalogScreen(
                        isCategory: false,
                        name: 'Все товары',
                        snapshot: products,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Каталог",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Container(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: homeproducts.length,
                itemBuilder: (context, int index) => Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 140,
                          height: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    image: homeproducts[index].image,
                                    name: homeproducts[index].name,
                                    price: homeproducts[index].price,
                                    description:
                                        homeproducts[index].description,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 95,
                                  child: Image(
                                    image: NetworkImage(
                                        "${homeproducts[index].image}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${homeproducts[index].name}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\$ ${homeproducts[index].price}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))),
          ),
        )
      ],
    );
  }
  Widget buildPopularProducts() {
    List<Product> products = productprovider.getProductsList();
    List<Product> homeproducts = productprovider.getHomeProductList();

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 7),
          height: 40,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Популярное",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CatalogScreen(
                        isCategory: false,
                        name: 'Все товары',
                        snapshot: products,
                      ),
                    ),
                  );
                },
                child: Text(
                  "Каталог",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          child: Container(
            child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                scrollDirection: Axis.horizontal,
                itemCount: homeproducts.length,
                itemBuilder: (context, int index) => Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 15),
                          width: 140,
                          height: 155,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => DetailScreen(
                                    image: homeproducts[index].image,
                                    name: homeproducts[index].name,
                                    price: homeproducts[index].price,
                                    description:
                                    homeproducts[index].description,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                  ),
                                  width: double.infinity,
                                  height: 95,
                                  child: Image(
                                    image: NetworkImage(
                                        "${homeproducts[index].image}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${homeproducts[index].name}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\$ ${homeproducts[index].price}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ))),
          ),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    categoryprovider = Provider.of<CategoryProvider>(context);
    categoryprovider.getHoodieData();
    categoryprovider.getShirtsData();
    categoryprovider.getSweatshirtsData();
    categoryprovider.getCategoryIconData();
    productprovider = Provider.of<ProductProvider>(context);
    productprovider.getHomeProductData();
    productprovider.getProductData();
    try {
      user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        productprovider.getUserData();
      }
    } catch (e) {
      print("No User Logged In");
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Главная"),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //     SearchBAr(),
                SizedBox(
                  height: 10,
                ),
                ProductSlider(),
                SizedBox(
                  height: 15,
                ),
                buildCategory(),
                buildHomeProducts(),
                buildPopularProducts()

              ],
            ),
          ),
        ),
      ),
    );
  }
}
