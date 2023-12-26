import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/common/failure.dart';
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
    on<LogInSubscriberSubmitted>(_onSubmited);
    on<LogInSubscriberPhoneChanged>(_phoneChanged);
    on<OperatorSubmittedEvent>(_onSubscribe);
  }

  Future<void> _onSubmited(
      LogInSubscriberEvent event, Emitter<LogInSubscriberState> emit) async {
    emit(LogInSubscriberPosting());

    final logInResult =
        await logInUseCase.execute(LogInUseCaseInput(number: event.phone));
    if (logInResult.hasValue()) {
      GetIt.instance.get<UserPermissionsBloc>().add(
          UserPermissionsChanged(isAuthenticated: true, isSubscribed: true));
      emit(LogInSubscriberSuccess());
    } else if (logInResult.failure! is NoAuthorizeFailure) {
      emit(LogInSubscriberNoAuthorize(
          errorMessage: logInResult.failure!.message));
    } else {
      emit(LogInSubscriberFailure(failure: logInResult.failure!));
    }
  }

  Future<void> _onSubscribe(
      OperatorSubmittedEvent event, Emitter<LogInSubscriberState> emit) async {
    emit(LogInSubscriberPosting());

    final signUpResult = await subscribeUseCase.execute(SubscribeUseCaseInput(
        number: event.phone, operator: event.selectedOperator));
    if (signUpResult.hasValue()) {
      GetIt.instance.get<UserPermissionsBloc>().add(
          UserPermissionsChanged(isAuthenticated: true, isSubscribed: true));
      emit(LogInSubscriberSuccess());
    } else if (signUpResult.failure! is NoAuthorizeFailure) {
      emit(LogInSubscriberNoAuthorize(
          errorMessage: signUpResult.failure!.message));
    } else {
      emit(LogInSubscriberFailure(failure: signUpResult.failure!));
    }
  }

  Future<void> _phoneChanged(
      LogInSubscriberEvent event, Emitter<LogInSubscriberState> emit) async {
    if (event.phone.isEmpty || event.phone.trim().isEmpty) {
      emit(LogInSubscriberInvalid(
          errorMessage: 'Ingresa tu número de teléfono.'));
    } else {
      final phoneNumberPattern =
          RegExp(r'^(58424|58414|58424|414|424|412)\d+$');
      if (!phoneNumberPattern.hasMatch(event.phone)) {
        emit(LogInSubscriberInvalid(
            errorMessage: 'Siga el formato de ejemplo: 4121232323'));
      } else if (event.phone.length != 10) {
        emit(LogInSubscriberInvalid(
            errorMessage: 'El numero debe tener 10 caracteres.'));
      } else {
        emit(LogInSubscriberValid(phone: event.phone));
      }
    }
  }

  void onPhoneChanged(String value) {
    add(LogInSubscriberPhoneChanged(phone: value));
  }
}
