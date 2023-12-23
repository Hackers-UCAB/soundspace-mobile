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
  late final String errorMessage;

  LogInSubscriberInvalid({required PhoneError displayError}) {
    errorMessage = getErrorMessage(displayError);
  }

  String getErrorMessage(PhoneError displayError) {
    if (displayError == PhoneError.empty) {
      return 'Ingresa tu número de teléfono.';
    } else if (displayError == PhoneError.length) {
      return 'El numero debe tener 10 o 12 caracteres.';
    } else {
      return 'Siga el formato de ejemplo: 584241232323 o 4121232323';
    }
  }
}

class LogInSubscriberFailure extends LogInSubscriberState {
  final Failure failure;

  LogInSubscriberFailure({required this.failure});
}
