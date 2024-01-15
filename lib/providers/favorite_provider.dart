import 'package:flutter/material.dart';
import 'package:nextday_task/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  final List<Data> allUsers;

  // Key for local storage
  static const String favoritesKey = 'favorites';

  List<Data> _favorites = [];

  List<Data> get favorites => _favorites;

  FavoriteProvider(this.allUsers) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = _prefs.getStringList(favoritesKey);
    if (favoriteIds != null) {
      _favorites = favoriteIds.map((id) {
        return allUsers.firstWhere((user) => user.id.toString() == id);
      }).toList();
      notifyListeners();
    }
  }

  void addToFavorites(Data data) {
    if (!_favorites.contains(data)) {
      _favorites.add(data);
      _saveFavorites();
    }
  }

  void removeFromFavorites(Data data) {
    _favorites.remove(data);
    _saveFavorites();
  }

  void _saveFavorites() {
    List<String> favoriteIds = _favorites.map((data) => data.id.toString()).toList();
    _prefs.setStringList(favoritesKey, favoriteIds);
    notifyListeners();
  }
}
