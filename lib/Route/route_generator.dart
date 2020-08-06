import 'package:flutter/material.dart';
import 'package:mobile_authentication/screen/home_screen.dart';
import 'package:mobile_authentication/screen/otp_screen.dart';
import 'package:mobile_authentication/screen/phone_login.dart';
import 'package:mobile_authentication/screen/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case HomeScreen.pageName:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case PhoneLogineScreen.pageName:
        return MaterialPageRoute(
          builder: (_) => PhoneLogineScreen(),
        );
      case OTPScreen.pageName:
        return MaterialPageRoute(
          builder: (_) => OTPScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
