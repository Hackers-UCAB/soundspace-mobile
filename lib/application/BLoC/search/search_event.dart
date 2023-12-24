part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class SearchInputedEvent extends SearchEvent {
  SearchInputedEvent(this.artists);
  List<Artist> artists;
}

class SearchEmptiedEvent extends SearchEvent {
  SearchEmptiedEvent(this.artists);
  List<Artist> artists;
}