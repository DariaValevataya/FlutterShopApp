import 'package:course_work/admin/admin_home_screen.dart';
import 'package:course_work/pages/authorization/registration_screen.dart';
import 'package:course_work/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common_widget/line_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailContoller = TextEditingController();
  final _passwordContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  bool isShowPassword = true;
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  void validation() async {
 if (_emailContoller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email is empty"),
        ),
      );
    } else if (!regExp.hasMatch(_emailContoller.text)) {
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
          content: Text("Password must be > 8"),
        ),
      );
    } else {
      final FormState? _form = _formKey.currentState;
      if (_form!.validate()) {
        try {
            String _email = _emailContoller.text.trim();
            String emailtolower = _email.toLowerCase();
            UserCredential User = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                email: emailtolower, password: _passwordContoller.text);
            if(_email=='admin@mail.ru'){
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => AdminHomePage(),
                ),
              );
            }
            else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User not found'
              ),
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailContoller.dispose();
    _passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
       resizeToAvoidBottomInset: false,
        key: _scaffoldkey,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    "Авторизация",
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
                    height: 20,
                  ),
                  LineTextField(
                      title: "Email",
                      placeholder: "Введите Ваш email ",
                      controller: _emailContoller //loginVM.txtEmail.value,
                      ),
                  SizedBox(
                    height: 20,
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
                  GestureDetector(
                    onTap: validation,
                    child: Container(
                        width: double.maxFinite,
                        height: 60,
                      decoration: BoxDecoration(
                        color:Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:Center(
                        child: Text('Войти', style:TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600
                        )),
                      )
                    )
                  ),
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
                            "Нет аккаунта?",
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
                                  builder: (context) => RegistrationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Зарегистрироваться",
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
