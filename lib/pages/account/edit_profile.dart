import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String phone;
  final String address;

  const EditProfilePage({
    super.key,
    required this.username,
    required this.phone,
    required this.address,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _usernameContoller = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  void vaildation() async {
    if (_usernameContoller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username is empty "),
        ),
      );
    }
    else if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Phone is empty "),
        ),
      );
    }
    else if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Address is empty "),
        ),
      );
    }else if (_usernameContoller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Username must be > 6 "),
        ),
      );
    } else{
      userDetailUpdate();
      setState(() {});
      Navigator.of(context).pop();
    }
  }

  Future<void> userDetailUpdate() async {
    User? myUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: myUser!.uid)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        DocumentReference userRef = snapshot.docs[0].reference;
        userRef.update({
          "username": _usernameContoller.text,
          "phone": _phoneController.text,
          "address": _addressController.text,
        });
      }
    });
  }

  void initState() {
    super.initState();
    _usernameContoller.text = widget.username;
    _phoneController.text = widget.phone;
    _addressController.text = widget.address;
  }

  @override
  void dispose() {
    _usernameContoller.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Container(
        width: 300,
        height: 250,
        child: Column(
          children: [
            TextField(
              controller: _usernameContoller,
              decoration: InputDecoration(
                labelText: 'Имя',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                  labelText: 'Телефон',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                  labelText: 'Адрес',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ],
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: () async {
            vaildation();
          },
          height: 40,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          minWidth: 100,
          elevation: 0.1,
          color: Colors.blue,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Сохранить",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
