part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool editable;
  final User user;
  final DateTime fecha;

  const UserState(
      {this.editable = false, this.user = const User(), required this.fecha});

  UserState copyWith({
    bool? editable,
    User? user,
    DateTime? fecha,
  }) =>
      UserState(
        editable: editable ?? this.editable,
        user: user ?? this.user,
        fecha: fecha ?? this.fecha,
      );

  @override
  List<Object> get props => [editable, user, fecha];
}

/*class UserProfileLoaded extends UserState {
  final User user;

  const UserProfileLoaded({required this.user});

  UserProfileLoaded copyWith({
    User? user,
  }) =>
      UserProfileLoaded(
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [user];
}*/
