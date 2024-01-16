import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/search/search_bloc.dart';

import '../../../config/router/app_router.dart';

class SearchList extends StatefulWidget {
  final List<Map<String, String>> items;
  final SearchBloc searchBloc;

  const SearchList({super.key, required this.items, required this.searchBloc});

  @override
  SearchListState createState() => SearchListState();
}

class SearchListState extends State<SearchList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.searchBloc.state.page > 0) {
        _scrollToIndex(widget.searchBloc.state.scrollPosition);
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
    final playerBloc = getIt.get<PlayerBloc>();

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            final page = widget.searchBloc.state.page + 1;
            widget.searchBloc
                .add(FetchSearchedData(page: page, scrollPosition: page));
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
                  ? () => playerBloc.add(InitStream(
                      widget.items[index]['id']!,
                      0,
                      widget.items[index]['name']!,
                      Duration(
                          minutes: int.parse(
                              widget.items[index]['duration']!.split(':')[0]),
                          seconds: int.parse(widget.items[index]['duration']!
                              .split(':')[1])))) //TODO: Javi revisa esto
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
      case 'playlist':
        return const Icon(Icons.playlist_play, size: 15);
      default:
        return const Icon(Icons.album);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: ListTile(
        title: SizedBox(
          height: 30,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        subtitle: Row(
          children: [
            icon,
            const SizedBox(width: 3),
            Text(
              filter,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
