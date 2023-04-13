import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/admin/app_drawer.dart';
import 'package:provider/provider.dart';
import 'user_product_list_tile.dart';
import 'products_manager.dart';
import '../shared/app_drawer.dart';
import './edit_product_screen.dart';
import '../screens.dart';


class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  @override
  Widget build(BuildContext context){
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('your Products'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AdminDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: buildUserProductListView(productsManager),
          );
        },
      ),
      // bottomNavigationBar: const BottomNavBar(),

    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: (){
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }

  Widget buildUserProductListView(ProductsManager productsManager){
    return Consumer<ProductsManager>(
      builder:(ctx, productsManager, child){
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

}