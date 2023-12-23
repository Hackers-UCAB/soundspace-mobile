import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/common/failure.dart';
import '../../../infrastructure/presentation/pages/logIn/inputs/phone.dart';
import '../../use_cases/user/log_in_use_case.dart';
import '../../use_cases/user/subscribe_use_case.dart';
import '../user_permissions/user_permissions_bloc.dart';

part 'log_in_subscriber_event.dart';
part 'log_in_subscriber_state.dart';

enum PhoneError { empty, length, format, non }

class LogInSubscriberBloc
    extends Bloc<LogInSubscriberEvent, LogInSubscriberState> {
  final LogInUseCase logInUseCase;
  final SubscribeUseCase subscribeUseCase;
  LogInSubscriberBloc(
      {required this.logInUseCase, required this.subscribeUseCase})
      : super(LogInSubscriberInitial()) {
    on<LogInSubscriberSubmitted>(_onSubmited);
    on<LogInSubscriberPhoneChanged>(_phoneChanged);
    on<OperatorSubmittedEvent>(_onSubscribe);
  }

  Future<void> _onSubmited(
      LogInSubscriberEvent event, Emitter<LogInSubscriberState> emit) async {
    final phoneError = _validate(event.phone);

    emit(
      LogInSubscriberValidating(),
    );

    if (phoneError == PhoneError.non) {
      emit(LogInSubscriberPosting());
      final logInResult = await logInUseCase.execute(event.phone);
      if (logInResult.hasValue()) {
        GetIt.instance.get<UserPermissionsBloc>().add(
            UserPermissionsChanged(isAuthenticated: true, isSubscribed: true));
      } else if (logInResult.failure! is NoAuthorizeFailure) {
        emit(LogInSubscriberNoAuthorize(
            errorMessage: logInResult.failure!.message));
      } else {
        emit(LogInSubscriberFailure(failure: logInResult.failure!));
      }
    } else {
      emit(LogInSubscriberInvalid(displayError: phoneError));
    }
  }

  Future<void> _onSubscribe(
      OperatorSubmittedEvent event, Emitter<LogInSubscriberState> emit) async {
    final isValid = _validate(event.phone);

    emit(
      state.copyWith(
          formStatus: FormStatus.validating,
          phone: Phone.dirty(state.phone.value),
          isValid: isValid),
    );

    if (isValid) {
      emit(state.copyWith(formStatus: FormStatus.posting));
      final signUpResult = await subscribeUseCase.execute(
          state.phone.value, event.selectedOperator);
      if (signUpResult.hasValue()) {
        GetIt.instance.get<UserPermissionsBloc>().add(
            UserPermissionsChanged(isAuthenticated: true, isSubscribed: true));

        emit(state.copyWith(formStatus: FormStatus.success));
      } else if (signUpResult.failure! is NoAuthorizeFailure) {
        emit(LogInSubscriberInvalid(
            errorMessage: signUpResult.failure!.message));
      } else {
        emit(LogInSubscriberFailure(failure: signUpResult.failure!));
      }
    }
  }

  Future<void> _phoneChanged(
      LogInSubscriberEvent event, Emitter<LogInSubscriberState> emit) async {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
        formStatus: FormStatus.valid,
        phone: phone,
        isValid: Formz.validate([phone])));
  }

  void onPhoneChanged(String value) {
    add(LogInSubscriberPhoneChanged(phone: value));
  }

  PhoneError _validate(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneError.empty;
    if (value.length != 10 && value.length != 12) return PhoneError.length;
    final phoneNumberPattern = RegExp(r'^(58424|58414|58424|414|424|412)\d+$');
    if (!phoneNumberPattern.hasMatch(value)) return PhoneError.format;

    return PhoneError.non;
  }
}
