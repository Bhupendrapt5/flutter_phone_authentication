import 'package:flutter/material.dart';
import 'package:mobile_authentication/Route/route_generator.dart';
import 'package:mobile_authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import 'provider/auth_provider.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Phone Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
