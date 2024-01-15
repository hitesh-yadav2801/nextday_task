import 'package:flutter/material.dart';
import 'package:nextday_task/data/models/models.dart';
import 'package:nextday_task/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Favorites'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          // Get the list of favorites from the provider
          List<Data> favorites = favoriteProvider.favorites;

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              Data favorite = favorites[index];
              return ListTile(
                title: Text('${favorite.firstName} ${favorite.lastName}'),
                subtitle: Text('Email: ${favorite.email}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(favorite.avatar ?? ''),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    // Remove from favorites
                    favoriteProvider.removeFromFavorites(favorite);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
