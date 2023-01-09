import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:non_native_flutter/api/wishlist_item_api.dart';
import 'package:non_native_flutter/database/wishlist_items_database.dart';
import 'package:non_native_flutter/models/wishlist_item.dart';

class WishlistItemProvider with ChangeNotifier {
  final WishlistItemsDatabase database = WishlistItemsDatabase.instance;
  final WishlistItemApi wishlistItemsApi = WishlistItemApi();

  List<WishlistItem> localWishlistItems = [];
  List<WishlistItem> serverWishlistItems = [];

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool mustSyncServerDataWithLocalData = false;

  WishlistItemProvider() {
    subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    database.close();
    subscription.cancel();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectivityResult = result;

    print('connectivity result: $connectivityResult');

    if (hasInternetConnection()) {
      if (mustSyncServerDataWithLocalData) {
        print('has internet connection and must sync server data with local data');
        await syncServerDataWithLocalData();
        await fetchServerData();
        mustSyncServerDataWithLocalData = false;
      }

      await syncLocalDataWithServerData();
    } else {
      print('does not have internet connection');
      await fetchLocalData();
    }
  }

  Future<void> syncServerDataWithLocalData() async {
    await wishlistItemsApi.sync(localWishlistItems);
  }

  Future<void> syncLocalDataWithServerData() async {
    print('syncLocalDataWithServerData() called');
    print('fetching server data');
    await fetchServerData();
    print('server data has been fetched');

    await database.readAll().then(
          (value) => print('database items before syncing with server data: $value'),
        );
    print('server items: $serverWishlistItems');
    await database.deleteAll();
    await database.addAll(serverWishlistItems);
    localWishlistItems = await database.readAll();
    await database.readAll().then(
          (value) => print('database items AFTER syncing with server data: $value'),
        );

    print('notifying listeners');
    notifyListeners();
  }

  Future<void> fetchServerData() async {
    http.Response response = await wishlistItemsApi.readAll();

    if (response.statusCode == 200) {
      print('status code 200');
      Iterable iterableResponse = jsonDecode(response.body);
      serverWishlistItems = await List<WishlistItem>.from(iterableResponse.map((json) => WishlistItem.fromJSON(json)));
      print('server wishlist items: $serverWishlistItems');
    } else {
      print('status code != 200 => exception');
      throw Exception('Failed to fetch wishlist items');
    }
  }

  Future<void> fetchLocalData() async {
    localWishlistItems = await database.readAll();
    print('local data: $localWishlistItems');
    notifyListeners();
  }

  void addWishlistItem(WishlistItem wishlistItem) async {
    if (hasInternetConnection()) {
      print('add: has internet connection');
      await wishlistItemsApi.create(wishlistItem);
      print('after API saved $wishlistItem');
      print('syncing local data with server data');
      await syncLocalDataWithServerData();
    } else {
      print('add: NO internet connection');
      await database.create(wishlistItem);
      await fetchLocalData();
      mustSyncServerDataWithLocalData = true;
    }
  }

  void removeWishlistItem(WishlistItem item) async {
    if (hasInternetConnection()) {
      await wishlistItemsApi.delete(item.id!);
      await syncLocalDataWithServerData();
    } else {
      await database.delete(item.id!);
      await fetchLocalData();
      mustSyncServerDataWithLocalData = true;
    }
  }

  void updateWishlistItem(WishlistItem updatedItem) async {
    if (hasInternetConnection()) {
      await wishlistItemsApi.update(updatedItem);
      await syncLocalDataWithServerData();
    } else {
      await database.update(updatedItem);
      await fetchLocalData();
      mustSyncServerDataWithLocalData = true;
    }
  }

  WishlistItem? findById(int? id) {
    if (id == null) {
      return null;
    }

    WishlistItem? wishlistItem = localWishlistItems.firstWhere((element) => element.id == id);

    return wishlistItem;
  }

  bool hasInternetConnection() {
    return connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile;
  }
}
