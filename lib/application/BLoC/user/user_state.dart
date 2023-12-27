part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserProfileLoaded extends UserState {
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
}
