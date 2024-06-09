import 'package:task_manager/features/login/domain/entity/login_request_entity/login_request_entity.dart';

import '../../../../core/networking/api_result.dart';
import '../entity/login_response_entity/login_response_entity.dart';

abstract class LoginRepository {
  Future<ApiResult<LoginResponseEntity>> login(
      LoginRequestEntity loginRequestEntity);
}
