import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required String message, this.statusCode}) : super(message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super('Unauthorized');
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No internet connection');
}

class CacheFailure extends Failure {
  const CacheFailure({required String message}) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('An unexpected error occurred');
}
