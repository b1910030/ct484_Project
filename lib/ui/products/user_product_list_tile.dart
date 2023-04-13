import 'package:flutter/material.dart';
import '../../ui/products/products_manager.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import './edit_product_screen.dart';
import '../shared/dialog_utils.dart';

class UserProductListTile extends StatelessWidget {
  final Product product;

  const UserProductListTile(
    this.product, {
      super.key,
  });

  @override 
  Widget build(BuildContext context){
    return Dismissible(
      key: ValueKey(product.id),
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
          'Do you want to remove the Product?',
        );
      },
      onDismissed:(direction){
        context.read<ProductsManager>().deleteProduct(product.id!);
      },
      child: buildItem(context),
    );
  }

  Widget buildItem(BuildContext context){
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
              child: Image.network(product.imageUrl , width: 50, height: 50),//add image location here
            ),
            title: Text(product.title),
            trailing: SizedBox(
              // width: 100,
              child: buildEditButton(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit,
            color: Colors.green),
      onPressed: (){
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
          arguments: product.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}