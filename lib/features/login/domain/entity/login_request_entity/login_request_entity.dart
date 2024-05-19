import 'package:task_manager/features/login/data/models/login_request_body.dart';

class LoginRequestEntity {
  final String username;
  final String password;

  LoginRequestEntity({required this.username, required this.password});

  LoginRequestBody toModel() =>
      LoginRequestBody(username: username, password: password);
}
