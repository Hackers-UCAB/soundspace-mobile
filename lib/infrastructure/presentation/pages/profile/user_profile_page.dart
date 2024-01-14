import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/user/get_user_profile_data_use_case.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/profile/widgets/date_picker_field.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/profile/widgets/gender_dropdown_field.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/profile/widgets/submit_button.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import '../../../../application/use_cases/user/cancel_user_subscription_use_case.dart';
import '../../../../application/use_cases/user/save_user_profile_data_use_case.dart';
import 'widgets/user_profile_form_text_field.dart';

final _formKey = GlobalKey<FormState>();

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

class ProfilePage extends IPage {
  final GetIt getIt = GetIt.instance;
  late final UserBloc userBloc;
  ProfilePage({super.key}) {
    userBloc = UserBloc(
        fetchUserProfileDataUseCase: getIt.get<FetchUserProfileDataUseCase>(),
        saveUserProfileDataUseCase: getIt.get<SaveUserProfileDataUseCase>(),
        cancelSubscriptionUseCase: getIt.get<CancelSubscriptionUseCase>());
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) {
        userBloc.add(FetchUserProfileDataEvent());
        return userBloc;
      },
      child: BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        if (userState is UserProfileLoadedState) {
          return SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ProfileForm(
                            state: userState,
                            userBloc: userBloc,
                          ),
                        ]),
                  )));
        } else if (userState is UserProfileFaiLureState) {
          return ErrorPage(
            failure: userState.failure,
          );
        } else {
          return const CustomCircularProgressIndicator();
        }
      }),
    );
  }

  @override
  Future<void> onRefresh() async {
    userBloc.add(FetchUserProfileDataEvent());
  }
}

class ProfileForm extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;
  ProfileForm({required this.state, required this.userBloc, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 30),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible: !state.editable,
                child: IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {
                    userBloc.add(ToggleProfileEditableEvent(user: state.user));
                  },
                  icon: const Icon(Icons.edit_sharp),
                ),
              )
            ]),
            const SizedBox(height: 20),

            //Nombre y apellido
            UserProfileFormTextField(
              state: state,
              userBloc: userBloc,
              labelText: 'Nombre y Apellido',
              initialValue: state.user.name,
              onChanged: (value) =>
                  userBloc.add(NameEditedEvent(user: state.user, name: value)),
            ),

            const SizedBox(height: 30),

            // CORREO
            UserProfileFormTextField(
              state: state,
              userBloc: userBloc,
              labelText: 'Email',
              initialValue: state.user.email,
              onChanged: (value) => userBloc
                  .add(EmailEditedEvent(user: state.user, email: value)),
              validator: validateEmail,
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                DatePickerField(state: state, userBloc: userBloc),
                const SizedBox(width: 10),
                GenderPickerField(state: state, userBloc: userBloc),
                const SizedBox(width: 10),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              children: [SubmitButton(state: state, userBloc: userBloc)],
            ),
            const SizedBox(height: 80),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Si deseas cancelar tu suscripción',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () =>
                    userBloc.add(CanceledSubscripcionEvent(user: state.user)),
                child: const Text(
                  'Haz Click Aquí',
                  style: TextStyle(color: Colors.lightBlue, fontSize: 16),
                ),
              ),
            ),
          ],
        ));
  }
}
