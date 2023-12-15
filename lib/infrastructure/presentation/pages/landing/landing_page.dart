import 'package:flutter/material.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';

class LandingPage extends IPage {
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
