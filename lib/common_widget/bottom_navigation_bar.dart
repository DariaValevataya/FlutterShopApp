import 'package:course_work/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../models/product.dart';
import '../pages/account/account_screen.dart';
import '../pages/cart/cart_screen.dart';
import '../pages/catalog/catalog_screen.dart';

class BottomBar extends StatefulWidget {
  final currentIndex;
  const BottomBar({super.key, this.currentIndex});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  Widget build(BuildContext context) {
    List<Product> products = productprovider.getProductsList();
    return  Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 5, spreadRadius: 1, color: Colors.grey)],
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            child: GNav(
              selectedIndex: widget.currentIndex,
              backgroundColor: Colors.white,
              color: Colors.black,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.blue,
              padding: EdgeInsets.all(16),
              gap: 8,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Главная',
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                GButton(
                  icon: Icons.storefront_outlined,
                  text: 'Каталог',
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CatalogScreen(
                          isCategory: false,
                          name: 'Все товары',
                          snapshot: products,
                        ),
                      ),
                    );
                  },
                ),
                GButton(
                  icon: Icons.shopping_cart_outlined,
                  text: 'Корзина',
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
                GButton(icon: Icons.person, text: 'Аккаунт',
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccountScreen()),
                    );
                  },),
              ],
            ),
          ),
        );
  }
}
