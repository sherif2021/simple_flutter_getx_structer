import 'package:flutter/foundation.dart';
import 'package:trust_edge_task/app/core/error/exceptions.dart';
import 'package:trust_edge_task/app/core/error/failure.dart';

ApiFailure getApiFailureFromException(ApiException e) {
  String title = 'Error';
  String message = '';
  if (kDebugMode) print(e);

  if (e.errors != null && e.errors!.isNotEmpty) {
    if (e.message != null) {
      title = e.message!;
    }
    message = e.errors!
        .join('\n')
        .replaceAll(
          '{',
          '',
        )
        .replaceAll(
          '}',
          '',
        );
  }
  if (message.isEmpty && e.message != null && e.message!.isNotEmpty) {
    message = e.message!;
  }
  return ApiFailure(
    title: title,
    message: message,
  );
}
