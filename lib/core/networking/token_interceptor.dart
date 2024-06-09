import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_keys.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString(SharedPrefKeys.jwt.name);
    if (jwt?.isNotEmpty == true) {
      options.headers['Authorization'] = jwt;
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = response.headers.value('Authorization') ?? '';
    prefs.setString(SharedPrefKeys.jwt.name, value);
    super.onResponse(response, handler);
  }

  @override
  Future onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    // If the error is 401 Unauthorized, log out the user
    if (err.response?.statusCode == 401) {}
    super.onError(err, handler);
  }
}
