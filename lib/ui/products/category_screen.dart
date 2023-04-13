import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';
import 'product_gird_tile.dart';
import 'product_list_tile.dart';
import 'products_manager.dart';
import '../screens.dart';


class categoryDetail extends StatefulWidget {
  // static const routeName = '/search';
  const categoryDetail({required this.brand, Key? key}) : super(key: key);
  final String brand;

  @override
  State<categoryDetail> createState() => _categoryDetailState();
}

class _categoryDetailState extends State<categoryDetail> {
  late String searchString;
  @override
  void initState() {
    searchString = '';
    super.initState();
  }

  void setSearchString(String value) => setState(() {
    searchString = value;
  });

  @override
  Widget build(BuildContext context) {
    var listViewPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 24);
    List<Product> products ;
    if (widget.brand == "All") {
      products = context.select<ProductsManager, List<Product>>((productsManager) => productsManager.items);
    }else {
      products = context.select<ProductsManager, List<Product>>(
          ( productsManager) => productsManager.items).where( (p) => p.brand.toLowerCase().contains(widget.brand.toLowerCase())).toList();
    }
    
    List<Product> searchResultTiles = [];
    if (searchString.isNotEmpty) {
      searchResultTiles = products.where( (p) => p.title.toLowerCase().contains(searchString.toLowerCase())).toList();
    }
    return Scaffold(
      appBar: EasySearchBar(
          title: const Text('Search'),
          onSearch: setSearchString,
          // suggestions: _suggestions
        ),

      body: searchString.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              itemCount: searchResultTiles.length,
              itemBuilder: (ctx, i) => ProductListTile(searchResultTiles[i]),
          )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: products.length,
              itemBuilder: (ctx, i) => ProductGridTile(products[i]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          )
    );
  }
 
}
