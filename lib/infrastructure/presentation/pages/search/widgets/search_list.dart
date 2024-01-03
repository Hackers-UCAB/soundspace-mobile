import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/domain/services/search_entities_by_name.dart';

import '../../../../../application/BLoC/socket/socket_bloc.dart';
import '../../../config/router/app_router.dart';

class SearchList extends StatelessWidget {
  final EntitiesByName entities;
  late final List<Map<String, String>> items;
  final _scrollController = ScrollController();
  // late final Map<String, List<dynamic>> entitiesMap;

  SearchList({super.key, required this.entities}) {
    final Map<String, List<dynamic>> entitiesMap = {
      'albums': entities.albums ?? [],
      'artist': entities.artists ?? [],
      'playlist': entities.playlists ?? [],
      'song': entities.songs ?? [],
    };

    items = entitiesMap.keys
        .expand<Map<String, String>>((key) => entitiesMap[key]!
            .map<Map<String, String>>((entity) => {
                  'filter': key,
                  'id': entity.id,
                  'name': entity.name,
                })
            .toList())
        .toList()
        .cast<Map<String, String>>();
  }

  ScrollController _getScrollController(BuildContext context) {
  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
          
    }
  });
  return _scrollController;
}





  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();
    final socketBloc = getIt.get<SocketBloc>();

    final List<_SearchListItem> searchList = items
        .map<_SearchListItem>(
          (item) => _SearchListItem(
            onTap: item['filter'] == 'song'
                ? () => socketBloc.add(SocketSendIdSong(item['id']!))
                : () =>
                    appNavigator.navigateTo('/${item['filter']}/${item['id']}'),
            name: item['name']!,
          ),
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
          controller: ,
          itemCount: items.length,
          itemBuilder: (context, index) => searchList[index]),
    );
  }
}

class _SearchListItem extends StatelessWidget {
  final String name;
  final Function() onTap;
  const _SearchListItem({required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
