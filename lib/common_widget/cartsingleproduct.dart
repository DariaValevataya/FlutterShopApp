import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class CartSingleProduct extends StatefulWidget {
  final String name;
  final String image;
  final String size;
  bool isCount;
  late int quantity;
  final int price;
  int index;
  bool check;
  CartSingleProduct({
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
  _CartSingleProductState createState() => _CartSingleProductState();
}

late int myIndex = 0;

class _CartSingleProductState extends State<CartSingleProduct> {
  late ProductProvider productProvider;

  _updateData(
      {required int index,
      required int quantity,
      required String name,
      required String image,
      required String size,
      required int price}) {
    productProvider.getCheckOutModelList;

    productProvider.checkOutModelList[index].name = name;
    productProvider.checkOutModelList[index].image = image;
    productProvider.checkOutModelList[index].size = size;
    productProvider.checkOutModelList[index].quantity = quantity;
    productProvider.getCartModelList[index].quantity = quantity;

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
                height: 120,
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
                          IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                // widget.isCount == false
                                // ?
                                productProvider.deleteCartProduct(widget.index);
                                // :
                                productProvider
                                    .deleteCheckoutProduct(widget.index);
                              })
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
                          width: widget.isCount == false ? 110 : 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: widget.isCount == false
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        child: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          if (widget.quantity > 1) {
                                            widget.quantity--;
                                            setState(() {
                                              myIndex = widget.index;
                                              _updateData(
                                                index: widget.index,
                                                quantity: widget.quantity,
                                                name: widget.name,
                                                image: widget.image,
                                                size: widget.size,
                                                price: widget.price,
                                              );
                                            });
                                          }
                                        },
                                      ),
                                      Container(
                                        child: Text(
                                          widget.quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onTap: () {
                                          widget.quantity++;
                                          setState(() {
                                            _updateData(
                                              index: widget.index,
                                              quantity: widget.quantity,
                                              name: widget.name,
                                              image: widget.image,
                                              size: widget.size,
                                              price: widget.price,
                                            );
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Container(

                                  child: Row(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.quantity.toString(),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ),
                                      Text(
                                        " шт.",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
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
