import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'product_gird_tile.dart';
import 'product_list_tile.dart';
import 'products_manager.dart';
import 'search_product.dart';
import './product_category.dart';
import '../../models/brand.dart';

class ProductsList extends StatelessWidget {
  final bool showFavorites;

  const ProductsList(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final products = context.select<ProductsManager, List<Product>>(
      (productsManager) => showFavorites
        ? productsManager.favoriteItems
        : productsManager.items);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => searchField(),
                          ),
                        );
                    },
                  child: new Container(
                    height: 45.0,
                    width: 300.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(color:  Color(0xFF2FA849)),
                      boxShadow: [
                        BoxShadow(
                          color:  Color(0xFF2FA849).withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 45,
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Search",
                              hintText: "Search",
                            ),
                          ),
                        ),
                        Icon(Icons.search,
                              color: Colors.green,
                            ),
                      ],
                    ),
                    ),
                  ),
                  
                  const SizedBox(width: 10),
                  Container(
                    height: 45.0,
                    width: 45.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color:  Color(0xFF2FA849),
                      boxShadow: [
                        BoxShadow(
                          color:  Color(0xFF2FA849).withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(Icons.widgets,
                          color: Colors.green),
                  ),
                ],
              ),
            ),

          Column(
            children: <Widget>[
                GridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                   primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                  children: [
                    // Text(
                    //   'Shop by Category',
                    //   style: Theme.of(context).textTheme.headlineSmall,
                    // ),
                    // const SizedBox(height: 16),
                    CategoryTile(
                      title: categories[0].name,
                      imageUrl: categories[0].imagePath,
                      imageAlignment: Alignment.topCenter,
                    ),

                    // const SizedBox(height: 16),
                    CategoryTile(
                      title: categories[1].name,
                      imageUrl: categories[1].imagePath,
                      imageAlignment: Alignment.topCenter,
                    ),

                    // const SizedBox(height: 16),
                    CategoryTile(
                      title: categories[2].name,
                      imageUrl: categories[2].imagePath,
                    ),
                    // const SizedBox(height: 16),
                    CategoryTile(
                      title: categories[3].name,
                      imageUrl: categories[3].imagePath,
                    ),

                  ],
                ),

                SizedBox(height:5),
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: products.length,
                  itemBuilder: (ctx, i) => ProductListTile(products[i]),

              ),
            ],
          ),
          
        ],
      ),
    );



  }
}

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid(this.showFavorites, {super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    final products = context.select<ProductsManager, List<Product>>(
      (productsManager) => showFavorites
        ? productsManager.favoriteItems
        : productsManager.items);
    return Container(
            // padding: const EdgeInsets.all(10),
            // color: Colors.grey.shade300,
            child: GridView.builder(
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