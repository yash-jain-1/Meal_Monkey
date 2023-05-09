import 'package:flutter/material.dart';
import 'package:monkey_app_demo/auth.dart';
import 'package:monkey_app_demo/screens/homeScreen.dart';
import 'package:monkey_app_demo/screens/loginScreen.dart';
import 'package:rive/rive.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: RiveAnimation.network(
                'https://cdn.rive.app/animations/vehicles.riv',
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: RiveAnimation.network(
                'https://cdn.rive.app/animations/vehicles.riv',
              ),
            ),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
