import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work/pages/authorization/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common_widget/line_textfield.dart';

class RegistrationScreen extends StatefulWidget {

  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp regExpNumber = new RegExp(r'^(\+375 (25|29|33|44) ([0-9]{3}([0-9]{2}){2}))$');

  final _usernameContoller = TextEditingController();
  final _emailContoller = TextEditingController();
  final _passwordContoller = TextEditingController();
  final _confirmPasswordContoller = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool isShowPassword = true;

  bool passwordConfirmed() {
    if (_passwordContoller.text.trim() ==
        _confirmPasswordContoller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
  void validation() async {
   if (_usernameContoller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name must be > 6"),
        ),
      );
    } else if (_emailContoller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is empty"),
        ),
      );
    }
   else if (_passwordContoller.text.trim() !=
       _confirmPasswordContoller.text.trim()) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text("Passwords don't matched"),
       ),
     );
   }
   else if (_addressController.text.isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text("Address is empty"),
       ),
     );
   }else if (!regExp.hasMatch(_emailContoller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email isn't valid"),
        ),
      );
    } else if (_passwordContoller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password is empty"),
        ),
      );
    } else if (_passwordContoller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password must be > 6"),
        ),
      );
    }
   // else if (!regExpNumber.hasMatch(_passwordContoller.text)) {
   //   ScaffoldMessenger.of(context).showSnackBar(
   //     SnackBar(
   //       content: Text("Phone isn't valid"),
   //     ),
   //   );
   //  }
   else if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Address is empty"),
        ),
      );
    } else {
      try {
        UserCredential User = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailContoller.text, password: _passwordContoller.text);
        FirebaseFirestore.instance.collection("users").doc(User.user!.uid).set({
          "username": _usernameContoller.text,
          "id": User.user!.uid,
          "email": _emailContoller.text,
          "phone": _phoneController.text,
          "address": _addressController.text,
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } on PlatformException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }
  @override
  void dispose() {
    _usernameContoller.dispose();
    _emailContoller.dispose();
    _passwordContoller.dispose();
    _confirmPasswordContoller.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Stack(children: [
      Scaffold(
        //resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.jpg",
                        width: 200,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Регистрация",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Введите Ваши данные",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height:20,
                  ),
                  LineTextField(
                    title: "Имя",
                    placeholder: "Введите Ваше имя",
                    controller: _usernameContoller,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LineTextField(
                    title: "Email",
                    placeholder: "Введите Ваш email",
                    controller: _emailContoller,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LineTextField(
                    title: "Телефон",
                    placeholder: "Введите Ваш телефон",
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LineTextField(
                    title: "Адрес",
                    placeholder: "Введите Ваш адрес",
                    controller: _addressController,
                  ),
                  SizedBox(
                    height:20,
                  ),
                  LineTextField(
                    title: "Пароль",
                    placeholder: "Введите Ваш пароль",
                    controller: _passwordContoller,
                    obscureText: isShowPassword,
                    right: IconButton(
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        icon: Icon(
                          isShowPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LineTextField(
                    title: "Подтверждение пароля",
                    placeholder: "Повторите Ваш пароль",
                    controller: _confirmPasswordContoller,
                    obscureText: isShowPassword,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  GestureDetector(
                      onTap: validation,
                      child: Container(
                          width: double.maxFinite,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Зарегистрироваться',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ))),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Есть аккаунт?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Войти",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
