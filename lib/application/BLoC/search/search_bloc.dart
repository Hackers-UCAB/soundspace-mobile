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
        super(const SearchInitial(
            filter: [], searchList: [], data: '', lastPage: false, page: 0)) {
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

    emit(state.copyWith(
        filter: filter, searchList: [], lastPage: false, page: 0));
    add(FetchSearchedData(page: 0, scrollPosition: 0));
  }

  Future<void> _searchDataChanged(
      SearchDataChanged event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
        data: event.data, searchList: [], lastPage: false, page: 0));
    add(FetchSearchedData(page: 0, scrollPosition: 0));
  }

  Future<void> _fetchSearchedData(
      FetchSearchedData event, Emitter<SearchState> emit) async {
    if (state is! SearchLoading) {
      if (state.data.isNotEmpty) {
        if (!state.lastPage) {
          emit(SearchLoading(
              filter: state.filter,
              searchList: state.searchList,
              data: state.data,
              page: state.page,
              lastPage: state.lastPage,
              scrollPosition: state.scrollPosition));

          List<Map<String, String>> items = [];
          int page = event.page;
          bool notEmpty = true;
          while (items.length < 15 && notEmpty) {
            final result = await _searchEntitiesByName.call(
                state.data,
                state.filter
                    .map<String>((string) => string.toLowerCase())
                    .toList(),
                15,
                page);

            if (result.hasValue()) {
              notEmpty = false;
              for (var entity in result.value!.entitiesMap.entries) {
                if (entity.value.isNotEmpty) {
                  notEmpty = true;
                  items += entity.value
                      .map<Map<String, String>>((e) => {
                            'filter': entity.key,
                            'id': e.id,
                            'name': e.name,
                            if (entity.key == 'song') 'duration': e.duration,
                          })
                      .toList();
                }
              }

              items = state.searchList + items;
              page++;
            } else {
              emit(SearchFailed(
                  failure: result.failure!,
                  searchList: state.searchList,
                  filter: state.filter,
                  data: state.data,
                  page: state.page,
                  lastPage: state.lastPage,
                  scrollPosition: state.scrollPosition));
              return;
            }
          }
          emit(state.copyWith(
              searchList: items,
              page: page,
              lastPage: !notEmpty,
              scrollPosition: event.scrollPosition));
        }
      } else if (state.filter.isEmpty) {
        emit(const SearchInitial(
            filter: [], data: '', page: 0, lastPage: false, searchList: []));
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
