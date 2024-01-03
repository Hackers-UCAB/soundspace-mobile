part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchFilterChanged extends SearchEvent {
  final String filter;

  SearchFilterChanged({required this.filter});
}

class SearchDataChanged extends SearchEvent {
  final String data;

  SearchDataChanged({required this.data});
}

class FetchSearchedData extends SearchEvent {}

class FetchMoreSearchedData extends SearchEvent {}
