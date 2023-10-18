import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class LocalStorageFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ApiFailure extends Failure {
  final String title;
  final String message;

  ApiFailure({
    required this.title,
    required this.message,
  });

  @override
  List<Object?> get props => [];
}

class CustomFailure extends Failure {
  final String message;

  CustomFailure(this.message);

  @override
  List<Object?> get props => [message];
}
