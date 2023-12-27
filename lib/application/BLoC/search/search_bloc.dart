import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../common/failure.dart';
import '../../../common/result.dart';
import '../../../domain/album/album.dart';
import '../../../domain/artist/artist.dart';
import '../../../domain/playlist/playlist.dart';
import '../../use_cases/album/get_album_by_name_use_case.dart';
import '../../use_cases/artist/get_artist_by_name_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetArtistByNameUseCase getArtistByNameUseCase;
  final GetAlbumByNameUseCase getAlbumByNameUseCase;
  //TODO: UseCase de Playlist

  SearchBloc({
    required this.getArtistByNameUseCase,
    required this.getAlbumByNameUseCase,
  }) : super(const SearchInitial()) {
    on<SearchFilterChanged>(_searchFilterChanged);
    on<SearchDataChanged>(_searchDataChanged);
    on<FetchSearchedData>(_fetchSearchedData);
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
    //siempre y cuando el filtro y la hayan sido seleccionados
    if (state.filter.isNotEmpty && state.data.isNotEmpty) {
      emit(SearchLoading(filter: state.filter, data: state.data));

      //TODO: Dependiendo del filtro ejecutar un useCase u otro y retornar la lista tipo Map<String,String>

      // emit(SearchLoaded(
      //       filter: state.filter, data: state.data, searchData: searchData));
      // } else {
      //   emit(SearchFailed(
      //       filter: state.filter, data: state.data, failure: result.failure!));
      // }
    }
  }

  //La funcion onChange que recibe el TextField
  void onChangeData(String value) {
    //TODO: Hacer lo del timer,  si se cumple, emitimos el evento
    add(SearchDataChanged(data: value));
  }

  // List<Map<String, String>> mapToMapList<T>(List<T> list) {
  //   return list.map<Map<String, String>>((item) {
  //     if (item is Artist) {
  //       return {
  //         'id': item.id,
  //         'name': item.name,
  //       };
  //     } else if (item is Album) {
  //       return {
  //         'id': item.id,
  //         'name': item.name,
  //       };
  //     } else if (item is Playlist) {
  //       return {
  //         'id': item.id,
  //         'name': item.name,
  //       };
  //     }
  //   }).toList();
  // }
}
