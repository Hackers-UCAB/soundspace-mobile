part of 'search_bloc.dart';

class SearchState extends Equatable {
  final List<String> filter;
  final String data;

  const SearchState({required this.filter, required this.data});

  SearchState copyWith({
    List<String>? filter,
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
  const SearchInitial({required super.filter, super.data = ''});
}

class SearchLoading extends SearchState {
  const SearchLoading({required super.filter, required super.data});
}

class SearchLoaded extends SearchState {
  final EntitiesByName entites;

  const SearchLoaded(
      {required super.filter, required super.data, required this.entites});
}

class SearchEmpty extends SearchState {
  const SearchEmpty({required super.filter, required super.data});
}

class SearchFailed extends SearchState {
  final Failure failure;
  const SearchFailed({
    required super.filter,
    required super.data,
    required this.failure,
  });
}
