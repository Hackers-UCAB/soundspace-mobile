import 'package:flutter/material.dart';
import 'package:sign_in_bloc/common/failure.dart';

class ErrorPage extends StatelessWidget {
  final Failure failure;
  //TODO: Cambiar el nombre de esta clase
  const ErrorPage({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Oops! ${failure.message}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
