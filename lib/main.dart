import 'package:flutter_application_1/ui/admin/admin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import './ui/products/products_manager.dart';
// import 'package:myshop/ui/products/products_manager.dart';
// import './ui/products/product_detail_screen.dart';
// import './ui/products/products_overview_screen.dart';
// import 'ui/products/user_products_screen.dart';
// import 'ui/cart/cart_screen.dart';
// import 'ui/cart/cart_manager.dart';
// import 'ui/orders/orders_screen.dart';
// import 'ui/orders/orders_manager.dart';
// import './ui/products/edit_product_screen.dart';
import './ui/screens.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

Future<void>main() async{
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),

        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
            // cho productManager
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, CartManager>(
          create: (ctx) => CartManager(),
          update: (ctx, authManager, CartManager) {
            // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
            // cho productManager
            CartManager!.authToken = authManager.authToken;
            return CartManager;
          },
        ),
        ChangeNotifierProxyProvider<AuthManager, OrdersManager>(
          create: (ctx) => OrdersManager(),
          update: (ctx, authManager, OrdersManager) {
            // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
            // cho OrdersManager
            OrdersManager!.authToken = authManager.authToken;
            return OrdersManager;
          },
        ),
        // ChangeNotifierProvider(
        //   create: (ctx) => OrdersManager(),
          
        // ),


      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child){
          return MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: const Color(0xFFFFFFFF),
                iconTheme: IconThemeData(color: Colors.black),
                foregroundColor: Colors.black,
              ),
              primarySwatch: Colors.blue,
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple,
              ).copyWith(
                secondary: Colors.deepOrange,
              ),
            ),
            home: authManager.isAdmin
              ?  AdminScreen()
              :( authManager.isAuth 
                ? const ProductsOverviewScreen()
                :FutureBuilder(
                future: authManager.tryAutoLogin(),
                builder: (ctx, snapshot){
                  return snapshot.connectionState == ConnectionState.waiting
                    ? const SplashScreen()
                    : const AuthScreen();
                },
              )),
            routes: {
              AdminScreen.routeName:
                (ctx) => AdminScreen(),
              CartScreen.routeName:
                (ctx) => const CartScreen(),
              OrdersScreen.routeName:
                (ctx) => const OrdersScreen(),
              UserProductsScreen.routeName:
                (ctx) => const UserProductsScreen(),
              ProductsFavoriteScreen.routeName:
                (ctx) => const ProductsFavoriteScreen(),
            },
            onGenerateRoute: (settings) {
                if (settings.name == EditProductScreen.routeName){
                  final productId = settings.arguments as String?;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return EditProductScreen(
                        productId != null
                        ? ctx.read<ProductsManager>().findById(productId)
                        : null,
                      );
                    },
                  );
                }

                if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return ProductDetailScreen(
                        ctx.read<ProductsManager>().findById(productId)!,
                      );
                    },
                  );
                }

                
                return null;
              },
          );
        },
      ),
    );
  }

}
