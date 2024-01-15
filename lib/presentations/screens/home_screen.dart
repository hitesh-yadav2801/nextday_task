import 'package:flutter/material.dart';
import 'package:nextday_task/data/repositories/api_services.dart';
import 'package:nextday_task/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../../data/models/models.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ApiServices apiServices = ApiServices();
    List<Data> allUsers = [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoriteScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: apiServices.getUsers(),
          builder: (context, AsyncSnapshot<List<Data>> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              allUsers = snapshot.data!;
              return ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  Data userData = allUsers[index];
                  bool isFavorite = context.watch<FavoriteProvider>().favorites.contains(userData);

                  return ListTile(
                    title: Text('${userData.firstName} ${userData.lastName}'),
                    subtitle: Text('Email: ${userData.email}'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userData.avatar ?? ''),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          context.read<FavoriteProvider>().removeFromFavorites(userData);
                        } else {
                          context.read<FavoriteProvider>().addToFavorites(userData);
                        }
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
