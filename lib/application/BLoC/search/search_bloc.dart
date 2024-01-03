import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/services/search_entities_by_name.dart';
import '../../../common/failure.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchEntitiesByName _searchEntitiesByName;
  int _currentPage = 1;
  Timer? _debounce;

  SearchBloc({required SearchEntitiesByName searchEntitiesByName})
      : _searchEntitiesByName = searchEntitiesByName,
        super(const SearchInitial(filter: [], data: '')) {
    on<SearchFilterChanged>(_searchFilterChanged);
    on<SearchDataChanged>(_searchDataChanged);
    on<FetchSearchedData>(_fetchSearchedData);
    on<FetchMoreSearchedData>(_fetchMoreSearchedData);
  }

  //cada vez que cambia la seleccion del CustomChoiceChip
  Future<void> _searchFilterChanged(
      SearchFilterChanged event, Emitter<SearchState> emit) async {
    List<String> filter = [];

    state.filter.contains(event.filter)
        ? filter =
            state.filter.where((element) => element != event.filter).toList()
        : filter = state.filter + [event.filter];

    emit(state.copyWith(filter: filter));
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
    if (state.data.isNotEmpty) {
      emit(SearchLoading(filter: state.filter, data: state.data));
      final result = await _searchEntitiesByName.call(state.data, state.filter);

      if (result.hasValue()) {
        final entities = result.value!;
        if (entities.albums == null &&
            entities.artists == null &&
            entities.playlists == null &&
            entities.songs == null) {
          emit(SearchEmpty(filter: state.filter, data: state.data));
        } else {
          emit(SearchLoaded(
              filter: state.filter, data: state.data, entites: entities));
        }
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

  void _fetchMoreSearchedData(
      FetchMoreSearchedData event, Emitter<SearchState> emit) {
    _currentPage++;
    final startIndex = (_currentPage - 1) * 8;
    final endIndex = min(
      _currentPage * 8,
    );
    final itemsToShow = state.items.sublist(startIndex, endIndex);
  }
}
