import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';
import '../../../../../application/BLoC/socket/socket_bloc.dart';
import '../../../config/router/app_router.dart';

class SearchList extends StatefulWidget {
  final List<Map<String, String>> items;

  const SearchList({super.key, required this.items});

  @override
  SearchListState createState() => SearchListState();
}

class SearchListState extends State<SearchList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchBloc = GetIt.instance.get<SearchBloc>();
      if (searchBloc.state.page > 0) {
        _scrollToIndex(searchBloc.state.scrollPosition);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    final position = index * 18 * 65.0;
    _scrollController.animateTo(position,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();
    final socketBloc = getIt.get<SocketBloc>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            final searchBloc = getIt.get<SearchBloc>();
            final page = searchBloc.state.page + 1;
            searchBloc.add(FetchSearchedData(page: page, scrollPosition: page));
          }
          return true;
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return _SearchListItem(
              name: widget.items[index]['name']!,
              onTap: widget.items[index]['filter'] == 'song'
                  ? () => socketBloc.add(SendIdSong(
                      widget.items[index]['id']!, 0)) //TODO: Javi revisa esto
                  : () => appNavigator.navigateTo(
                      '/${widget.items[index]['filter']}/${widget.items[index]['id']}'),
              filter: widget.items[index]['filter']!,
            );
          },
          physics: const BouncingScrollPhysics(),
        ),
      ),
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
