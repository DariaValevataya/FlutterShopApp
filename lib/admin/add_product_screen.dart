import 'dart:io';
import 'dart:ui';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../common_widget/line_textfield.dart';
import '../provider/product_provider.dart';
import 'admin_home_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _nameContoller = TextEditingController();
  final _descrContoller = TextEditingController();
  final _priceContoller = TextEditingController();
  RegExp regExp = new RegExp(r'[0-9]+');
  var _pickedImage;
  var _image;
  String imageUrl = "";

  Future<void> getImage({required ImageSource source}) async {
    _image = (await ImagePicker().pickImage(source: source))!;

    if (_image != null) {
      setState(() {
        _pickedImage = File(_image.path);
      });
    }
  }

  Future<void> _uploadImage({required File image}) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('${DateTime.now()}.jpg');
    await storageReference.putFile(image);
    imageUrl = await storageReference.getDownloadURL();
    print(imageUrl + "----------------------------------------------------------------");
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final buttonWidth = isPortrait ? 200.0 : 400.0;
    final imageWidth = isPortrait ? 100.0 : 150.0;
    ProductProvider adminProductProvider =
        Provider.of<ProductProvider>(context);
    void validation() async {
      if (_nameContoller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Name is empty"),
          ),
        );
      } else if (_descrContoller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Description is empty"),
          ),
        );
      } else if (_priceContoller.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Price is empty"),
          ),
        );
      } else if (!regExp.hasMatch(_priceContoller.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Price isn't valid"),
          ),
        );
      } else {
        await _uploadImage(image: _pickedImage);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AdminHomePage(),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AdminHomePage(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(""),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: imageWidth,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: (_pickedImage == null)
                            ? Container(
                                color: Colors.grey.withOpacity(0.5),
                              )
                            : Image.file(
                                _pickedImage,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          getImage(source: ImageSource.gallery);
                        },
                        icon: Icon(Icons.add_a_photo_outlined,
                            color: Colors.grey))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              LineTextField(
                title: "Название",
                placeholder: "Введите название продукта",
                controller: _nameContoller,
              ),
              SizedBox(
                height: 20,
              ),
              LineTextField(
                title: "Описание",
                placeholder: "Введите описание продукта",
                controller: _descrContoller,
              ),
              SizedBox(
                height: 20,
              ),
              LineTextField(
                title: "Цена",
                placeholder: "Введите цену продукта",
                controller: _priceContoller,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => AdminHomePage()),
                        );
                      },
                      child: Container(
                          width: buttonWidth,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Отмена',
                                style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ))),
                  GestureDetector(
                      onTap: () {
                        validation();
                        adminProductProvider.addProduct(_nameContoller.text,
                            int.parse(_priceContoller.text), _descrContoller.text, imageUrl);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Add successfully"),
                            ),
                        );
                      },
                      child: Container(
                          width: buttonWidth,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('Добавить',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
