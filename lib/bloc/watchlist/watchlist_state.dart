part of 'watchlist_bloc.dart';

abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoad extends WatchlistState {}

class WatchlistDone extends WatchlistState {
  final WatchlistModel watchlist;

  WatchlistDone(this.watchlist);
}

class WatchlistError extends WatchlistState {}
