import 'package:flutter_bloc/flutter_bloc.dart';


import '../../model/watchlist_model.dart';
import '../../repo/watchlist_repo.dart';


part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoad());
      try {
        final watchlist = await WatchlistRepository().data();

        emit(WatchlistDone(watchlist));
      } catch (e) {
        emit(WatchlistError());
        throw ("error");
      }
    });
  }
}
