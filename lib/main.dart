import 'package:flutter/material.dart';
import 'package:mobile_authentication/Route/route_generator.dart';
import 'package:mobile_authentication/provider/auth_provider.dart';
import 'package:mobile_authentication/screen/home_screen.dart';
import 'package:mobile_authentication/screen/phone_login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider.initialize(),
      child: MaterialApp(
        title: 'Phone Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: ScreensController(),
        // initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    if (auth.isLoggedIn) {
      return HomeScreen();
    } else {
      return PhoneLogineScreen();
    }
  }
}
