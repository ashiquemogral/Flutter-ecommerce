import 'package:flutter_ecommerce_app/models/category_model.dart';

abstract class BaseCategoryRepository{

  Stream<List<Category>> getAllCategories();
}