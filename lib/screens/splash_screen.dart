import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeUrl = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
