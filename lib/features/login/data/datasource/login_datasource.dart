import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_manager/core/networking/api_constants.dart';
import 'package:task_manager/features/login/data/models/login_request_body.dart';

import '../models/login_response.dart';

part 'login_datasource.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class LoginDataSource {
  factory LoginDataSource(Dio dio, {String baseUrl}) = _LoginDataSource;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);
}
