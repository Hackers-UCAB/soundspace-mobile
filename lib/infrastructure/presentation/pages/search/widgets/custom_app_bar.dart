import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user_permissions/user_permissions_bloc.dart';

import '../../../config/router/app_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final navigator = getIt.get<AppNavigator>();
    final userPermissions = getIt.get<UserPermissionsBloc>();
    final textTheme = Theme.of(context).textTheme;
    final bodyMediumStyle = textTheme.bodyMedium?.copyWith(fontSize: 20);
    final bodySmallStyle =
        textTheme.bodySmall?.copyWith(color: Colors.black, fontSize: 15);
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: navigator.currentLocation() != '/home'
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () => navigator.pop(),
            )
          : null,
      actions: [
        navigator.currentLocation() != '/search'
            ? IconButton(
                onPressed: () => navigator.navigateTo('/search'),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))
            : Align(
                alignment: Alignment.centerLeft,
                child: Text('Buscar', style: bodyMediumStyle)),
        const SizedBox(width: 5),
        if (userPermissions.state.isSubscribed)
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (value) {
                switch (value) {
                  case 'Perfil':
                    navigator.navigateTo('/profile');
                    break;
                  case 'Cerrar Sesion':
                    //TODO: log out
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Perfil',
                  child: Text('Perfil', style: bodySmallStyle),
                ),
                PopupMenuItem<String>(
                  value: 'Cerrar Sesion',
                  child: Text(
                    'Cerrar Sesion',
                    style: bodySmallStyle,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
