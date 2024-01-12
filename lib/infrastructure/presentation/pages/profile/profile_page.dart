import 'package:flutter/material.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';

class ProfilePage extends IPage {
  ProfilePage({super.key});

  @override
  Widget child(BuildContext context) {
    return const Placeholder();
  }

  @override
  Future<void> onRefresh() {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }
}
