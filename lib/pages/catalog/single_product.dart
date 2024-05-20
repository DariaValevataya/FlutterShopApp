import 'package:course_work/admin/edit_product_screen.dart';
import 'package:course_work/pages/account/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_screen.dart';

class SingleProduct extends StatelessWidget {
  String image;
  String name;
  int price;
  String description;
  SingleProduct(
      {this.description = "",
        required this.name,
        required this.image,
        required this.price});

  @override
  Widget build(BuildContext context) {
   return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: () {
          if(FirebaseAuth.instance.currentUser?.email=="admin@mail.ru"){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProductScreen(
                  name: name,
                  image: image,
                  price: price,
                  description: description,
                ),
              ),
            );
          }else{
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  name: name,
                  image: image,
                  price: price,
                  description: description,
                ),
              ),
            );
          }

        },
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                  child: Image(
                    image: NetworkImage(
                      "$image",
                    ),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                height: 35,
                width: 95,
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                      )),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "\$ $price",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
