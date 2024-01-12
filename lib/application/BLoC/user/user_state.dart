part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final bool editable;
  final Map<String, String> editData;

  const UserState({required this.editable, this.editData = const {}});

  @override
  List<Object> get props => [editable, editData];
}

class UserProfileLoadingState extends UserState {
  const UserProfileLoadingState(
      {required super.editData, required super.editable});
}

class UserProfileLoadedState extends UserState {
  final User user;
  const UserProfileLoadedState(
      {required super.editable, required this.user, required super.editData});
}

class UserProfileFaiLureState extends UserState {
  final Failure failure;

  const UserProfileFaiLureState(
      {super.editable = false, required this.failure});
}
