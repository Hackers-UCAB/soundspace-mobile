part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  final bool filterSelected;

  const SearchState({required this.filterSelected});

  @override
  List<Object?> get props => [filterSelected];
}

class SearchInitialState extends SearchState {
  const SearchInitialState({super.filterSelected = false});
}

class SearchLoaded<T> extends SearchState {
  final List<T> entity;

  const SearchLoaded({required this.entity, required super.filterSelected});

  @override
  List<T> get props => artists;
}

class EmptyState extends SearchState {}

class WrittingState extends SearchState {}
