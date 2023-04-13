import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/order_item.dart';
import 'package:provider/provider.dart';
import 'orders_manager.dart';
import 'order_item_card.dart';
import '../shared/app_drawer.dart';
import '../screens.dart';


class OrdersScreen extends StatelessWidget {

  
  static const routeName = '/orders';
  const OrdersScreen({super.key});
  

  @override
  Widget build(BuildContext context){
    print('building orders');
    final ordersManager = Provider.of<OrdersManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: ordersManager.fetchOrders(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            // Hiển thị tiêu đề "Loading" khi đang chờ kết quả
            return Center(
              child: CircularProgressIndicator()
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred. Please try again later.'),
            );
          } else {
            // Hiển thị danh sách đơn hàng nếu thao tác lấy danh sách đơn hàng hoàn tất
            return Consumer<OrdersManager>(
              builder: (ctx, ordersManager, child){
                final orders = ordersManager.orders;
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (ctx, i) => OrderItemCard(orders[i]),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

