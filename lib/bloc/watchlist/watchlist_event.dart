part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {}

class FetchWatchlist extends WatchlistEvent {
  String watchlistName;
  FetchWatchlist(this.watchlistName);
}

class SortWatchlist extends WatchlistEvent {
  bool atoz = true;
  String watchlistName;
  String searchName;
  SortWatchlist(this.atoz, this.watchlistName, {this.searchName = ""});
}
