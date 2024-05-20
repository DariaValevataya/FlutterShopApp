import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductContainer extends StatelessWidget {
  final String name;
  final int price;
  const ProductContainer({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color:Colors.black,
            ),
          ),
          Text(name,style: TextStyle(
              color:Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18
          )),

          Row(
            children: [
              Icon(Icons.attach_money, size: 16, color: Colors.grey),
              Text(price.toString(),style: TextStyle(
                  color:Colors.grey,
                  fontSize: 16
              )),
            ],
          ),
        ],
      ),
    );
  }
}

