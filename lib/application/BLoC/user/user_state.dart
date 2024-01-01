part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool editable;
  final User user;

  const UserState({this.editable = false, this.user = const User()});

  UserState copyWith({
    bool? editable,
    User? user,
  }) =>
      UserState(
        editable: editable ?? this.editable,
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [user];
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
