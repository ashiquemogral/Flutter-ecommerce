import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_app/models/product_model.dart';

class Cart extends Equatable {
  final List<Product> products;
  const Cart({this.products = const <Product>[]});


  Map productQuantity(products){

    var quantity = Map();

    products.forEach((product){
      if(!quantity.containsKey(product)){
        quantity[product] = 1;
      }else{
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double get subTotal => products.fold(0, (total, current) => total + current.price);



  double deliveryFee(subtotal){
    if(subtotal >= 30.0) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  double total(subtotal , deliveryfee){

    return subtotal + deliveryFee(subtotal);
  }



  String freeDelivery(subtotal){
    if(subtotal >= 30.0){
      return 'You have Free Delivery';
    }else{
      double missing = 30.0 - subtotal;
      return 'Add \$${missing.toStringAsFixed(2)} For a Free Delivery';
    }
  }
  String get totalString => total(subTotal, deliveryFee).toStringAsFixed(2) ;

  String get subTotalString => subTotal.toStringAsFixed(2);

  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subTotal);



  // List<Product> products = [
  //   const Product(
  //     // id: '1',
  //     name: 'Soft Drink #1',
  //     category: 'Soft Drinks',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
  //     //https://unsplash.com/photos/dO9A6mhSZZY
  //     price: 2.99,
  //     isRecommended: true,
  //     isPopular: false,
  //   ),
  //   const Product(
  //     // id: '1',
  //     name: 'Soft Drink #1',
  //     category: 'Soft Drinks',
  //     imageUrl:
  //     'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
  //     //https://unsplash.com/photos/dO9A6mhSZZY
  //     price: 2.99,
  //     isRecommended: true,
  //     isPopular: false,
  //   ),
  //   const Product(
  //     // id: '2',
  //     name: 'Soft Drink #2',
  //     category: 'Soft Drinks',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80',
  //     //https://unsplash.com/photos/Viy_8zHEznk
  //     price: 2.99,
  //     isRecommended: false,
  //     isPopular: true,
  //   ),
  //   const Product(
  //     // id: '3',
  //     name: 'Soft Drink #3',
  //     category: 'Soft Drinks',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80',
  //     //https://unsplash.com/photos/5LIInaqRp5s
  //     price: 2.99,
  //     isRecommended: true,
  //     isPopular: true,
  //   ),
  // ];

  @override
  List<Object?> get props => [products];
}
