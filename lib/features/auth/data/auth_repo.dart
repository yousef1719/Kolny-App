import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? _currentUser;

  /// Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post('/login', {
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];

        if (code != 200 && code != 201) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromjson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
          isGuest = false;
          _currentUser = user;
          return user;
        } else {
          throw ApiError(message: 'Unxpected error from server');
        }
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Signup

  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final coder = int.tryParse(code);
        final data = response['data'];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromjson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
          isGuest = false;
          _currentUser = user;
          return user;
        } else {
          throw ApiError(message: 'Unxpected error from server');
        }
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Get Profile data

  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == 'guest') {
        return null;
      }

      final response = await apiService.get('/profile');
      final user = UserModel.fromjson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Update Profile data

  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (imagePath != null && imagePath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.png',
          ),
      });
      final response = await apiService.post('/update-profile', formData);
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final code = response['code'];
        final data = response['data'];
        final coder = int.tryParse(code);

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg);
        }
        final updateUser = UserModel.fromjson(data);
        _currentUser = updateUser;
        return updateUser;
      } else {
        throw ApiError(message: 'Invalid error from here');
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  /// Logout

  Future<void> logout() async {
    final response = await apiService.post('/logout', {});
    if (response['data'] != null) {
      throw ApiError(message: 'Error logging out');
    }
    await PrefHelper.clearToken();
    isGuest = false;
    _currentUser = null;
  }

  /// auto login

  Future<void> autoLogin() async {
    final token = await PrefHelper.getToken();
    if (token == null || token == 'guest') {
      isGuest = true;
      _currentUser = null;
      return;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      _currentUser = user;
    } catch (e) {
      await PrefHelper.clearToken();
      isGuest = true;
      _currentUser = null;
    }
  }

  /// continute as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken('guest');
  }

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
