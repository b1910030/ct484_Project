import 'package:flutter/foundation.dart';
class CartItem{
  final String id;
  // final String productId;
  // final String userId;
  final String title;
  final String imageUrl;
  final int quantity;
  final double price;

  
  CartItem({
    required this.id,
    // required this.productId,
    // required this.userId,
    required this.title,
    required this.quantity,
    required this.imageUrl,
    required this.price,

  });

  CartItem copyWith({
    String ? id,
    String? productId,
    // String? userId,
    String? title,
    String? imageUrl,
    int? quantity,
    double? price,

  }){
    return CartItem(
      id: id ?? this.id, 
      // productId: productId ?? this.productId, 
      // userId: userId ?? this.userId, 
      title: title ?? this.title, 
      imageUrl: imageUrl ?? this.imageUrl, 
      quantity: quantity ?? this.quantity, 
      price: price ?? this.price,

    );
  }

   Map<String, dynamic> toJson(){
    return{
      // 'productId': productId,
      'title': title,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,

    };
  }

  static CartItem fromJson(Map<String, dynamic> json){
    return CartItem(
      id: json['id'], 
      // productId: json['productId'], 
      title: json['title'], 
      imageUrl: json['imageUrl'], 
      price: json['price'],
      quantity: json['quantity'],

    );
  }
}