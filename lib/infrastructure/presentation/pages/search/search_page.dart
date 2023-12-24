/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_app_bar.dart';
import 'package:sign_in_bloc/infrastructure/presentation/pages/search/widgets/custom_textfield.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/router/app_router.dart';
import 'package:sign_in_bloc/infrastructure/presentation/shared_widgets/ipage.dart';

class SearchPage extends IPage {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget child(BuildContext context) {
    final getIt = GetIt.instance;
    final SearchBloc searchBloc = getIt.get<SearchBloc>();
    final AppNavigator appNavigator = getIt.get<AppNavigator>();
    return BlocBuilder<SearchBloc, SearchState>(
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
      builder: (context, SearchState){
            Padding(
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
                    CustomTextFormField(
                      hint: "",
                    ),
                  ],
                ),
            );
      },
    );
  }
}*/
