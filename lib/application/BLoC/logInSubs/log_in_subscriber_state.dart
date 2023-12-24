part of 'log_in_subscriber_bloc.dart';

abstract class LogInSubscriberState {}

class LogInSubscriberInitial extends LogInSubscriberState {}

class LogInSubscriberValid extends LogInSubscriberState {
  final String phone;

  LogInSubscriberValid({required this.phone});
}

class LogInSubscriberPosting extends LogInSubscriberState {}

class LogInSubscriberNoAuthorize extends LogInSubscriberState {
  final String errorMessage;

  LogInSubscriberNoAuthorize({required this.errorMessage});
}

class LogInSubscriberInvalid extends LogInSubscriberState {
  final String errorMessage;

  LogInSubscriberInvalid({required this.errorMessage});
}

class LogInSubscriberFailure extends LogInSubscriberState {
  final Failure failure;

  LogInSubscriberFailure({required this.failure});
}

class LogInSubscriberSuccess extends LogInSubscriberState {
  final String phone;

  LogInSubscriberSuccess({this.phone = ''});
}
