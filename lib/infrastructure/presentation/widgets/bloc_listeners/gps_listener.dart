import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';
import '../../../../application/BLoC/gps/gps_bloc.dart';
import '../custom_dialog.dart';

class GpsListener extends BlocListener<GpsBloc, GpsState> {
  GpsListener({super.key, required Widget child})
      : super(
          bloc: GetIt.instance.get<GpsBloc>(),
          listener: (BuildContext context, GpsState state) {
            String? title;
            String? message;
            Function()? onPressed;
            bool barrierDismissible = false;
            if (!state.isGpsEnabled) {
              title = 'GPS Deshabilitado';
              message = 'Por favor habilita tu GPS';
              onPressed = null;
            } else if (state.isGpsEnabled && !state.isAllGranted) {
              CustomDialog().hide(context);
              title = 'Permiso de Ubicacion';
              message = 'Por favor acepta el permiso de GPS';
              onPressed = () {
                GetIt.instance.get<GpsBloc>().add(RequestedGpsAccess());
              };
            } else if (state.isGpsEnabled && state.isAllGranted) {
              CustomDialog().hide(context);
              if (!state.isInsideVenezuela) {
                GetIt.instance.get<UserPermissionsBloc>().add(
                      UserPermissionsChanged(
                        isAuthenticated: true,
                        isSubscribed: false,
                      ),
                    );
                title = 'Parece que te encuentras lejos...';
                message =
                    'Debes estar dentro de Venezuela para poder acceder al contenido premium. Ahora solo tienes acceso como invitado';
                onPressed = null;
                barrierDismissible = true;
              }
            } else {
              CustomDialog().hide(context);
            }

            if (!state.isGpsEnabled ||
                !state.isAllGranted ||
                !state.isInsideVenezuela) {
              CustomDialog().show(
                  context: context,
                  title: title!,
                  message: message!,
                  onPressed: onPressed,
                  barrierDismissible: barrierDismissible);
            }
          },
          child: child,
        );
}
