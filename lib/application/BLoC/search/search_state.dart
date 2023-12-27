part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String filter;
  final String data;

  const SearchState({required this.filter, required this.data});

  SearchState copyWith({
    String? filter,
    String? data,
  }) =>
      SearchState(
        filter: filter ?? this.filter,
        data: data ?? this.data,
      );

  @override
  List<Object> get props => [filter, data];
}

class SearchInitial extends SearchState {
  const SearchInitial({super.filter = '', super.data = ''});
}

class SearchLoading extends SearchState {
  const SearchLoading({required super.filter, required super.data});
}

//FIXME: Esto de pana que puede mejorar
class SearchLoaded extends SearchState {
  final List<Map<String, String>> searchData;

  const SearchLoaded(
      {required super.filter, required super.data, required this.searchData});
}

class SearchFailed extends SearchState {
  final Failure failure;
  const SearchFailed({
    required super.filter,
    required super.data,
    required this.failure,
  });
}
