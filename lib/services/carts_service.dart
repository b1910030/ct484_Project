import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import '../models/auth_token.dart';
import 'firebase_service.dart';

class CartsService extends FirebaseService{
  CartsService([AuthToken? authToken]) :super(authToken);

  Future<List<CartItem>> fetchCarts([bool filterByUser = true]) async{
    final List<CartItem> carts = [];

    try{
      final filters = filterByUser ? 'orderBy="creatorId"&equalTo="$userId"':'';
      final cartsUrl = 
        Uri.parse('$databaseUrl/carts.json?auth=$token&$filters');
      final response = await http.get(cartsUrl);
      final Map<String, dynamic> cartsMap = json.decode(response.body);
     
      if(response.statusCode != 200){
        print(cartsMap['error']);
        return carts;
      }
      // print(CartsMap);
      cartsMap.forEach((cartId, cart){
        carts.add(
          CartItem.fromJson({
            'id': cartId,
            ...cart,
          }),
        );
      });
      return carts;
    }catch(error){
      print(error);
      return carts;
    }
  }

  Future<CartItem?> addCart(CartItem cart) async {
    try{
      final url = Uri.parse('$databaseUrl/carts.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          cart.toJson()
          ..addAll({
            'creatorId': userId,
          }),
        ),
      );

      if(response.statusCode !=200){
        throw Exception(json.decode(response.body)['error']);
      }

      return cart.copyWith(
        id: json.decode(response.body)['name'],
      );
    }catch(error){
      print(error);
      return null;
    }
  }

  Future<bool> updateCart(CartItem cart) async {
    try{
      final url = Uri.parse('$databaseUrl/carts/${cart.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(
          cart.toJson()
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

  Future<bool> deleteCart(String id) async {
    try{
      final url = Uri.parse('$databaseUrl/carts/$id.json?auth=$token');
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