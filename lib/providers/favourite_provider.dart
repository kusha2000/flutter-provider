import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  //state
  final Map<String, bool> _favourites = {};

  //getter
  Map<String, bool> get favourites => _favourites;

  //toggle favourites
  void toggleFavourites(String productId) {
    if (_favourites.containsKey(productId)) {
      _favourites[productId] = !_favourites[productId]!;
    } else {
      _favourites[productId] = true;
    }
    notifyListeners();
  }

  //method to check weather a fav or not
  bool isFavourite(String productId) {
    return _favourites[productId] ?? false;
  }
}
