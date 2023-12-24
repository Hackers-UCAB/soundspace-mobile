part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Artist> get props => [];
}

class EmptyState extends SearchState {}

class WrittingState extends SearchState {}
