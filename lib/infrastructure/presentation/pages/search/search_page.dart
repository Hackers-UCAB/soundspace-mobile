import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_app_bar.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_textfield.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';

import '../../widgets/ipage.dart';

class SearchPage extends IPage {
  const SearchPage({super.key});

  @override
  Widget child(BuildContext context) {
    final getIt = GetIt.instance;
    final SearchBloc searchBloc = getIt.get<SearchBloc>();
    final AppNavigator appNavigator = getIt.get<AppNavigator>();
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView(
        children: [
          BlocBuilder<PlayerBloc, PlayerState>(
            builder: (context, playerState) {
              return BlocBuilder<SearchBloc, SearchState>(
                builder: (context, searchState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          title: "Buscar artista o tema",
                          onPressed: () => appNavigator.pop(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomTextFormField(
                          hint: "",
                        ),
                        if (searchState is SearchInitialState)
                          const Text('Selecciona un filtro de busqueda'),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
