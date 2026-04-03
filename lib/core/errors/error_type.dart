// lib/core/enums/error_type.dart

import 'package:flutter/material.dart';

enum ErrorType { noInternet, notFound, serverError, unknown }

extension ErrorTypeExt on ErrorType {
  String get message {
    switch (this) {
      case ErrorType.noInternet:
        return 'No Internet Connection';
      case ErrorType.notFound:
        return 'Character Not Found';
      case ErrorType.serverError:
        return 'Server Error. Try again later';
      case ErrorType.unknown:
        return 'Something went wrong';
    }
  }

  IconData get icon {
    switch (this) {
      case ErrorType.noInternet:
        return Icons.wifi_off;
      case ErrorType.notFound:
        return Icons.person_off;
      case ErrorType.serverError:
        return Icons.cloud_off;
      case ErrorType.unknown:
        return Icons.error_outline;
    }
  }
}
