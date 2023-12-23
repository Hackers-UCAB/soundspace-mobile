part of 'log_in_subscriber_bloc.dart';

abstract class LogInSubscriberState extends Equatable {
  const LogInSubscriberState();

  @override
  List<Object> get props => [];
}
class LogInSubscriberInitial extends LogInSubscriberState {}
class LogInSubscriberValidating extends LogInSubscriberState {}

class LogInSubscriberValid extends LogInSubscriberState {
  final Phone phone;

  const LogInSubscriberValid({required this.phone});

  @override
  List<Object> get props => [phone];
}

class LogInSubscriberPosting extends LogInSubscriberState {}

class LogInSubscriberSuccess extends LogInSubscriberState {}

class LogInSubscriberFailure extends LogInSubscriberState {
  final Failure failure;

  const LogInSubscriberFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}

class LogInSubscriberInvalid extends LogInSubscriberState {
  final String errorMessage;

  const LogInSubscriberInvalid({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}