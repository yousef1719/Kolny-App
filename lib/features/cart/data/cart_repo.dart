import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/cart/data/cart_model.dart';

class CartRepo {
  ApiService apiService = ApiService();

  Future<void> addToCart(CartRequestModel cartData) async {
    try {
      final res = await apiService.post('/cart/add', cartData.toJson());

      throw ApiError(message: 'Product added to cart successfully');
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
