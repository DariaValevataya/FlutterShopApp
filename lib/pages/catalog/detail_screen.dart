import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work/pages/authorization/login_screen.dart';
import 'package:course_work/pages/authorization/registration_screen.dart';
import 'package:course_work/pages/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';

class DetailScreen extends StatefulWidget {
  late final name;
  late int price;
  late final image;
  late final description;
  late String docId;

  DetailScreen({
    required this.image,
    required this.name,
    required this.price,
    this.docId = "",
    required this.description,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

late ProductProvider productProvider;

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;

  List<bool> sized = [true, false, false, false];

  Widget sizeProduct({String name = ""}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 50,
      width: 40,
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  int sizeIndex = 0;
  String size = "";

  void getsize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "S";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "M";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "L";
      });
    } else if (sizeIndex == 3) {
      setState(() {
        size = "XL";
      });
    }
  }

  User? user;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      bottomSheet:Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: () {
            if (user != null) {
              getsize();
              productProvider.getcheckOutModelData(
                name: widget.name,
                image: widget.image,
                size: size,
                quantity: count,
                price: widget.price,

              );
              productProvider.getCartData(
                name: widget.name,
                image: widget.image,
                size: size,
                quantity: count,
                price: widget.price,
              );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CartScreen(),
                ),
              );
            }
          },
          child: Text(
            "Добавить в корзину",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  width: double.infinity,
                  height: 250,
                  color: Colors.white,
                 child:        FutureBuilder(
                   future: FirebaseStorage.instance.refFromURL(widget.image).getDownloadURL(),
                   builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                     if (snapshot.hasData) {
                       return Image(
                         height: 100,
                         image: NetworkImage(snapshot.data!),
                         fit: BoxFit.contain,
                       );
                     }
                     return Container(); // Default return statement
                   },
                 ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.name}",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                            Text(
                              "Описание",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        widget.description,
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Размер",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 300,
                          //
                          child: ToggleButtons(
                              selectedColor: Colors.white,
                              selectedBorderColor: Colors.blue,
                              fillColor: Colors.blue,
                              children: [
                                sizeProduct(name: "S"),
                                sizeProduct(name: "M"),
                                sizeProduct(name: "L"),
                                sizeProduct(name: "XL"),
                              ],
                              onPressed: (int index) {
                                for (int indexBtn = 0;
                                    indexBtn < sized.length;
                                    indexBtn++) {
                                  if (indexBtn == index) {
                                    sized[indexBtn] = true;
                                  } else {
                                    sized[indexBtn] = false;
                                  }
                                }
                                setState(() {
                                  sizeIndex = index;
                                });
                              },
                              isSelected: sized),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Количество",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.remove, color: Colors.white60),
                              onTap: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                            ),
                            Text(
                              "$count",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            GestureDetector(
                              child: Icon(Icons.add,color: Colors.white60),
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "${widget.price}",
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black),
                        ), Icon(Icons.attach_money, size: 30,)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
