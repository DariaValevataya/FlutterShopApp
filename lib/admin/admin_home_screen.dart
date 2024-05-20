import 'package:course_work/admin/add_product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../pages/authorization/login_screen.dart';
import '../pages/search/search_product.dart';
import '../provider/product_provider.dart';
import 'edit_product_screen.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late ProductProvider adminProductProvider;
  late List<Product> snapshot = adminProductProvider.getProductsList();
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    adminProductProvider =Provider.of<ProductProvider>(context);
    adminProductProvider.getProductData();
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final childAspectRatio = isPortrait ? 0.95 : 1.3;
    final crossAxisCount = isPortrait ? 2 : 3;
    final imageHeight= isPortrait? MediaQuery.of(context).size.height * 0.15
        :MediaQuery.of(context).size.height * 0.35;
    final nameHeight= isPortrait? MediaQuery.of(context).size.height * 0.06
        :MediaQuery.of(context).size.height * 0.13;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              adminProductProvider.getSearchList(List: snapshot);
              showSearch(context: context, delegate: SearchProduct());
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              signOut();
               },
            icon: Icon(Icons.logout_outlined),
          ),

        ],
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Товары',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        IconButton(
                            onPressed: () {
                              adminProductProvider.sortProductList(
                                  snapshot, "asc");
                            },
                            icon: Icon(
                              Icons.arrow_upward_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                        IconButton(
                            onPressed: () {
                              adminProductProvider.sortProductList(
                                  snapshot, "desc");
                            },
                            icon: Icon(
                              Icons.arrow_downward_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                      ])),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  children: snapshot
                      .map(
                        (e) => GestureDetector(
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: imageHeight,
                                  child: Image(
                                    image: NetworkImage(e.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: nameHeight,
                                  color: Colors.white,
                                  width: double.infinity,
                                  child:  Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                           Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "${e.name}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "\$ ${e.price.toString()}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                adminProductProvider.deleteProduct(e.name);
                                              },
                                              icon:
                                              Icon(Icons.delete_outline_outlined, color: Colors.grey.shade600, size: 30,)),
                                      ],
                                    ),

                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => EditProductScreen(name:e.name,price:e.price,image:e.image,description:e.description)),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => AddProductScreen()),
          );
        },
      ),

    );
  }
}
