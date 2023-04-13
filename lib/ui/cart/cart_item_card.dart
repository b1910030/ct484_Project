
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';
import './cart_manager.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cardItem;

  const CartItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction){
        return showConfirmDialog(
          context,
          'Do you want to remove the item from the cart?',
        );
      },
      onDismissed:(direction){
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCard(),
    );
  
  }
  Widget buildItemCard(){
    return Container(
      child: Card(
        
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading:  ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),//add border radius here
              child: Image.network(cardItem.imageUrl , width: 50, height: 50),//add image location here
            ),
            title: Text(cardItem.title),
            subtitle: Text('Price: \$${(cardItem.price)} x ${cardItem.quantity} '),
            trailing: Text('${cardItem.quantity * (cardItem.price)}'),
          ),
        ),
      ),
    );
    
    
  }
}