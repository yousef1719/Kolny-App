import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/home/data/models/product_model.dart';
import 'package:hungry_app/features/home/data/models/topping_model.dart';

class ProductRepo {
  ApiService apiService = ApiService();

  /// Get Products
  Future<List<ProductModel?>> getProducts() async {
    try {
      final response = await apiService.get('/products/');
      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  /// Get Toppings
  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await apiService.get('/toppings');
      return (response['data'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  /// Get Options
  Future<List<ToppingModel>> getOptions() async {
    try {
      final response = await apiService.get('/side-options');
      return (response['data'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  /// Search

  /// Category
}
