import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../core/networking/api_constants.dart';
import '../models/todos_model.dart';

part 'home_datasource.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HomeDataSource {
  factory HomeDataSource(Dio dio, {String baseUrl}) = _HomeDataSource;

  @GET(ApiConstants.todos)
  Future<TodosModel> getAllTodos();
}
