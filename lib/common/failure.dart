abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NoSessionFailure extends Failure {
  const NoSessionFailure({String message = 'No existe una sesión iniciada'})
      : super(message);
}

//TODO: Todos podrian tener tambien el codigo http de falla
//TODO: Estos mensajes creo que los podemos tomar de la respuesta del back

class ServerFailure extends Failure {
  const ServerFailure(
      {String message =
          'Estamos experimentando ciertos problemas. Inténtalo de nuevo más tarde'})
      : super(message);
}

class NoAuthorizeFailure extends Failure {
  const NoAuthorizeFailure({String message = 'No autorizado'}) : super(message);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({String message = 'No conexion a internet'})
      : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure({required String message}) : super(message);
}
