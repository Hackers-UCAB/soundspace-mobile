import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/log_out/log_out_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_dialog.dart';

import '../../config/router/app_router.dart';

class LogOutListener extends BlocListener<LogOutBloc, LogOutState> {
  LogOutListener({super.key, required Widget child})
      : super(
          bloc: GetIt.instance.get<LogOutBloc>(),
          listener: (BuildContext context, LogOutState state) {
            final getIt = GetIt.instance;
            final appNavigator = getIt.get<AppNavigator>();
            if (state is LogOutSuccess) {
              appNavigator.go('/');
            } else if (state is LogOutFailed) {
              CustomDialog().show(
                  context: context,
                  title: 'Algo salió mal...',
                  message: 'No se pudo cerrar sesión, intenta de nuevo',
                  barrierDismissible: true);
            }
          },
          child: child,
        );
}