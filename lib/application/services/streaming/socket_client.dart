import 'package:sign_in_bloc/application/BLoC/socket/socket_bloc.dart';

abstract class SocketClient {
  void inicializeSocket();
  void sendIdSong(String sondId, int second);
  void receiveChunk(SocketBloc socketBloc);
  void receiveInfo(SocketBloc socketBloc);
}
