import 'package:task_manager/features/login/domain/entity/login_request_entity/login_request_entity.dart';
import 'package:task_manager/features/login/domain/repository/login_repository.dart';

import '../../../../core/networking/api_result.dart';
import '../entity/login_response_entity/login_response_entity.dart';

class LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  Future<ApiResult<LoginResponseEntity>> call(
          LoginRequestEntity requestEntity) async =>
      await _loginRepository.login(requestEntity);
}
