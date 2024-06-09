import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/networking/api_error_handler.dart';
import 'package:task_manager/core/networking/shared_keys.dart';
import 'package:task_manager/features/login/data/datasource/login_datasource.dart';
import 'package:task_manager/features/login/domain/entity/login_request_entity/login_request_entity.dart';
import 'package:task_manager/features/login/domain/entity/login_response_entity/login_response_entity.dart';
import 'package:task_manager/features/login/domain/repository/login_repository.dart';

import '../../../../core/networking/api_result.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginDataSource);

  final LoginDataSource _loginDataSource;

  @override
  Future<ApiResult<LoginResponseEntity>> login(
      LoginRequestEntity loginRequestEntity) async {
    try {
      final request = loginRequestEntity.toModel();
      final response = await _loginDataSource.login(request);
      await saveUser(request.username);
      return ApiResult.success(
        LoginResponseEntity.fromModel(response),
      );
    } catch (error) {
      return ApiResult.failure(
        ErrorHandler.handle(error),
      );
    }
  }

  saveUser(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    //We cannot save custom objects.
    //So json.encode is used to convert User Object to Json a string.
    prefs.setString(SharedPrefKeys.userName.name, userName);
  }
}
