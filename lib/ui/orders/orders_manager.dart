import 'package:flutter_application_1/models/auth_token.dart';
import 'package:flutter_application_1/services/orders_service.dart';

import '../../models/cart_item.dart';
import '../../models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import '../../services/orders_service.dart';


class OrdersManager with ChangeNotifier{
  List<OrderItem> _parseOrderItems(dynamic orders) {
  final List<OrderItem> loadedOrders = [];
  if (orders == null) {
    return loadedOrders;
  }
  orders.forEach((orderId, orderData) {
    final List<dynamic> productsJson = orderData['products'];
    final List<CartItem> loadedProducts = productsJson.map((productJson) => CartItem.fromJson(productJson)).toList();
    final now = DateTime.now().toIso8601String();
    final OrderItem loadedOrder = OrderItem(
      id: orderId,
      amount: orderData['amount'].toDouble(),
      dateTime: now,
      products: loadedProducts,
    );
    loadedOrders.add(loadedOrder);
  });
  return loadedOrders;
}

  List<OrderItem> _orders = [];
  
  final OrdersService _ordersService;
  
  OrdersManager([AuthToken? authToken])
    : _ordersService = OrdersService(authToken);

  set authToken(AuthToken? authToken){
    _ordersService.authToken = authToken;
  }

  int get orderCount{
    return _orders.length;
  }

  List<OrderItem> get orders{
    return [..._orders];
  }

  Future<void> fetchOrders([bool filterByUser = true]) async {
    _orders = await _ordersService.fetchOrders(filterByUser);
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    final now = DateTime.now().toIso8601String();
    final newOrder = await _ordersService.addOrder(OrderItem(
      id: 'o${DateTime.now().toIso8601String()}',
      amount: total,
      products: products,
      dateTime: now,
    ));
    if(newOrder != null){
      _orders.add(newOrder);
      notifyListeners();
    }
  }

  // void addOrder( List<CartItem> cartProducts, double total) async{
  //   final now = DateTime.now().toIso8601String();
  //   _ordersService.addOrder(
  //     OrderItem(
  //       id: 'o${DateTime.now().toIso8601String()}',
  //       amount: total,
  //       products: cartProducts,
  //       dateTime: now,
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void addOrder( List<CartItem> cartProducts, double total) async{
  //   final now = DateTime.now().toIso8601String();
  //   _orders.insert(
  //     0,
  //     OrderItem(
  //       id: 'o${DateTime.now().toIso8601String()}',
  //       amount: total,
  //       products: cartProducts,
  //       dateTime: now,
  //     ),
  //   );
  //   notifyListeners();
  // }
}