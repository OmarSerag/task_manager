import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/features/login/domain/entity/login_request_entity/login_request_entity.dart';
import 'package:task_manager/features/login/domain/usecase/login_use_case.dart';

import '../../../../core/networking/shared_keys.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState.initial());

  TextEditingController userNameController =
      TextEditingController(text: "kminchelle");
  TextEditingController passwordController =
      TextEditingController(text: "0lelplR");
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginUseCase(
      LoginRequestEntity(
        username: userNameController.text,
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) {
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
    });
  }

  Future<String?> readUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedPrefKeys.userName.name);
  }
}
