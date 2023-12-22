import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/log_in_guest/log_in_guest_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import '../../config/router/app_router.dart';
import 'widgets/landing_promo.dart';
import 'widgets/register_button.dart';

class LandingPage extends IPage {
  const LandingPage({super.key});

  @override
  Widget child(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();
    final logInGuestBloc = getIt.get<LogInGuestBloc>();

    return BlocListener<UserPermissionsBloc, UserPermissionsState>(
      listener: (context, state) {
        if (state.isAuthenticated) {
          appNavigator.replaceWith('/home');
        }
      },
      child: BlocBuilder<LogInGuestBloc, LogInGuestState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Imagen
                const LandingPromo(promoPath: 'images/aqustico2.png'),
                const SizedBox(height: 20),
                // Texto
                const Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: Text(
                    "Te brindamos la experiencia de estar en Aqustico 7 días gratis.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 30),
                // Botón de registro
                const RegisterButtom(),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '¿Tienes una cuenta? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    if (state is! LogInGuestPosting)
                      GestureDetector(
                        onTap: () {
                          appNavigator.navigateTo('/logIn');
                        },
                        child: const Text(
                          'Inicia sesión',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    if (state is LogInGuestPosting)
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'O ingresa como ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        logInGuestBloc.add(LogInGuestSubmitted());
                      },
                      child: const Text(
                        //TODO: Tomar el style del theme o crear uno
                        'Invitado',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    //TODO: Usar el widget de oriana para el estado Failed
                  ],
                ),

                const SizedBox(height: 90),

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
            ),
          );
        },
      ),
    );
  }
}
