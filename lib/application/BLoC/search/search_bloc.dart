import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/artist/artist.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(EmptyState()) {
    on<SearchInputedEvent>(_searchInputedEventHandler);
    on<SearchEmptiedEvent>(_searchEmptiedEventHandler);
  }

  void _searchInputedEventHandler(
      SearchInputedEvent event, Emitter<SearchState> emit) {
    emit(WrittingState());
  }

  void _searchEmptiedEventHandler(
      SearchEmptiedEvent event, Emitter<SearchState> emit) {
    emit(EmptyState());
  }
}
