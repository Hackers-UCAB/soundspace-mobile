import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_dialog.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';

class UserPermissionsListener
    extends BlocListener<UserPermissionsBloc, UserPermissionsState> {
  UserPermissionsListener({super.key, required Widget child})
      : super(
          bloc: GetIt.instance.get<UserPermissionsBloc>(),
          listener: (BuildContext context, UserPermissionsState state) {
            if (state is! UserPermissionsFailed) {
              if (state.validLocation == false) {
                CustomDialog().show(
                    context: context,
                    title: 'Parece que te encuentras lejos...',
                    message:
                        'Ahora eres un invitado, solo en Venezuela tienes acceso premium',
                    barrierDismissible: true);
              } else if (state.isSubscribed == false && state.isAuthenticated) {
                CustomDialog().show(
                    context: context,
                    title: 'Una lastima!',
                    message:
                        'Tu subscripcion ha sido cancelada, pero siempre puedes volver a la experiencia premium!',
                    barrierDismissible: true);
                GetIt.instance.get<AppNavigator>().go('/home');
              }
            } else {
              child = ErrorPage(failure: state.failure);
            }
          },
          child: child,
        );
}
