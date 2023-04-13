import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/product.dart';
import 'product_detail_screen.dart';
import '../cart/cart_manager.dart';
import './products_manager.dart';


class ProductListTile extends StatelessWidget {

  const ProductListTile(
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
        child: Card(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Container(
            padding: const EdgeInsets.fromLTRB(10.0 ,0 ,0, 0),
            decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    Expanded(
                      
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          const Padding(padding: EdgeInsets.only(bottom: 5.0)),
                                          Text(
                                            product.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          RatingBar(
                                            initialRating: 3,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 15.0,
                                            ratingWidget: RatingWidget(
                                              full: Icon(Icons.star_purple500_sharp),
                                              half: Icon(Icons.star_half),
                                              empty: Icon(Icons.star_outline),
                                            ),
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                        ]
                                      ),
                                      SizedBox(width:70),
                                      Container(
                                          width: 40.0,
                                          height: 40.0,
                                          padding: const EdgeInsets.all(.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 2, color: Colors.green),
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                          ),
                                          child:  ValueListenableBuilder<bool>(
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
                                      ),
                                    ]),
                                ],
                              ),
                            ),
                            
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Price: \$${product.price.toStringAsFixed(0)}',
                                    // product.price.toString(),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    DateTime.now().toString(),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
      
            ),
          ],
        ),
      ),
    );
      
  }



}