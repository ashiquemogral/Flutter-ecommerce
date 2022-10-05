import 'package:flutter_ecommerce_app/models/models.dart';
import 'package:hive/hive.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  List<Product> getWishList(Box box);
  Future<void> addProductToWishList(Box box, Product product);
  Future<void> removeProductFromWishlist(Box box, Product product);
  Future<void> clearWishList(Box box);
}