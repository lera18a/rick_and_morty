import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';

class ErrorLoc extends StatelessWidget {
  const ErrorLoc({
    super.key,
    required this.message,
    this.errorType = ErrorType.unknown,
  });

  final String message;
  final ErrorType errorType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(errorType.icon, color: _getIconColor(), size: 60),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _getSubtitle(),
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Color _getIconColor() {
    switch (errorType) {
      case ErrorType.noInternet:
        return Colors.orange;
      case ErrorType.notFound:
        return Colors.purple;
      case ErrorType.serverError:
        return Colors.blue;
      case ErrorType.unknown:
        return Colors.red;
    }
  }

  String _getSubtitle() {
    switch (errorType) {
      case ErrorType.noInternet:
        return 'Check your internet connection and try again';
      case ErrorType.notFound:
        return 'This character doesn\'t exist';
      case ErrorType.serverError:
        return 'The server is temporarily unavailable';
      case ErrorType.unknown:
        return 'An unexpected error occurred';
    }
  }
}
