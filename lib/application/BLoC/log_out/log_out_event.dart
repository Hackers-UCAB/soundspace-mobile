part of 'log_out_bloc.dart';

abstract class LogOutEvent {}

class LogOutEventTriggered extends LogOutEvent {}

class LogOutReseted extends LogOutEvent {}
