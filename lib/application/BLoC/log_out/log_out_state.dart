part of 'log_out_bloc.dart';

abstract class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

class LogOutInitial extends LogOutState {}

class LogOutSuccess extends LogOutState {}

class LogOutFailed extends LogOutState {
  final Failure failure;
  const LogOutFailed({required this.failure});
}
