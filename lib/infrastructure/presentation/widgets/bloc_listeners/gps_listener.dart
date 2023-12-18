import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../application/BLoC/gps/gps_bloc.dart';
import '../custom_dialog.dart';

class GpsListener extends BlocListener<GpsBloc, GpsState> {
  GpsListener({super.key, required child})
      : super(
          bloc: GetIt.instance.get<GpsBloc>(),
          listener: (BuildContext context, GpsState state) {
            String? title;
            String? message;
            Function()? onPressed;
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
            } else {
              CustomDialog().hide(context);
            }

            if (!state.isGpsEnabled || !state.isAllGranted) {
              CustomDialog().show(
                  context: context,
                  title: title!,
                  message: message!,
                  onPressed: onPressed);
            }
          },
          child: child,
        );
}
