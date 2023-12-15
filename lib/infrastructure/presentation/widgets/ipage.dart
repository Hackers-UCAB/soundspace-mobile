import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/connectivity/connectivity_bloc.dart';

abstract class IPage extends StatelessWidget {
  const IPage({super.key});

  Widget child(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _GradientBackground(),
        BlocListener<ConnectivityBloc, ConnectivityState>(
          listener: (context, state) {
            if (state is NotConnectedState || state.willNeedReconnection) {
              //TODO: poner esto como un showDialog bonito en un widget privado or something
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: state is NotConnectedState
                      ? const Text('No internet connection')
                      : const Text('Reconnecting...'),
                  backgroundColor:
                      state is NotConnectedState ? Colors.red : Colors.green,
                ),
              );
            }
          },
          child: BlocBuilder<ConnectivityBloc, ConnectivityState>(
            builder: (context, state) {
              if (state is ConnectivityInitialState) {
                GetIt.instance
                    .get<ConnectivityBloc>()
                    .add(ConnectivityInitialCheckRequested());
              }
              return child(context);
            },
          ),
        ),
      ]),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color.fromARGB(255, 52, 13, 131),
            Color.fromARGB(255, 30, 8, 58),
            Color.fromARGB(255, 24, 18, 31),
            Color.fromARGB(255, 30, 8, 58),
            Color.fromARGB(255, 57, 13, 145),
          ],
        ),
      ),
    );
  }
}
