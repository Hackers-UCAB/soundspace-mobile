import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sign_in_bloc/application/BLoC/user/user_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/ipage.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/music_player.dart';
import '../../../../domain/user/user.dart';

final _formKey = GlobalKey<FormState>();

const List<String> generosList = <String>[
  'Masculino',
  'Femenino',
  'Fluido',
  'Sin especificar'
];

class UserProfilePage extends IPage {
  const UserProfilePage({super.key});

  @override
  Widget child(BuildContext context) {
    final userBloc = GetIt.instance.get<UserBloc>();
    userBloc.add(FetchUserProfileDataEvent());
    User user = userBloc.state.user;
    return BlocBuilder<PlayerBloc, PlayerState>(
        builder: (context, playerState) {
      return BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
        return const SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ProfileForm(),
                      ]),
                )));
      });
    });
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  TextEditingController dateCtl = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  bool editProfileData = false;
  String dropDownValue = generosList.first;

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          dateCtl.text = formatter.format(value).toString();
        });
      }
    });
  }

  void _changeEditState() {
    setState(() {
      editProfileData = !editProfileData;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  setState(() {});
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
                    visible: !editProfileData,
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 20,
                      onPressed: _changeEditState,
                      icon: const Icon(Icons.edit_sharp),
                    ),
                  )
                ]),
            const SizedBox(height: 30),

            //Nombre y apellido
            TextFormField(
              enabled: editProfileData,
              initialValue: context.watch<UserBloc>().state.user.name?.name,
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
              enabled: editProfileData,
              initialValue: context.watch<UserBloc>().state.user.email?.email,
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
                Expanded(
                  flex: 1,
                  //FECHA DE NACIMIENTO
                  child: TextFormField(
                    //controller: dateCtl,
                    initialValue: context
                        .watch<UserBloc>()
                        .state
                        .user
                        .birthdate
                        ?.date
                        .toString(),
                    enabled: editProfileData,
                    readOnly: true,
                    onTap: _showDatePicker,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: 'DD/MM/YYYY',
                        hintStyle:
                            TextStyle(color: Color.fromARGB(146, 0, 0, 0)),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(0, 85, 51, 51))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        fillColor: Color.fromARGB(82, 129, 118, 160),
                        filled: true,
                        labelText: 'Fecha de Nacimiento',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),

                //DROPDOWN
                Expanded(
                    flex: 1,
                    child: DropdownMenu<String>(
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 1, color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(0, 85, 51, 51))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        fillColor: Color.fromARGB(82, 129, 118, 160),
                        filled: true,
                      ),
                      enabled: editProfileData,
                      enableSearch: false,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 15),
                      menuStyle: const MenuStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromARGB(255, 129, 118, 160)),
                      ),
                      initialSelection:
                          context.watch<UserBloc>().state.user.gender?.gender,
                      onSelected: (String? value) {
                        setState(() {
                          dropDownValue = value!;
                        });
                      },
                      dropdownMenuEntries: generosList
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    )),
                const SizedBox(width: 25),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                    child: Visibility(
                        visible: editProfileData,
                        child: ElevatedButton(
                          onPressed: _changeEditState,
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
                visible: !editProfileData,
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
                visible: !editProfileData,
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
