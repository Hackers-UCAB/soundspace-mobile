part of 'log_in_subscriber_bloc.dart';

enum FormStatus { invalid, valid, validating, posting, success, failure }

class LogInSubscriberState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final Phone phone;

  const LogInSubscriberState(
      {this.formStatus = FormStatus.validating,
      this.isValid = false,
      this.phone = const Phone.pure()});

  LogInSubscriberState copyWith(
          {FormStatus? formStatus, bool? isValid, Phone? phone}) =>
      LogInSubscriberState(
          formStatus: formStatus ?? this.formStatus,
          isValid: isValid ?? this.isValid,
          phone: phone ?? this.phone);
  @override
  List<Object> get props => [formStatus, isValid, phone];
}

class LogInSubscriberInvalid extends LogInSubscriberState {
  final String errorMessage;

  const LogInSubscriberInvalid({required this.errorMessage})
      : super(formStatus: FormStatus.failure);

  @override
  List<Object> get props => [errorMessage];
}

class LogInSubscriberFailure extends LogInSubscriberState {
  final Failure failure;

  const LogInSubscriberFailure({required this.failure})
      : super(formStatus: FormStatus.failure);

  @override
  List<Object> get props => [failure];
}
