import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../config/router/app_router.dart';

class SearchList extends StatelessWidget {
  final List<Map<String, String>> searchData;
  const SearchList({super.key, required this.searchData});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();
    // TODO: implement build
    return const Placeholder();
  }
}
