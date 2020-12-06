import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const routeUrlFirebase = '/';
  static const routeUrlVk = '/vk-init';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
