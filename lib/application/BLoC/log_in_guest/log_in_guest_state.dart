part of 'log_in_guest_bloc.dart';

abstract class LogInGuestState {}

class LogInGuestInitial extends LogInGuestState {}

class LogInGuestPosting extends LogInGuestState {}

class LogInGuestFailure extends LogInGuestState {
  final Failure failure;

  LogInGuestFailure({required this.failure});
}

class LogInGuestSuccess extends LogInGuestState {}
