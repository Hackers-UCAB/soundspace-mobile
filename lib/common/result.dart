class Result<T> {
  late final T? value;
  late final Error? error;

  Result({T? value, Error? error}) {
    if (value == null && error != null) {
      this.error = error;
      this.value = null;
    } else if (value != null && error == null) {
      this.value = value;
      this.error = null;
    } else {
      throw ArgumentError(
          'Result cannot have a null value and a null error at the same time');
    }
  }

  bool hasValue() => this.value != null;

  String get messageError => this.error.toString();
}
