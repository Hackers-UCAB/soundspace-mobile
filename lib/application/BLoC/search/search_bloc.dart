import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/common/use_case.dart';
import 'package:sign_in_bloc/infrastructure/mappers/artist/artist_mapper.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
import '../../../domain/album/album.dart';
import '../../../domain/artist/artist.dart';
import '../../../domain/playlist/playlist.dart';
import '../../use_cases/album/get_album_by_name_use_case.dart';
import '../../use_cases/artist/get_artist_by_name_use_case.dart';
import '../../use_cases/playlist/get_playlist_by_name_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetArtistByNameUseCase getArtistByNameUseCase;
  final GetAlbumByNameUseCase getAlbumByNameUseCase;
  final GetPlaylistByNameUseCase getPlaylistByNameUseCase;
  late final List<Map<String, dynamic>> _useCases;
  Timer? _debounce;

  SearchBloc({
    required this.getArtistByNameUseCase,
    required this.getAlbumByNameUseCase,
    required this.getPlaylistByNameUseCase,
  }) : super(const SearchInitial()) {
    on<SearchFilterChanged>(_searchFilterChanged);
    on<SearchDataChanged>(_searchDataChanged);
    on<FetchSearchedData>(_fetchSearchedData);

    _useCases = <Map<String, dynamic>>[
      {
        'input': GetArtistByNameUseCaseInput(name: state.data),
        'useCase': getArtistByNameUseCase,
        'filter': 'Artist',
      },
      {
        'input': GetAlbumByNameUseCaseInput(name: state.data),
        'useCase': getAlbumByNameUseCase,
        'filter': 'Album',
      },
      {
        'input': GetAlbumByNameUseCaseInput(name: state.data),
        'useCase': getAlbumByNameUseCase,
        'filter': 'Playlist',
      },
    ];
  }

  //cada vez que cambia la seleccion del CustomChoiceChip
  Future<void> _searchFilterChanged(
      SearchFilterChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(filter: event.filter));
    add(FetchSearchedData());
  }

  //cada vez que cambia el Texfield
  Future<void> _searchDataChanged(
      SearchDataChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(data: event.data));
    add(FetchSearchedData());
  }

  Future<void> _fetchSearchedData<T>(
      FetchSearchedData event, Emitter<SearchState> emit) async {
    if (state.filter.isNotEmpty && state.data.isNotEmpty) {
      emit(SearchLoading(filter: state.filter, data: state.data));
      final useCase =
          _useCases.firstWhere((element) => element['filter'] == state.filter);

      final result = await useCase['useCase'].execute(useCase['input'])
          as Result<List<dynamic>>;

      if (result.hasValue()) {
        final data = result.value!;
        emit(SearchLoaded(
            filter: state.filter,
            data: state.data,
            searchData: _fromDynamicListToMap(data)));
      } else {
        emit(SearchFailed(
            filter: state.filter, data: state.data, failure: result.failure!));
      }
    }
  }

  //La funcion onChange que recibe el TextField
  void onChangeData(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 900), () {
      add(SearchDataChanged(data: value));
    });
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }

  //Esto es horrible pero bueno
  List<Map<String, String>> _fromDynamicListToMap(List<dynamic> list) {
    return list.map<Map<String, String>>((e) {
      if (e is Artist) {
        return {'id': e.id, 'name': e.name};
      } else if (e is Album) {
        return {'id': e.id, 'name': e.name!};
      } else if (e is Playlist) {
        return {'id': e.id, 'name': e.name!};
      } else {
        return {}; // return an empty map if e is not an Artist
      }
    }).toList();
  }
}
