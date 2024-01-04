import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_choice_chips.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_textfield.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import '../../widgets/ipage.dart';
import 'widgets/search_list.dart';

class SearchPage extends IPage {
  final getIt = GetIt.instance;
  late final SearchBloc searchBloc = getIt.get<SearchBloc>();
  SearchPage({super.key});

  @override
  Future<void> onRefresh() async {
    searchBloc.add(FetchSearchedData(page: 1));
  }

  @override
  Widget child(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, playerState) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (context, searchState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    hint: "",
                    onChanged: searchBloc.onChangeData,
                  ),
                  const SizedBox(height: 10),
                  CustomChoiceChips(),
                  const SizedBox(height: 10),
                  if (searchState is SearchLoading)
                    const CustomCircularProgressIndicator(),
                  if (searchState is SearchLoaded)
                    SearchList(items: searchState.searchList),
                  if (searchState is SearchLoaded &&
                      searchState.searchList.isEmpty)
                    Center(
                      child: Text(
                        "Lo sentimos, no encontramos resultados que coincidan",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.blue),
                      ),
                    ),
                  if (searchState is SearchFailed)
                    ErrorPage(failure: searchState.failure),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
