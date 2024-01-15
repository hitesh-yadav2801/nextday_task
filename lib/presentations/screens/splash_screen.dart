import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nextday_task/presentations/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      // Initialize app logic (fetch data, handle loading)
      await Future.delayed(const Duration(seconds: 4));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'lib/core/animations/loading.json',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                repeat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
