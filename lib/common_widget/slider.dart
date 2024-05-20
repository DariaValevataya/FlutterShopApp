import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class ProductSlider extends StatefulWidget {
  @override
  State<ProductSlider> createState() => _ProductSliderState();
}

class _ProductSliderState extends State<ProductSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: [
          Container(
            width: 600,
            decoration: BoxDecoration(
                color: Colors.black,

                image: DecorationImage(
                    image: AssetImage("assets/images/slider4.jpg"), fit: BoxFit.cover)),
          ),
          Container(
            width: 600,
            decoration: BoxDecoration(
                color: Colors.black,

                image: DecorationImage(
                    image: AssetImage("assets/images/slider3.jpg"), fit: BoxFit.cover)),
          ),
          Container(
            width: 600,
            decoration: BoxDecoration(
                color: Colors.black,

                image: DecorationImage(
                    image: AssetImage("assets/images/slider2.jpg"), fit: BoxFit.cover)),
          ),
          Container(
            width: 600,
            decoration: BoxDecoration(
              color: Colors.black,
                image: DecorationImage(
                    image: AssetImage("assets/images/slider1.jpg"), fit: BoxFit.cover)),
          )
        ],
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
