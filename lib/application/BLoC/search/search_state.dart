part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<String> filter;
  final String data;
  final List<Map<String, String>> searchList;
  final int page;

  const SearchState(
      {required this.filter,
      required this.data,
      required this.searchList,
      required this.page});

  SearchState copyWith(
          {List<String>? filter,
          String? data,
          List<Map<String, String>>? searchList,
          int? page}) =>
      SearchState(
        filter: filter ?? this.filter,
        data: data ?? this.data,
        searchList: searchList ?? this.searchList,
        page: page ?? this.page,
      );

  @override
  List<Object> get props => [filter, data, searchList];
}

class SearchInitial extends SearchState {
  const SearchInitial(
      {required super.filter,
      super.data = '',
      required super.searchList,
      super.page = 1});
}

class SearchLoading extends SearchState {
  const SearchLoading(
      {required super.filter,
      required super.data,
      required super.searchList,
      required super.page});
}

class SearchLoaded extends SearchState {
  const SearchLoaded(
      {required super.filter,
      required super.data,
      required super.searchList,
      required super.page});
}

class SearchFailed extends SearchState {
  final Failure failure;
  const SearchFailed(
      {required super.filter,
      required super.data,
      required this.failure,
      required super.searchList,
      required super.page});
}
