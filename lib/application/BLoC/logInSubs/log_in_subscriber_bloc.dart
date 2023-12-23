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

class LogInSubscriberBloc
    extends Bloc<LogInSubscriberEvent, LogInSubscriberState> {
  final LogInUseCase logInUseCase;
  final SubscribeUseCase subscribeUseCase;
  LogInSubscriberBloc(
      {required this.logInUseCase, required this.subscribeUseCase})
      : super(LogInSubscriberInitial()) {
    on<LogInSubscriberSubmitted>(_onSubmitted);
    on<LogInSubscriberPhoneChanged>(_phoneChanged);
    on<OperatorSubmittedEvent>(_onSubscribe);
  }

  Future<void> _onSubmitted(
      LogInSubscriberSubmitted event, Emitter<LogInSubscriberState> emit) async {
    final isValid = Formz.validate([Phone.dirty(event.phone)]);

    emit(LogInSubscriberValidating());

    if (isValid) {
      emit(LogInSubscriberPosting());
      final logInResult = await logInUseCase.execute(event.phone);
      if (logInResult.hasValue()) {
        GetIt.instance.get<UserPermissionsBloc>().add(
            UserPermissionsChanged(isAuthenticated: true, isSubscribed: true));
        emit(LogInSubscriberSuccess());
      } else if (logInResult.failure is NoAuthorizeFailure) {
        emit(LogInSubscriberInvalid(
            errorMessage: logInResult.failure!.message));
      } else {
        emit(LogInSubscriberFailure(failure: logInResult.failure!));
      }
    }
  }

  Future<void> _onSubscribe(
      OperatorSubmittedEvent event, Emitter<LogInSubscriberState> emit) async {
        final phone = Phone.dirty(event.phone);
        final isValid = Formz.validate([Phone.dirty(event.phone)]);

    emit(LogInSubscriberValidating());

    if (isValid) {
      emit(LogInSubscriberPosting());
      final signUpResult =
          await subscribeUseCase.execute(phone.value, event.selectedOperator);
      if (signUpResult.hasValue()) {
        GetIt.instance.get<UserPermissionsBloc>().add(
            UserPermissionsChanged(isAuthenticated: true, isSubscribed: true));
        emit(LogInSubscriberSuccess());
      } else if (signUpResult.failure is NoAuthorizeFailure) {
        emit(LogInSubscriberInvalid(
            errorMessage: signUpResult.failure!.message));
      } else {
        emit(LogInSubscriberFailure(failure: signUpResult.failure!));
      }
    }
  }

  void _phoneChanged(
      LogInSubscriberPhoneChanged event, Emitter<LogInSubscriberState> emit) {
    final phone = Phone.dirty(event.phone);
    bool isValid = Formz.validate([phone]);
    if (isValid){
      emit(LogInSubscriberValid(phone: phone));
    }
    else{
      emit(LogInSubscriberInvalid(errorMessage: phone.error.toString()));
    }
  }

  void onPhoneChanged(String value) {
    add(LogInSubscriberPhoneChanged(phone: value));
  }
}