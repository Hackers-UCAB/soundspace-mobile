import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_choice_chips.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_textfield.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:sign_in_bloc/infrastructure/presentation/widgets/error_page.dart';
import '../../../../domain/services/search_entities_by_name.dart';
import '../../widgets/ipage.dart';
import 'widgets/search_list.dart';

class SearchPage extends IPage {
  final getIt = GetIt.instance;
  late final SearchBloc searchBloc;
  SearchPage({super.key}) {
    searchBloc =
        SearchBloc(searchEntitiesByName: getIt.get<SearchEntitiesByName>());
  }

  @override
  Future<void> onRefresh() async {
    searchBloc.add(FetchSearchedData(
        page: 0, scrollPosition: searchBloc.state.scrollPosition));
  }

  @override
  Widget child(BuildContext context) {
    return BlocProvider(
      create: (context) => searchBloc,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, searchState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  onChanged: searchBloc.onChangeData,
                ),
                const SizedBox(height: 10),
                CustomChoiceChips(searchBloc: searchBloc),
                const SizedBox(height: 10),
                if (searchState is SearchLoading)
                  const CustomCircularProgressIndicator(),
                if (searchState.searchList.isNotEmpty)
                  SearchList(
                      items: searchState.searchList, searchBloc: searchBloc),
                if (searchState.searchList.isEmpty && searchState.lastPage)
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
      ),
    );
  }
}
