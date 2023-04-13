import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'product_detail_screen.dart';
import '../cart/cart_manager.dart';
import './products_manager.dart';


class ProductGridTile extends StatelessWidget {
  const ProductGridTile(
    this.product,{
      super.key,
    }
  );
  final Product product;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(product),
              ),
            );
          }, 
        child: Container(
            decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8.0),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5),
                      //     spreadRadius: 5,
                      //     blurRadius: 7,
                      //     offset: Offset(0, 3), // changes position of shadow
                      //   ),
                      // ],
                  ),
            
            child: Column(
              children: <Widget>[
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        product.imageUrl,
                        color: Colors.grey[200],
                        colorBlendMode: BlendMode.darken,
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 33,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      buildLikeButton(context),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    product.title,
                    style:  TextStyle(fontWeight: FontWeight.bold
                                    , fontSize: 18),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'price: \$${product.price.toString()}',
                    style:  TextStyle(fontWeight: FontWeight.bold
                                    , fontSize: 13,
                                      color: Colors.blue,),
                  ),
                ),
              ],
              
            ),
            
          ),
    );
  }
  
  Widget buildLikeButton(BuildContext context){
    return GridTileBar(
      // backgroundColor: Colors.black87,
      leading: ValueListenableBuilder<bool>(
        valueListenable: product.isFavoriteListenable,
        builder: (ctx, isFavorite,child){
          return  Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 33,
              // color: Colors.black.withOpacity(0.5),

              child: Center(
                child: Ink(
                  height: 30,
                  width: 145,
                  decoration: const ShapeDecoration(
                    color: Colors.black,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_rounded),
                    color: product.isFavorite ? Colors.pink : Colors.white,
                    onPressed: () {ctx.read<ProductsManager>().toggleFavoriteStatus(product);},
                  ),
                ),
              ),
            )
            );
        },
      ),
      
    );
  }
}