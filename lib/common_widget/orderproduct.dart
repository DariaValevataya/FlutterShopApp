import 'package:course_work/pages/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';
class OrderProduct extends StatefulWidget {
  final String name;
  final String image;
  final String size;
  bool isCount;
  late int quantity;
  final int price;
  int index;
  bool check;
  OrderProduct({
    required this.index,
    required this.image,
    required this.size,
    required this.name,
    required this.quantity,
    required this.price,
    required this.isCount,
    required this.check,
  });

  @override
  _OrderProductState createState() => _OrderProductState();
}

late int myIndex = 0;

class _OrderProductState extends State<OrderProduct> {
  late ProductProvider productProvider;
  showAlertDialog(BuildContext ctx) {
    Widget continueButton = TextButton(
      child: Text("Нет"),
      onPressed: () {
        Navigator.of(ctx).pop();
      },
    );
    Widget signin = TextButton(
      child: Text("Да"),
      onPressed: ()  {
        productProvider.deleteOrderProduct(widget.index);

        Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => OrderScreen()));
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Вы уверены?"),
      content: Text("Отменить заказ?"),
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

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 130,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("${widget.image}"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 220,
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.name}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.size,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Text("\$ ${widget.price}", style: TextStyle(fontSize: 14)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width:170,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.quantity.toString(),
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                    Text(
                                      " шт.",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: Text(
                                    "Отменить",
                                    style: TextStyle(fontSize: 15, color: Colors.white),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
