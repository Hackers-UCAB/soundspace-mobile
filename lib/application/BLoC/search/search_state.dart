part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String filter;
  final String data;
  final List<Map<String, String>> searchList;
  final int page;
  final bool lastPage;
  final int scrollPosition;

  const SearchState(
      {required this.filter,
      this.data = '',
      required this.searchList,
      this.page = 0,
      this.lastPage = false,
      this.scrollPosition = 0});

  SearchState copyWith(
          {String? filter,
          String? data,
          List<Map<String, String>>? searchList,
          int? page,
          bool? lastPage,
          int? scrollPosition}) =>
      SearchState(
        filter: filter ?? this.filter,
        data: data ?? this.data,
        searchList: searchList ?? this.searchList,
        page: page ?? this.page,
        lastPage: lastPage ?? this.lastPage,
        scrollPosition: scrollPosition ?? this.scrollPosition,
      );

  @override
  List<Object> get props => [filter, data, searchList, page, lastPage];
}

class SearchInitial extends SearchState {
  const SearchInitial(
      {required super.filter,
      super.data = '',
      super.page = 0,
      super.lastPage = false,
      required super.searchList,
      super.scrollPosition = 0});
}

class SearchLoading extends SearchState {
  const SearchLoading(
      {required super.filter,
      required super.data,
      required super.page,
      required super.lastPage,
      required super.searchList,
      required super.scrollPosition});
}

class SearchFailed extends SearchState {
  final Failure failure;
  const SearchFailed({
    required super.filter,
    required this.failure,
    required super.data,
    required super.page,
    required super.lastPage,
    required super.searchList,
    required super.scrollPosition,
  });
}
