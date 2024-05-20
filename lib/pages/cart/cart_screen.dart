import 'package:course_work/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_widget/bottom_navigation_bar.dart';
import '../../common_widget/cartsingleproduct.dart';
import '../../provider/product_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

late ProductProvider productProvider;
late int myIndex = 0;

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final itemHeight = isPortrait ? MediaQuery.of(context).size.height * 0.72 : MediaQuery.of(context).size.height * 0.45;
    final buttonWidth = isPortrait ? double.infinity: MediaQuery.of(context).size.width * 0.5;

    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text("Корзина"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomBar(currentIndex: 2),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height:itemHeight,
              width: double.infinity,
              child: ListView.builder(
                itemCount: productProvider.getCartModelListLength(),
                itemBuilder: (context, index) => CartSingleProduct(
                  isCount: false,
                  index: index,
                  image: productProvider.getCartModelList[index].image,
                  name: productProvider.getCartModelList[index].name,
                  price: productProvider.getCartModelList[index].price,
                  quantity: productProvider.getCartModelList[index].quantity,
                  size: productProvider.getCartModelList[index].size,
                  check: true,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              height: 50,
              color: Colors.white,
              width: buttonWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CheckOut(),
                    ),
                  );
                },
                child: Text(
                  "Далее",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}
