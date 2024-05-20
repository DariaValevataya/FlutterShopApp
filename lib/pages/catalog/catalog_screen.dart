import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widget/bottom_navigation_bar.dart';
import '../../models/categoryicon.dart';
import '../../models/product.dart';
import '../../provider/category_provider.dart';
import '../../provider/product_provider.dart';
import '../search/search_category.dart';
import '../search/search_product.dart';
import 'detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  String name;
  bool isCategory = true;
  final List<Product> snapshot;

  CatalogScreen(
      {required this.name, required this.isCategory, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryprovider = Provider.of<CategoryProvider>(context);
    categoryprovider = Provider.of<CategoryProvider>(context);
    categoryprovider.getHoodieData();
    categoryprovider.getShirtsData();
    categoryprovider.getSweatshirtsData();
    categoryprovider.getCategoryIconData();
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final childAspectRatio = isPortrait ? 0.95 : 1.3;
    final crossAxisCount = isPortrait ? 2 : 3;
    final imageHeight= isPortrait? MediaQuery.of(context).size.height * 0.15
        :MediaQuery.of(context).size.height * 0.35;
    final nameHeight= isPortrait? MediaQuery.of(context).size.height * 0.06
        :MediaQuery.of(context).size.height * 0.13;
    Widget buildCategory() {
      List<Product> hoodies = categoryprovider.getHoodieList();
      List<Product> shirts = categoryprovider.getShirtList();
      List<Product> sweatshirts = categoryprovider.getSweatshirtsList();
      List<CategoryIcon> categoryIcon = categoryprovider.getCategoryIconList();
      List category = [sweatshirts, hoodies, shirts];
      return Column(
        children: [
          Container(
            width: 240,
            height: 50,
            child: ListView(
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
                          padding: EdgeInsets.only(right: 15, top: 15),
                          child: Column(
                            children: [
                              Text(
                                "${categoryIcon[index].name}",
                                style: TextStyle(
                                     fontSize: 16),
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

    return Scaffold(
        appBar: AppBar(
          actions: [
            isCategory == true
                ? IconButton(
                    onPressed: () {
                      categoryprovider.getSearchList(List: snapshot);
                      showSearch(context: context, delegate: SearchCategory());
                    },
                    icon: Icon(Icons.search),
                  )
                : IconButton(
                    onPressed: () {
                      productProvider.getSearchList(List: snapshot);
                      showSearch(context: context, delegate: SearchProduct());
                    },
                    icon: Icon(Icons.search),
                  ),
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomBar(currentIndex: 1),
        body: SafeArea(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
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
                          name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        IconButton(
                            onPressed: () {
                              productProvider.sortProductList(snapshot, "asc");
                            },
                            icon: Icon(
                              Icons.arrow_upward_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                        IconButton(
                            onPressed: () {
                              productProvider.sortProductList(snapshot, "desc");
                            },
                            icon: Icon(
                              Icons.arrow_downward_outlined,
                              color: Colors.black,
                              size: 20,
                            )),
                        buildCategory(),
                        ])),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: childAspectRatio,                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            shrinkWrap: true,
                            children: snapshot
                                .map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: e.image,
                                              name: e.name,
                                              price: e.price,
                                              description: e.description),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                              // color: Colors.black,
                                              width: double.infinity,
                                              height: imageHeight,
                                              child: Image(
                                                image: NetworkImage(e.image),
                                                fit: BoxFit.cover,
                                              )),
                                          Container(
                                            height: nameHeight,
                                            color: Colors.white,
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "${e.name}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$ ${e.price.toString()}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
              ],
            ),
          ]),
        )));
  }
}
