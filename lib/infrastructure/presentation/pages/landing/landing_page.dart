import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/log_in_guest/log_in_guest_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import '../../../../application/use_cases/user/log_in_guest_use_case.dart';
import '../../config/router/app_router.dart';
import 'widgets/landing_promo.dart';
import 'widgets/register_button.dart';

class LandingPage extends StatelessWidget {
  final getIt = GetIt.instance;
  late final LogInGuestBloc logInGuestBloc;

  LandingPage({super.key}) {
    logInGuestBloc =
        LogInGuestBloc(logInGuestUseCase: getIt.get<LogInGuestUseCase>());
  }

  @override
  Widget build(BuildContext context) {
    final appNavigator = getIt.get<AppNavigator>();

    return Scaffold(
      body: BlocProvider(
        create: (context) => logInGuestBloc,
        child: BlocListener<UserPermissionsBloc, UserPermissionsState>(
          listener: (context, state) {
            if (state.isAuthenticated) {
              appNavigator.go('/home');
            }
          },
          child: BlocBuilder<LogInGuestBloc, LogInGuestState>(
            builder: (context, state) {
              final size = MediaQuery.of(context).size;
              final bodySmall = Theme.of(context).textTheme.bodySmall;
              return Stack(
                children: [
                  const GradientBackground(),
                  Column(
                    children: [
                      // Imagen
                      const LandingPromo(promoPath: 'images/aqustico2.png'),
                      SizedBox(height: size.height * 0.04),
                      // Texto
                      Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                            horizontal: size.width * 0.1),
                        child: Text(
                          "Te brindamos la experiencia de estar en Aqustico 7 días gratis.",
                          style: bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      // Botón de registro
                      const RegisterButtom(),
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿Tienes una cuenta? ',
                            style: bodySmall,
                          ),
                          GestureDetector(
                            onTap: () {
                              appNavigator.navigateTo('/logIn');
                            },
                            child: Text('Inicia sesión',
                                style: bodySmall!.copyWith(
                                  color: Colors.lightBlue,
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'O ingresa como ',
                            style: bodySmall,
                          ),
                          if (state is LogInGuestPosting)
                            const CircularProgressIndicator(),
                          GestureDetector(
                            onTap: () {
                              logInGuestBloc.add(LogInGuestSubmitted());
                            },
                            child: Text(
                              //TODO: Tomar el style del theme o crear uno
                              'Invitado',
                              style: bodySmall.copyWith(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          //TODO: Usar el widget de oriana para el estado Failed
                        ],
                      ),
                      SizedBox(height: size.height * 0.13),
                      //Image
                      Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Image.asset(
                            'images/logo_conectium.png',
                            width: 120,
                          )),
                      Image.asset(
                        'images/hojitas.png',
                        width: 120,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
