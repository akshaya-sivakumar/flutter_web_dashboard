import 'dart:convert';
import 'dart:core';

import '../constants/api_url.dart';
import '../model/watchlist_model.dart';
import '../resources/api_base_helper.dart';

class WatchlistRepository {
  Future<WatchlistModel> data() async {
    var response = await ApiBaseHelper().getMethod(ApiUrls.watchlistUrl);

    WatchlistModel watchlistResponse =
        WatchlistModel.fromJson(json.decode(response.body));

    return watchlistResponse;
  }
}
