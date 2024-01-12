import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/user/get_user_profile_data_use_case.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/profile/widgets/email_text_form_field.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import '../../../../application/use_cases/user/cancel_user_subscription_use_case.dart';
import '../../../../application/use_cases/user/save_user_profile_data_use_case.dart';
import 'widgets/name_text_form_field.dart';

final _formKey = GlobalKey<FormState>();

class ProfilePage extends IPage {
  final GetIt getIt = GetIt.instance;
  late final UserBloc userBloc;
  ProfilePage({super.key}) {
    userBloc = UserBloc(
        fetchUserProfileDataUseCase: getIt.get<FetchUserProfileDataUseCase>(),
        saveUserProfileDataUseCase: getIt.get<SaveUserProfileDataUseCase>(),
        cancelSubscriptionUseCase: getIt.get<CancelSubscriptionUseCase>())
      ..add(FetchUserProfileDataEvent());
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) => userBloc,
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
  Future<void> onRefresh() {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }
}

class ProfileForm extends StatelessWidget {
  final UserProfileLoadedState state;
  final UserBloc userBloc;
  final List<String> genderOptions = ['', 'M', 'F', 'O'];
  ProfileForm({required this.state, required this.userBloc, super.key});

  @override
  Widget build(BuildContext context) {
    String selectedOption = state.user.genre ?? genderOptions[0];
    return Form(
        key: _formKey,
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
                    fontSize: 20,
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
            const SizedBox(height: 30),

            //Nombre y apellido
            NameTextFormField(
              state: state,
              userBloc: userBloc,
            ),

            const SizedBox(height: 30),

            // CORREO
            EmailTextFormField(state: state, userBloc: userBloc),

            const SizedBox(height: 30),
//TODO: Hacer un Textfield customizado porque repites el del estilo de los border, fill, fillColor, etc - Jorge
            Row(
              children: [
                Flexible(
                  flex: 2,
                  //TODO: Separar en otro widget - Jorge
                  // FECHA DE NACIMIENTO
                  child: TextFormField(
                    enabled: state.editable,
                    controller: TextEditingController(
                        text: state.user.birthdate == null
                            ? null
                            : DateFormat('dd/MM/yyyy')
                                .format(state.user.birthdate!)),
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          userBloc.add(
                              FechaEditedEvent(user: state.user, fecha: value));
                        }
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      hintStyle: TextStyle(color: Color.fromARGB(146, 0, 0, 0)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(0, 85, 51, 51)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 2, color: Colors.white),
                      ),
                      fillColor: Color.fromARGB(82, 129, 118, 160),
                      filled: true,
                      labelText: 'Fecha de Nacimiento',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                //TODO: Separar en otro widget - Jorge
                Flexible(
                  flex: 1,
                  child: DropdownMenu<String>(
                    label: const Text(
                      "Género",
                      style: TextStyle(color: Colors.white),
                    ),
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(width: 1, color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                            width: 1, color: Color.fromARGB(0, 85, 51, 51)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(width: 2, color: Colors.white),
                      ),
                      fillColor: Color.fromARGB(82, 129, 118, 160),
                      filled: true,
                    ),
                    enabled: state.editable,
                    enableSearch: false,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                    menuStyle: const MenuStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 129, 118, 160),
                      ),
                    ),
                    initialSelection: state.user.genre,
                    onSelected: (String? newValue) {
                      if (newValue != null) {
                        selectedOption = newValue;
                        userBloc.add(GenreEditedEvent(
                            user: state.user, genre: selectedOption));
                      }
                    },
                    dropdownMenuEntries: genderOptions
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                          value: value, label: value);
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),

            const SizedBox(height: 30),
            //TODO: Separar en otro widget. Intentar tomar los de oriana que estan customizados - Jorge
            Row(
              children: [
                Expanded(
                    child: Visibility(
                        visible: state.editable,
                        child: ElevatedButton(
                          onPressed: () {
                            userBloc.add(SubmitChangesEvent(user: state.user));
                          },
                          style: const ButtonStyle(
                            minimumSize:
                                MaterialStatePropertyAll<Size>(Size(1, 50)),
                            shape: MaterialStatePropertyAll<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)))),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 7, 212, 239)),
                            foregroundColor:
                                MaterialStatePropertyAll<Color>(Colors.white),
                          ),
                          child: const Text(
                            'Guardar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ))),
              ],
            ),
            const SizedBox(height: 80),
            //TODO: Separar en otro widget. Intentar resumirlo de alguna forma - Jorge
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Si deseas cancelar tu suscripción',
                style: TextStyle(color: Colors.white, fontSize: 14),
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
                  style: TextStyle(color: Colors.lightBlue, fontSize: 14),
                ),
              ),
            ),
          ],
        ));
  }
}
