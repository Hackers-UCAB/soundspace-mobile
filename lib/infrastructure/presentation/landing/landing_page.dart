import 'package:flutter/material.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/background.dart';

class LandingPage extends Background {
  const LandingPage({super.key});

  @override
  Widget child(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}
