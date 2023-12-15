import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/services/internet_connection/connection_manager.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final IConnectionManager connectionManager;
  ConnectivityBloc({required this.connectionManager})
      : super(const ConnectivityInitialState()) {
    on<ConnectivityInitialCheckRequested>(_checkInitialConnection);
    on<ConnectivityCheckRequested>(_checkConnection);
  }

  Future<void> _checkConnection(
      ConnectivityCheckRequested event, Emitter<ConnectivityState> emit) async {
    final subscriptionSteam = connectionManager.checkConnectionStream();
    await for (final isConnected in subscriptionSteam) {
      isConnected
          ? emit(
              ConnectedState(willNeedReconnection: state.willNeedReconnection))
          : emit(const NotConnectedState());
    }
  }

  Future<void> _checkInitialConnection(ConnectivityInitialCheckRequested event,
      Emitter<ConnectivityState> emit) async {
    final bool isConnected = await connectionManager.checkInitialConnection();
    isConnected
        ? emit(ConnectedState(willNeedReconnection: state.willNeedReconnection))
        : emit(const NotConnectedState());

    add(ConnectivityCheckRequested());
  }
}
