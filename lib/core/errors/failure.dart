import 'package:equatable/equatable.dart';
import 'package:smartforce_test/core/constant/text_constant.dart';

class Failure extends Equatable {
  final String message;

  Failure(this.message);
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class ApiFailure extends Failure {
  ApiFailure(String message) : super(message);
}

class NoInternetFailure extends Failure {
  NoInternetFailure({String message = NO_INTERNET_ERROR}) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}
