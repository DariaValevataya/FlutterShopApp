import 'package:course_work/pages/account/account_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_widget/orderproduct.dart';
import '../../provider/product_provider.dart';
import '../cart/cart_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}
late ProductProvider productprovider;

class _OrderScreenState extends State<OrderScreen> {
  late int index;
  @override
  Widget build(BuildContext context) {
    productprovider = Provider.of<ProductProvider>(context);
    productprovider.getOrderModelData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AccountScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Заказы"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: double.infinity,
                     child:ListView.builder(
                        itemCount: productprovider.gerOrderListLength(),
                        itemBuilder: (context, myindex) {
                          index = myindex;
                          return OrderProduct(
                            isCount: true,
                            index: myindex,
                            image: productprovider
                                .getOrderModelList[myindex].image,
                            name: productprovider
                                .getOrderModelList[myindex].name,
                            price: productprovider
                                .getOrderModelList[myindex].price,
                            quantity: productprovider
                                .getOrderModelList[myindex].quantity,
                            size: productprovider
                                .getOrderModelList[myindex].size,
                            check: false,
                          );
                        }),
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
