import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import '../../models/product.dart';
import '../../services/products_service.dart';
import 'product_gird_tile.dart';
import 'product_list_tile.dart';
import 'products_manager.dart';
import '../screens.dart';


class searchField extends StatefulWidget {
  static const routeName = '/search';
  const searchField({Key? key}) : super(key: key);
  
  @override
  State<searchField> createState() => _searchFieldState();
}

class _searchFieldState extends State<searchField> {
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
    List<Product> products = context.select<ProductsManager, List<Product>>(
      (productsManager) => productsManager.items);
    List<Product> searchResultTiles = [];
    if (searchString.isNotEmpty) {
      searchResultTiles = products
          .where(
              (p) => p.title.toLowerCase().contains(searchString.toLowerCase()))
          // .map(
          //   (p) => ProductTile(product: p),
          // )
          .toList();
    }
    return Scaffold(
      appBar: EasySearchBar(
          title: const Text('Search'),
          onSearch: setSearchString,
          // suggestions: _suggestions
        ),
      // appBar: AppBar(
      //    title: SearchBar(
      //     onChanged: setSearchString,
      //   ),
      // ),
      body: searchString.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10.0),
              itemCount: searchResultTiles.length,
              itemBuilder: (ctx, i) => ProductListTile(searchResultTiles[i]),
          )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 230, // here set custom Height You Want
                    ),
              itemCount: products.length,
              itemBuilder: (ctx, i) => ProductGridTile(products[i]),
              
            ),
    );
  }
 
}
