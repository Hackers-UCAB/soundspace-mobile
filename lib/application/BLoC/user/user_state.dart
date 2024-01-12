part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool editable;
  final User user;
  final String name;
  final String email;
  final String fecha;
  final String gender;

  const UserState(
      {this.editable = false,
      this.user = const User(),
      this.name = '',
      this.email = '',
      this.fecha = '',
      this.gender = ''});

  UserState copyWith({
    bool? editable,
    User? user,
    String? name,
    String? email,
    String? fecha,
    String? gender,
  }) =>
      UserState(
        editable: editable ?? this.editable,
        user: user ?? this.user,
        name: name ?? this.name,
        email: email ?? this.email,
        fecha: fecha ?? this.fecha,
        gender: gender ?? this.gender,
      );

  @override
  List<Object> get props => [editable, user, name, email, fecha, gender];
}
