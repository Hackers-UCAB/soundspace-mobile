part of 'log_in_subscriber_bloc.dart';

abstract class LogInSubscriberEvent extends Equatable {
  final String phone;
  const LogInSubscriberEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

//Evento al hacer clic en iniciar sesion
class LogInSubscriberSubmitted extends LogInSubscriberEvent {
  const LogInSubscriberSubmitted({required super.phone});
}

//Evento al entrar en la log in page
class LogInEntered extends LogInSubscriberEvent {
  const LogInEntered({required super.phone});
}

//Evento al cambiar el telefono
class LogInSubscriberPhoneChanged extends LogInSubscriberEvent {
  const LogInSubscriberPhoneChanged({required super.phone});
}

// evento para cambiar la operadora
class OperatorSubmittedEvent extends LogInSubscriberEvent {
  final String selectedOperator;

  const OperatorSubmittedEvent(
      {required super.phone, required this.selectedOperator});

  @override
  List<Object> get props => [phone, selectedOperator];
}
