import 'package:flutter/material.dart';
import 'package:sign_in_bloc/common/failure.dart';

import '../../datasources/local/local_storage.dart';
import '../../../common/result.dart';
import '../../../domain/user/repository/user_repository.dart';
import '../../../domain/user/user.dart';

class FetchUserProfileDataUseCase {
  final UserRepository userRepository;
  final LocalStorage localStorage;

  FetchUserProfileDataUseCase(
      {required this.userRepository, required this.localStorage});

  Future<Result<User>> execute() async {
    return Result<User>(failure: const UnknownFailure(message: 'No token'));
    /*
    final result = await userRepository.fetchUserProfileData();
    print("usecase: " +
        result.toString() +
        " ' " +
        result.value.toString() +
        " end of usecase");
    if (result.hasValue()) {
      return result;
    } else {
      return Result<User>(
          failure: const UnknownFailure(
              message:
                  'No token')); //TODO: Personalizar este error en base al Failure que retorne getToken?
    }
  */
  }
}
