import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/services/search_entities_by_name.dart';
import '../../../common/failure.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchEntitiesByName _searchEntitiesByName;
  Timer? _debounce;

  SearchBloc({required SearchEntitiesByName searchEntitiesByName})
      : _searchEntitiesByName = searchEntitiesByName,
        super(const SearchInitial(filter: [], data: '', searchList: [])) {
    on<SearchFilterChanged>(_searchFilterChanged);
    on<SearchDataChanged>(_searchDataChanged);
    on<FetchSearchedData>(_fetchSearchedData);
  }

  //cada vez que cambia la seleccion del CustomChoiceChip
  Future<void> _searchFilterChanged(
      SearchFilterChanged event, Emitter<SearchState> emit) async {
    List<String> filter = [];

    state.filter.contains(event.filter)
        ? filter =
            state.filter.where((element) => element != event.filter).toList()
        : filter = state.filter + [event.filter];

    emit(state.copyWith(filter: filter, searchList: List.empty()));
    add(FetchSearchedData(page: 1));
  }

  //cada vez que cambia el Texfield
  Future<void> _searchDataChanged(
      SearchDataChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(data: event.data, searchList: List.empty()));
    add(FetchSearchedData(page: 1));
  }

  Future<void> _fetchSearchedData(
      FetchSearchedData event, Emitter<SearchState> emit) async {
    if (state.data.isNotEmpty) {
      emit(SearchLoading(
          filter: state.filter,
          data: state.data,
          searchList: state.searchList,
          page: event.page));
      final result = await _searchEntitiesByName.call(state.data,
          state.filter.map<String>((string) => string.toLowerCase()).toList());

      if (result.hasValue()) {
        List<Map<String, String>> items = [];
        for (var entity in result.value!.entitiesMap.entries) {
          if (entity.value.isNotEmpty) {
            items += entity.value
                .map<Map<String, String>>((e) => {
                      'filter': entity.key,
                      'id': e.id,
                      'name': e.name,
                    })
                .toList();
          }
        }
        items = state.searchList + items;
        emit(SearchLoaded(
            filter: state.filter,
            data: state.data,
            searchList: items,
            page: event.page));
      } else {
        emit(SearchFailed(
            filter: state.filter,
            data: state.data,
            failure: result.failure!,
            searchList: state.searchList,
            page: event.page));
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
}
