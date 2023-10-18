import 'package:trust_edge_task/app/core/error/failure.dart';

String? getFailureTitle(Failure failure) {
  if (failure is ApiFailure) {
    return failure.title;
  } else if (failure is LocalStorageFailure) {
    return 'Local Storage Error';
  }
  return null;
}

String getFailureMessage(Failure failure) {
  if (failure is ApiFailure) {
    return failure.message;
  } else if (failure is CustomFailure) {
    return failure.message;
  } else if (failure is LocalStorageFailure) {
    return 'Error when Save or Get Data from Local Storage';
  } else {
    return 'unknown error happened';
  }
}
