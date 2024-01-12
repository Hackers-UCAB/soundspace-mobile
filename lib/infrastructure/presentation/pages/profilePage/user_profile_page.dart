import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/use_cases/user/save_user_profile_data_use_case.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/birth_day_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/email_address_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/gender_value_object.dart';
import 'package:sign_in_bloc/domain/user/valueObjects/name_value_object.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/music_player.dart';
import '../../../../domain/user/user.dart';

final _formKey = GlobalKey<FormState>();

class UserProfilePage extends IPage {
  const UserProfilePage({super.key});

  @override
  Widget child(BuildContext context) {
    /*final userBloc = GetIt.instance.get<UserBloc>();
    userBloc.add(FetchUserProfileDataEvent());*/

    return BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, playerState) {
      return BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        return SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ProfileForm(userState, context),
                      ]),
                )));
      });
    });
  }
}

class ProfileForm extends StatelessWidget {
  final BuildContext context;
  final UserState state;
  final userBloc = GetIt.instance.get<UserBloc>();
  final List<String> genderOptions = ['', 'M', 'F', 'O'];
  ProfileForm(this.state, this.context);

  @override
  Widget build(BuildContext context) {
    userBloc.add(FetchUserProfileDataEvent());
    String selectedOption = state.gender ?? genderOptions[0];
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: Colors.white,
                iconSize: 25,
                onPressed: () {
                  print("current page data: ");
                  print("name: " + state.name);
                  print("email: " + state.email);
                  print("date: " + state.fecha);
                  print("gender: " + state.gender);
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
            const SizedBox(height: 30),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
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
                        userBloc.add(ToggleProfileEditableEvent());
                      },
                      icon: const Icon(Icons.edit_sharp),
                    ),
                  )
                ]),
            const SizedBox(height: 30),

            //Nombre y apellido
            TextFormField(
              enabled: context.watch<UserBloc>().state.editable,
              initialValue: state.name,
              onChanged: (value) => userBloc.add(NameEditedEvent(name: value)),
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: 'Carlos Alonso',
                  hintStyle: TextStyle(color: Color.fromARGB(146, 0, 0, 0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(0, 85, 51, 51))),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(width: 2, color: Colors.white)),
                  fillColor: Color.fromARGB(82, 129, 118, 160),
                  filled: true,
                  labelText: 'Nombre y Apellido',
                  labelStyle: TextStyle(color: Colors.white)),
            ),

            const SizedBox(height: 30),

            // CORREO
            TextFormField(
              enabled: state.editable,
              initialValue: state.email,
              onChanged: (value) =>
                  userBloc.add(EmailEditedEvent(email: value)),
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  hintText: 'CarlosAlonso@CarlosAlonso.Com',
                  hintStyle: TextStyle(color: Color.fromARGB(146, 0, 0, 0)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide:
                          BorderSide(width: 1, color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(0, 85, 51, 51))),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(width: 2, color: Colors.white)),
                  fillColor: Color.fromARGB(82, 129, 118, 160),
                  filled: true,
                  labelText: 'Correo Electrónico',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  // FECHA DE NACIMIENTO
                  child: TextFormField(
                    enabled: state.editable,
                    controller: TextEditingController(
                        text: state.fecha.toString() ?? ''),
                    readOnly: true,
                    onTap: () {
                      print(state.fecha);
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          userBloc
                              .add(FechaEditedEvent(fecha: value.toString()));
                        }
                      });
                      print(state.fecha);
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
                    initialSelection: state.gender,
                    onSelected: (String? newValue) {
                      if (newValue != null) {
                        selectedOption = newValue;
                        userBloc.add(GenderEditedEvent(gender: selectedOption));
                        // Update the selected option
                        print('Selected option: $selectedOption');
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
            Row(
              children: [
                Expanded(
                    child: Visibility(
                        visible: state.editable,
                        child: ElevatedButton(
                          onPressed: () {
                            userBloc.add(ToggleProfileEditableEvent());
                            userBloc.add(SubmitChangesEvent(
                                user: User(
                                    id: state.user.id,
                                    name: UserName(state.name),
                                    email: EmailAddress(state.email),
                                    phone: state.user.phone,
                                    role: state.user.role,
                                    birthdate:
                                        BirthDate(DateTime.parse(state.fecha)),
                                    gender: Gender(state.gender),
                                    appToken: state.user.appToken,
                                    notificationsToken:
                                        state.user.notificationsToken)));
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
                /**/
              ],
            ),
            const SizedBox(height: 80),
            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: !context.watch<UserBloc>().state.editable,
                child: const Text(
                  'Si deseas cancelar tu suscripción',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),

            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: !context.watch<UserBloc>().state.editable,
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
