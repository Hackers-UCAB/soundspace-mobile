part of 'log_in_subscriber_bloc.dart';

abstract class LogInSubscriberEvent extends Equatable {
  final String phone;
  const LogInSubscriberEvent({required this.phone});

  @override
  List<Object> get props => [phone];
}

//Evento al hacer clic en iniciar sesion
class LogInSubscriberSubmitted extends LogInSubscriberEvent {
  const LogInSubscriberSubmitted({required String phone}) : super(phone: phone);
}

//Evento al cambiar el telefono
class LogInSubscriberPhoneChanged extends LogInSubscriberEvent {
  const LogInSubscriberPhoneChanged({required String phone})
      : super(phone: phone);
}

// evento para cambiar la operadora
class OperatorSubmittedEvent extends LogInSubscriberEvent {
  final String selectedOperator;

  const OperatorSubmittedEvent(
      {required String phone, required this.selectedOperator})
      : super(phone: phone);

  @override
  List<Object> get props => [phone, selectedOperator];
}
