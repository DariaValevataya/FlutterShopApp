import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../provider/category_provider.dart';
import '../../provider/product_provider.dart';
import '../catalog/single_product.dart';

class SearchProduct extends SearchDelegate<void> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of(context);
    List<Product> searchProduct = categoryProvider.searchCategoryList(query);

    return GridView.count(
      childAspectRatio: 0.87,
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map((e) => SingleProduct(
        name: e.name,
        image: e.image,
        price: e.price,
        description: e.description,
      ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    List<Product> searchProduct = productProvider.searchProductList(query);
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final childAspectRatio = isPortrait ? 0.95 : 1.3;
    final crossAxisCount = isPortrait ? 2 : 3;

    return GridView.count(
      crossAxisCount: crossAxisCount,
      childAspectRatio: childAspectRatio,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: searchProduct
          .map((e) => SingleProduct(
        name: e.name,
        image: e.image,
        price: e.price,
        description: e.description,
      ))
          .toList(),
    );
  }
}
