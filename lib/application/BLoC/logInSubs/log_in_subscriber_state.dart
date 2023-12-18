part of 'log_in_subscriber_bloc.dart';

enum FormStatus { invalid, valid, validating, posting, success, failure }

class LogInSubscriberState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Phone phone;
  final String operator;

  const LogInSubscriberState(
      {this.formStatus = FormStatus.validating,
      this.isValid = false,
      this.phone = const Phone.pure(),
      this.operator = ''});

  LogInSubscriberState copyWith(
          {FormStatus? formStatus,
          bool? isValid,
          Phone? phone,
          String? operator}) =>
      LogInSubscriberState(
          formStatus: formStatus ?? this.formStatus,
          isValid: isValid ?? this.isValid,
          phone: phone ?? this.phone,
          operator: operator ?? this.operator);
  @override
  List<Object> get props => [formStatus, isValid, phone];
}
