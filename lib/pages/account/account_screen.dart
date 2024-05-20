import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work/pages/account/edit_profile.dart';
import 'package:course_work/pages/authorization/login_screen.dart';
import 'package:course_work/pages/order/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../common_widget/account_row.dart';
import '../../common_widget/bottom_navigation_bar.dart';
import '../../models/usermodel.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late final user = FirebaseAuth.instance.currentUser;
  late UserModel userModel;
  String userUid = "";

  void getUserUid() {
    User? myUser = FirebaseAuth.instance.currentUser;
    if (myUser != null) {
      userUid = myUser.uid;
    } else {
      userUid = "";
    }
  }

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
    getUserUid();
    return Scaffold(
      appBar: AppBar(
        title: Text("Аккаунт"),
        centerTitle: true,
      ),
        bottomNavigationBar: BottomBar(currentIndex: 3),
        backgroundColor: Colors.white,
        body: (FirebaseAuth.instance.currentUser != null)
            ? StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      if (data["id"] == userUid) {
                        userModel = UserModel(
                          UserName: data["username"],
                          UserAddress: data["address"],
                          UserEmail: data["email"],
                          UserPhoneNumber: data["phone"],
                        );
                        return Container(
                          width: double.infinity,
                          // color: Colors.blue,
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        width: double.infinity,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Имя: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    userModel.UserName,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Email: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    userModel.UserEmail,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Адрес: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    userModel.UserAddress,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Телефон: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  ),
                                                  Text(
                                                    userModel.UserPhoneNumber,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                      ),
                                      Divider(
                                        color: Colors.black26,
                                        height: 1,
                                      ),
                                      AccountRow(
                                        title: 'Редактировать',
                                        icon: Icon(Icons.create),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return
                                                  EditProfilePage(
                                                    username:userModel.UserName,
                                                    phone: userModel .UserPhoneNumber,
                                                    address:userModel.UserAddress);
                                               });

                                        },
                                      ),
                                      AccountRow(
                                        title: "Мои заказы",
                                        icon:
                                            Icon(Icons.shopping_cart_outlined),
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => OrderScreen())
                                          );
                                        },
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              MaterialButton(
                                                onPressed: signOut,
                                                height: 60,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                minWidth: double.maxFinite,
                                                elevation: 0.1,
                                                color: Colors.blue,
                                                child: Stack(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Выйти",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20),
                                                        child: Icon(
                                                            Icons
                                                                .logout_outlined,
                                                            color:
                                                                Colors.white))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ))
                                    ],
                                  ))
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  );
                },
              )
            : Container());
  }
}
