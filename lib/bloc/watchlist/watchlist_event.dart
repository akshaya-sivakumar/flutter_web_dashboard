part of 'watchlist_bloc.dart';

abstract class WatchlistEvent {}

class FetchWatchlist extends WatchlistEvent {
  FetchWatchlist();
}

class SortWatchlist extends WatchlistEvent {
  
  bool atoz = true;
  SortWatchlist( this.atoz);
}
