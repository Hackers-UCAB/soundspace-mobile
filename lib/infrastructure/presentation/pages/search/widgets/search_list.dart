import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import '../../../../../application/BLoC/socket/socket_bloc.dart';
import '../../../config/router/app_router.dart';

class SearchList extends StatelessWidget {
  final List<Map<String, String>> items;
  final _scrollController = ScrollController();

  SearchList({super.key, required this.items});

  ScrollController _getScrollController(BuildContext context, SearchBloc bloc) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final page = bloc.state.page + 1;
        bloc.add(FetchSearchedData(page: page));
      }
    });
    return _scrollController;
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();
    final socketBloc = getIt.get<SocketBloc>();
    final searchBloc = getIt.get<SearchBloc>();

    final List<_SearchListItem> searchList = items
        .map<_SearchListItem>(
          (item) => _SearchListItem(
            onTap: item['filter'] == 'song'
                ? () => socketBloc.add(SocketSendIdSong(item['id']!))
                : () =>
                    appNavigator.navigateTo('/${item['filter']}/${item['id']}'),
            name: item['name']!,
            filter: item['filter']!,
          ),
        )
        .toList();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
          controller: _getScrollController(context, searchBloc),
          itemCount: items.length,
          itemBuilder: (context, index) {
            if (index < searchList.length) {
              return searchList[index];
            }
            Future.delayed(const Duration(milliseconds: 30));
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class _SearchListItem extends StatelessWidget {
  final String name;
  final String filter;
  final Function() onTap;
  const _SearchListItem(
      {required this.name, required this.onTap, required this.filter});

  Widget get icon {
    switch (filter) {
      case 'song':
        return const Icon(Icons.music_note, size: 15);
      case 'artist':
        return const Icon(Icons.person, size: 15);
      case 'album':
        return const Icon(Icons.album);
      case 'playlist':
        return const Icon(Icons.playlist_play, size: 15);
      default:
        return const Icon(Icons.error, size: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListTile(
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        subtitle: Row(
          children: [
            icon,
            Text(
              filter,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 15),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
