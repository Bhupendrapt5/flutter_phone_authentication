import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String pageName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
