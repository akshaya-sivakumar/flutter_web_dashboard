import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard_web/utils/app_utils.dart';

import '../../model/watchlist/watchlist_model.dart';
import '../../repo/watchlist_repo.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc() : super(WatchlistInitial()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoad());
      WatchlistModel? watchlist;
      try {
        if (AppUtils().getfromCrypto() == null) {
          watchlist = await WatchlistRepository().data();
          AppUtils().setinCrypto(watchlist);
        } else {
          watchlist = AppUtils().getfromCrypto();
        }

        sortingWatchlist(SortWatchlist(true, event.watchlistName), emit);
      } catch (e) {
        emit(WatchlistError());
        throw ("error");
      }
    });

    on<SortWatchlist>(sortingWatchlist);
  }

  FutureOr<void> sortingWatchlist(event, emit) async {
    emit(WatchlistLoad());
    try {
      List<Symbols> storeswatchlist = AppUtils()
              .getfromCrypto()
              ?.response
              .data
              .symbols
              .where((element) => element.watchlistName == event.watchlistName)
              .toList() ??
          [];

      if (event.searchName != null && event.searchName != "") {
        storeswatchlist = storeswatchlist
            .where((element) => element.dispSym
                .toLowerCase()
                .contains(event.searchName.toLowerCase()))
            .toList();
      }

      WatchlistModel watchlistmodel = WatchlistModel(
          response: Response(appID: "", data: Data(symbols: storeswatchlist)));

      event.atoz
          ? storeswatchlist.sort((a, b) =>
              a.dispSym.toLowerCase().compareTo(b.dispSym.toLowerCase()))
          : storeswatchlist.sort((a, b) =>
              b.dispSym.toLowerCase().compareTo(a.dispSym.toLowerCase()));

      emit(WatchlistDone(watchlistmodel..response.data.symbols));
    } catch (e) {
      emit(WatchlistError());
      throw ("error");
    }
  }
}
