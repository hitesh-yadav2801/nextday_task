import 'package:flutter/material.dart';
import 'package:nextday_task/data/models/models.dart'; // Import your Data model
import 'package:nextday_task/presentations/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:nextday_task/providers/favorite_provider.dart';

void main() {
  List<Data> allUsers = []; // Define the allUsers list here

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider(allUsers)),
        // Add other providers if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
