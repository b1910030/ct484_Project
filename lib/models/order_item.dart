  import 'cart_item.dart';
  import 'package:flutter/foundation.dart';
  class OrderItem{
    final String? id;
    final double amount;
    final List<CartItem> products;
    final String dateTime;

    int get productCount{
      return products.length;
    }

    OrderItem({
      required this.id,
      required this.amount,
      required this.products,
      required this.dateTime,
    }) ;

    OrderItem copyWith({
      String? id,
      double? amount,
      List<CartItem>? products,
      String? dateTime,
    }){
      return OrderItem(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        products: products ?? this.products,
        dateTime: dateTime ?? this.dateTime,
      );
    }

    Map<String, dynamic> toJson(){
      return{

        'amount': amount,
        'products': products,
        'dateTime': dateTime,
      };
    }

    static OrderItem fromJson(Map<String, dynamic> json){
      return OrderItem(
        id: json['id'], 
        // productId: json['productId'], 
        amount: json['amount'], 
        products: json['products'], 
        dateTime: json['dateTime'],
      );
    }
  }