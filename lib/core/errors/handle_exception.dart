// lib/core/utils/error_handler.dart

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';

class ErrorHandler {
  static ErrorType handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return ErrorType.noInternet;

        case DioExceptionType.badResponse:
          if (error.response?.statusCode == 404) {
            return ErrorType.notFound;
          } else if (error.response?.statusCode == 500 ||
              error.response?.statusCode == 502 ||
              error.response?.statusCode == 503) {
            return ErrorType.serverError;
          }
          return ErrorType.unknown;

        case DioExceptionType.unknown:
          // Проверяем, это ошибка интернета или нет
          if (error.error is SocketException ||
              error.message?.contains('Network') == true ||
              error.message?.contains('Connection refused') == true) {
            return ErrorType.noInternet;
          }
          return ErrorType.unknown;

        default:
          return ErrorType.unknown;
      }
    }
    return ErrorType.unknown;
  }
}
