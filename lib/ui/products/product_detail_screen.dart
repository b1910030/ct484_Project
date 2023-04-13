import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../cart/cart_screen.dart';
import '../cart/cart_manager.dart';
import './products_manager.dart';
import '../../models/cart_item.dart';


class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(
    this.product, {
      super.key,
  });

  final Product product;

                        
  CartItem productToCartItem(Product product){
    return CartItem(
    id: product.id!,
    title: product.title!,
    imageUrl: product.imageUrl!,
    price: product.price!,
    quantity: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height / 2,
                  decoration: BoxDecoration(
                    color: Color(0xFFECF4F3),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF2FA849).withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: product.title,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                TextSpan(
                                  text: '|| brand: ${product.brand}',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 30.0,
                            width: 30.0,
                            padding: const EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF2FA849).withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ValueListenableBuilder<bool>(
                              valueListenable: product.isFavoriteListenable,
                              builder: (ctx, isFavorite,child){
                                return IconButton(
                                  icon: Icon(
                                    product.isFavorite  ?  Icons.favorite : Icons.favorite_border,
                                    color: Colors.green
                                  ),
                                  color: Theme.of(context).colorScheme.secondary,
                                  onPressed: (){
                                    ctx.read<ProductsManager>().toggleFavoriteStatus(product);
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      RichText(
                        text: TextSpan(
                          text: product.description,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 15.0,
                            height: 1.4,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Price \$${product.price}',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 18.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      Text(
                        'Treatment',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontSize: 18.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.widgets,
                            color: Colors.black),
                          Icon(Icons.widgets,
                            color: Colors.black),
                          Icon(Icons.widgets,
                            color: Colors.black),
                          Icon(Icons.widgets,
                            color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed('/cart');
                  },
                  icon: const Icon(Icons.shopping_cart, color: Colors.black,),
                ),
                // Image.asset('assets/icons/cart.png',
                //     color: Colors.black, height: 40.0),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2FA849),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF2FA849).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, -5),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: TextButton(
                    onPressed: (){
                      final cart = context.read<CartManager>();
                      final cartItem = productToCartItem(product);
                      cart.addCart(cartItem);
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                          content: const Text(
                            'Item added to cart',
                          ),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id!);
                            },
                          ),
                          ),
                      );
                    },
                    child: Text(
                        // product.price.toStringAsFixed(0),
                      'Add To Card With \$${product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF).withOpacity(0.9),
                        fontSize: 18.0,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}