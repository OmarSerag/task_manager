import 'package:dio/dio.dart';

import 'api_constants.dart';
import 'api_error_model.dart';

enum DataSourceErrors {
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found
  static const int API_LOGIC_ERROR = 422; // API , lOGIC ERROR

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String NO_CONTENT =
      ApiErrors.noContent; // success with no data (no content)
  static const String BAD_REQUEST =
      ApiErrors.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      ApiErrors.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      ApiErrors.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      ApiErrors.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      ApiErrors.notFoundError; // failure, crash in server side

  // local status code
  static String CONNECT_TIMEOUT = ApiErrors.timeoutError;
  static String CANCEL = ApiErrors.defaultError;
  static String RECIEVE_TIMEOUT = ApiErrors.timeoutError;
  static String SEND_TIMEOUT = ApiErrors.timeoutError;
  static String CACHE_ERROR = ApiErrors.cacheError;
  static String NO_INTERNET_CONNECTION = ApiErrors.noInternetError;
  static String DEFAULT = ApiErrors.defaultError;
}

extension DataSourceExtension on DataSourceErrors {
  ApiErrorModel getFailure() {
    switch (this) {
      case DataSourceErrors.NO_CONTENT:
        return ApiErrorModel(
            code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT);
      case DataSourceErrors.BAD_REQUEST:
        return ApiErrorModel(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case DataSourceErrors.FORBIDDEN:
        return ApiErrorModel(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);
      case DataSourceErrors.UNAUTORISED:
        return ApiErrorModel(
            code: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);
      case DataSourceErrors.NOT_FOUND:
        return ApiErrorModel(
            code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND);
      case DataSourceErrors.INTERNAL_SERVER_ERROR:
        return ApiErrorModel(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSourceErrors.CONNECT_TIMEOUT:
        return ApiErrorModel(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case DataSourceErrors.CANCEL:
        return ApiErrorModel(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case DataSourceErrors.RECIEVE_TIMEOUT:
        return ApiErrorModel(
            code: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case DataSourceErrors.SEND_TIMEOUT:
        return ApiErrorModel(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case DataSourceErrors.CACHE_ERROR:
        return ApiErrorModel(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case DataSourceErrors.NO_INTERNET_CONNECTION:
        return ApiErrorModel(
            code: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSourceErrors.DEFAULT:
        return ApiErrorModel(
            code: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}

class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      apiErrorModel = _handleError(error);
    } else {
      // default error
      apiErrorModel = DataSourceErrors.DEFAULT.getFailure();
    }
  }
}

ApiErrorModel _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSourceErrors.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSourceErrors.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSourceErrors.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ApiErrorModel.fromJson(error.response!.data);
      } else {
        return DataSourceErrors.DEFAULT.getFailure();
      }
    case DioExceptionType.unknown:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return ApiErrorModel.fromJson(error.response!.data);
      } else {
        return DataSourceErrors.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSourceErrors.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSourceErrors.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSourceErrors.DEFAULT.getFailure();
    case DioExceptionType.badResponse:
      return DataSourceErrors.DEFAULT.getFailure();
  }
}
