import 'dart:convert';
import 'package:flutter_application_1/models/cart_item.dart';
import 'package:http/http.dart' as http;
import '../models/order_item.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class OrdersService extends FirebaseService{
  OrdersService([AuthToken? authToken]) :super(authToken);

  Future<List<OrderItem>> fetchOrders([bool filterByUser = true]) async{
    final List<OrderItem> orders = [];

    try{
      final filters = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"':'';
      final ordersUrl = 
        Uri.parse('$databaseUrl/orders.json?auth=$token&$filters');
      final response = await http.get(ordersUrl);
      final ordersMap = json.decode(response.body) as Map<String, dynamic>;
     
      if(response.statusCode != 200){
        print(ordersMap['error']);
        return orders;
      }
      // print(CartsMap);
      ordersMap.forEach((orderId, order){
        orders.add(
          OrderItem.fromJson({
            'id': orderId,
            ...order,
          }),
        );
      });
      return orders;
    }catch(error){
      print(error);
      return orders;
    }
  }

  Future<OrderItem?> addOrder(OrderItem order) async {
    try{
      final url = Uri.parse('$databaseUrl/orders.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          order.toJson()
          ..addAll({
            'creatorId': userId,
          }),
        ),
      ); 

      if(response.statusCode !=200){
        throw Exception(json.decode(response.body)['error']);
      }

      return order.copyWith(
        id: json.decode(response.body)['name'],
      );
    }catch(error){
      print(error);
      return null;
    }
  }

  Future<bool> updateOrder(OrderItem order) async {
    try{
      final url = Uri.parse('$databaseUrl/orders/${order.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(
           order.toJson()
        ),
      );

      if(response.statusCode !=200){
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    }catch(error){
      print(error);
      return false;
    }
  }

  Future<bool> deleteOrder(String id) async {
    try{
      final url = Uri.parse('$databaseUrl/orders/$id.json?auth=$token');
      final response = await http.delete(url);

      if(response.statusCode !=200){
        throw Exception(json.decode(response.body)['error']);
      }

      return true;
    }catch(error){
      print(error);
      return false;
    }
  }

}