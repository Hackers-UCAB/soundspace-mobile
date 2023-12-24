import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/logInSubs/log_in_subscriber_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import '../../widgets/ipage.dart';
import 'Widgets/custom_text_form_field.dart';
import 'Widgets/error_square.dart';
import 'Widgets/my_button.dart';
import 'Widgets/operators_button.dart';

class RegisterScreen extends IPage {
  const RegisterScreen({super.key});

  @override
  Widget child(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 140),
              Padding(
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

              SizedBox(height: 30),

              //Numero de teléfono text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Número de teléfono',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),

              SizedBox(height: 15),

              _RegisterForm(),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final registerBloc = getIt.get<LogInSubscriberBloc>();
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
              }), //TODO: hacer el boton dinamico
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
                // Otros widgets aquí si los hay
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
