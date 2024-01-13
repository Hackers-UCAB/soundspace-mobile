import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/logInSubs/log_in_subscriber_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import '../../../../application/use_cases/user/log_in_use_case.dart';
import '../../../../application/use_cases/user/subscribe_use_case.dart';
import '../../widgets/ipage.dart';
import 'Widgets/custom_text_form_field.dart';
import 'Widgets/error_square.dart';
import 'Widgets/my_button.dart';
import 'Widgets/operators_button.dart';

class RegisterScreen extends IPage {
  final getIt = GetIt.instance;
  late final LogInSubscriberBloc logInSubscriberBloc;
  RegisterScreen({super.key}) {
    logInSubscriberBloc = LogInSubscriberBloc(
        logInUseCase: getIt.get<LogInUseCase>(),
        subscribeUseCase: getIt.get<SubscribeUseCase>());
  }

  @override
  Future<void> onRefresh() {
    return Future<void>.value(); //TODO: Pensar en una mejor idea que esto
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) => logInSubscriberBloc,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 140),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Numero de teléfono text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Número de teléfono',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              _RegisterForm(registerBloc: logInSubscriberBloc, getIt: getIt),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final LogInSubscriberBloc registerBloc;
  final GetIt getIt;
  const _RegisterForm({required this.registerBloc, required this.getIt});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();

    return BlocListener<UserPermissionsBloc, UserPermissionsState>(
        listener: (context, state) {
      if (state.isAuthenticated) {
        appNavigator.go('/home');
      }
    }, child: BlocBuilder<LogInSubscriberBloc, LogInSubscriberState>(
      builder: (context, state) {
        return Form(
            child: Column(
          children: [
            CustomTextFormField(
              label: 'Nombre de usuario',
              onChanged: registerBloc.onPhoneChanged,
              errorMessage:
                  (state is LogInSubscriberInvalid) ? state.errorMessage : null,
              hint: 'Ej. 584241232323 o 4121232323',
              icon: Icons.info_outlined,
            ),

            const SizedBox(height: 15),

            if (state is LogInSubscriberNoAuthorize)
              ErrorSquare(
                invalidData: true,
                mensaje: state.errorMessage,
              ),

            if (state is LogInSubscriberPosting)
              const CircularProgressIndicator(),
            const SizedBox(height: 15),

            if (state is! LogInSubscriberPosting)
              MyButton(onTap: () {
                if (state is LogInSubscriberValid) {
                  registerBloc
                      .add(LogInSubscriberSubmitted(phone: state.phone));
                }
              }),
            // Suscríbete text
            const SizedBox(height: 65),
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinea el Row a la izquierda
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    'Suscríbete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 37,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Si no tienes cuenta suscríbete con tu operadora',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ImageContainer(
                  imagePath: 'images/digitel_blanco.png',
                  onTap: () {
                    if (state is LogInSubscriberValid) {
                      registerBloc.add(OperatorSubmittedEvent(
                          phone: state.phone, selectedOperator: 'digitel'));
                    }
                  }),
            ),
            const SizedBox(height: 25),
            Center(
              child: ImageContainer(
                  imagePath: 'images/movistar_blanco.png',
                  onTap: () {
                    if (state is LogInSubscriberValid) {
                      registerBloc.add(OperatorSubmittedEvent(
                          phone: state.phone, selectedOperator: 'movistar'));
                    }
                  }),
            ),
          ],
        ));
      },
    ));
  }
}
