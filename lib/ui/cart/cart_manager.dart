import '../../models/cart_item.dart';
import '../../models/product.dart';
import '../../models/auth_token.dart';
import '../../services/carts_service.dart';
import 'package:flutter/foundation.dart';

// import 'package:firebase_database/firebase_database.dart';

class CartManager with ChangeNotifier{
  List< CartItem> _items = [];

  final CartsService _cartsService;

  CartManager([AuthToken? authToken])
    : _cartsService = CartsService(authToken);

  set authToken(AuthToken? authToken){
    _cartsService.authToken = authToken;
  }
  
  

  Future<void> fetchCarts([bool filterByUser = true]) async {
    _items = await _cartsService.fetchCarts(filterByUser);
    // print(_items);
    notifyListeners();
  }

  Future<void> addCart(CartItem cart) async {
    final newCart = await _cartsService.addCart(cart);
    if(newCart != null){
      _items.add(newCart);
      notifyListeners();
    }
  }

  int get productCount{
    return _items.length;
  }
  int get itemCount{
    return _items.length;
  }

  List<CartItem> get products{
    return _items.toList();
  }

  List<CartItem> get productEntries{
    return [..._items];
  }


  double get totalAmount{
    var total = 0.0;
    for(var i = 0; i < _items.length; i++){
        total+= _items[i].price * _items[i].quantity;
    }
    return total;
  }

  // Future<void> addItem(Product product) async {
  //   final existingCartItem = _items.indexWhere((item) => item.id == product.id);
  //   if (existingCartItem >=0) {
  //     //chang quantity..
  //      if (existingCartItem >= 0) {
  //       _items[existingCartItem] =
  //         CartItem(
  //           id: _items[existingCartItem].id,
  //           title: _items[existingCartItem].title,
  //           imageUrl: _items[existingCartItem].imageUrl,
  //           price: _items[existingCartItem].price,
  //           quantity: _items[existingCartItem].quantity + 1,
  //         );
  //       notifyListeners();
  //     } else {
  //       final cartItem = CartItem(
  //         id: DateTime.now().toString(),
  //         title: product.title,
  //         price: product.price,
  //         imageUrl: product.imageUrl,
  //         quantity: 1,
  //       );
  //       _items.add(cartItem);
  //       notifyListeners();
  //     }
  //   }
  // }

  Future<void> removeItem(String productId) async {
    int tmp = _items.indexWhere((element) => element.id == productId);
    await _cartsService.deleteCart(_items[tmp].id.toString());
    _items.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  Future<void> removeSingleItem(String productId) async {
    // int tmp = -1;
    int tmp = _items.indexWhere((element) => element.id == productId);
    if(tmp < 0){
      return;
    }
    var index = _items.indexWhere((element) => element.id == productId);
    if(_items[index].quantity as num > 1){

      _items[index] = CartItem(
          id: _items[index].id,
          // productId: _items[index].productId,
          title: _items[index].title,
          imageUrl: _items[index].imageUrl,
          price: _items[index].price,
          quantity: _items[index].quantity - 1,
        );
      await _cartsService.updateCart(_items[index]);
    }else {
      var index = _items.indexWhere((element) => element.id == productId);
      await _cartsService.deleteCart(_items[index].id.toString());
      _items.removeWhere((item) => item.id == productId);
    }
    notifyListeners();
  }

  Future<void> clear() async {
    for(var i = 0; i < _items.length; i++){
      await _cartsService.deleteCart(_items[i].id.toString());
    }
    _items = [];
    notifyListeners();
  }
}
