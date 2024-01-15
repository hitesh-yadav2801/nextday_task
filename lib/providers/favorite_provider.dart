import 'package:flutter/material.dart';
import 'package:nextday_task/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  late SharedPreferences _prefs;
  final List<Data> allUsers; // Add this line to store the list of all users

  // Key for local storage
  static const String favoritesKey = 'favorites';

  List<Data> _favorites = [];

  List<Data> get favorites => _favorites;

  FavoriteProvider(this.allUsers); // Update the constructor to accept all users

  void _loadFavorites() async {
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
      notifyListeners();
    }
  }

  void removeFromFavorites(Data data) {
    _favorites.remove(data);
    _saveFavorites();
    notifyListeners();
  }

  void _saveFavorites() {
    List<String> favoriteIds = _favorites.map((data) => data.id.toString()).toList();
    _prefs.setStringList(favoritesKey, favoriteIds);
    notifyListeners();
  }
}
