import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_app_bar.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_choice_chips.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_textfield.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import '../../widgets/ipage.dart';
import 'widgets/search_list.dart';

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
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBar(
                          title: "Buscar artista o tema",
                          onPressed: () => appNavigator.pop(),
                        ),
                        const SizedBox(height: 10),
                        CustomTextFormField(
                          hint: "",
                          onChanged: searchBloc.onChangeData,
                        ),
                        CustomChoiceChips(),
                        if (searchState is SearchInitial)
                          const Text('Selecciona un filtro de busqueda'),
                        if (searchState is SearchLoading)
                          const CustomCircularProgressIndicator(),
                        if (searchState is SearchLoaded)
                          //TODO: Implementar el widget de la lista
                          SearchList(searchData: searchState.searchData),
                        //TODO: Falta el estado de cuando no tenga data la busqueda
                        if (searchState is SearchFailed)
                          ErrorPage(failure: searchState.failure),
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
