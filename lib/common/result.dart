import 'package:sign_in_bloc/common/failure.dart';

class Result<T> {
  late final T? value;
  late final Failure? failure;

  Result({T? value, Failure? failure}) {
    if (value == null && failure != null) {
      this.failure = failure;
      this.value = null;
    } else if (value != null && failure == null) {
      this.value = value;
      this.failure = null;
    } else {
      throw ArgumentError(
          'Result cannot have a null value and a null failure at the same time');
    }
  }

  bool hasValue() => this.value != null;
}
