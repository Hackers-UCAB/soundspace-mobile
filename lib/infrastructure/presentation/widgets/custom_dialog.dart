import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';

class CustomDialog {
  static final CustomDialog _customDialog = CustomDialog._();
  bool _isShowing = false;
  final AppNavigator _navigator = GetIt.instance.get<AppNavigator>();

  CustomDialog._();

  factory CustomDialog() {
    return _customDialog;
  }

  Future<void> show(
      {required BuildContext context,
      required String title,
      required String message,
      bool barrierDismissible = false,
      Function()? onPressed}) async {
    _isShowing = true;
    return showDialog<void>(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: false,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(
                message,
                style: const TextStyle(color: Colors.black),
              ),
              actions: onPressed == null
                  ? null
                  : <Widget>[
                      TextButton(
                        onPressed: onPressed,
                        child: const Text('Ok'),
                      ),
                    ],
            ));
  }

  void hide(BuildContext context) {
    _isShowing ? _navigator.pop() : null;
  }
}
