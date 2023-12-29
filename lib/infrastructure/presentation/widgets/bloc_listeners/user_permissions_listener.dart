import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_dialog.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';

class UserPermissionsListener
    extends BlocListener<UserPermissionsBloc, UserPermissionsState> {
  UserPermissionsListener({super.key, required Widget child})
      : super(
          bloc: GetIt.instance.get<UserPermissionsBloc>(),
          listener: (BuildContext context, UserPermissionsState state) {
            if (state is! UserPermissionsFailed &&
                state.validLocation == false) {
              CustomDialog().show(
                  context: context,
                  title: 'Parece que te encuentras lejos...',
                  message:
                      'Ahora eres un invitado, solo en Venezuela tienes acceso premium',
                  barrierDismissible: true);
            } else if (state is UserPermissionsFailed) {
              child = ErrorPage(failure: state.failure);
            }
          },
          child: child,
        );
}
