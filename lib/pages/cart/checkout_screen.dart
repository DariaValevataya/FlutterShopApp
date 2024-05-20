import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widget/cartsingleproduct.dart';
import '../../models/checkoutmodel.dart';
import '../../provider/product_provider.dart';
import 'cart_screen.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

late ProductProvider productProvider;
late List<CheckOutModel> myList;

class _CheckOutState extends State<CheckOut> {
  Widget BottomDetail(String startname, String endname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          startname,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        Text(
          endname,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  late int index;
  User? user;
  double total = 0.0;

  showAlertDialog(BuildContext ctx, dynamic e) {
    Widget continueButton = TextButton(
      child: Text("Нет"),
      onPressed: () {
        Navigator.of(ctx).pop();
      },
    );
    Widget signin = TextButton(
      child: Text("Да"),
      onPressed: () async {
        await FirebaseFirestore.instance.collection("orders").doc(user!.uid).set({
          "orderItems": productProvider.checkOutModelList
              .map((c) => {
            "name": c.name,
            "price": c.price,
            "quantity": c.quantity,
            "image": c.image,
            "size": c.size,
          })
              .toList(),
          "date": Timestamp.now(),
          "totalPrice": total.toStringAsFixed(2),
          "username": e.UserName,
          "userEmail": e.UserEmail,
          "userAddress": e.UserAddress,
          "userUid": user!.uid,
          "isCompleted": false,
        });
        productProvider.clearCheckoutProduct();
        productProvider.clearCartProduct();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Вы уверены?"),
      content: Text("Оформить заказ?"),
      actions: [
        continueButton,
        signin,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Column(
            children: productProvider.UserModelList.map((e) {
              return Container(
                  width: double.infinity,
                  height: 50,
                  child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text("Оформить заказ",  style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: () {
                       if (productProvider.getCheckOutModelList.isNotEmpty) {
                        showAlertDialog(context, e);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Нет заказов"),
                          ),
                        );
                      }
                    },
                  )
              );
            }).toList());
  }
  void initState() {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    myList = productProvider.checkOutModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final itemHeight = isPortrait ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.45;

    user = FirebaseAuth.instance.currentUser;
    total = 0.0;

    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getCheckOutModelList.forEach((element) {
      total += element.price * element.quantity;
    });

    if (productProvider.checkOutModelList.isEmpty) {
      total = 0.0;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => CartScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(""),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 50,
        width: 150,
        child: _buildBottom(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height:itemHeight,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: productProvider.getCheckOutListLength(),
                        itemBuilder: (context, myindex) {
                          index = myindex;
                          return CartSingleProduct(
                            isCount: true,
                            index: myindex,
                            image: productProvider
                                .getCheckOutModelList[myindex].image,
                            name: productProvider
                                .getCheckOutModelList[myindex].name,
                            price: productProvider
                                .getCheckOutModelList[myindex].price,
                            quantity: productProvider
                                .getCheckOutModelList[myindex].quantity,
                            size: productProvider
                                .getCheckOutModelList[myindex].size,
                            check: false,
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BottomDetail(
                            "Итого", "\$ ${total.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
