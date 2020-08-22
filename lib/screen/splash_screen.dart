import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_authentication/screen/phone_login.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarIconBrightness: Brightness.dark,
      ),
    );
    _navigateToHome(context, _authProvider);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Opacity(
                opacity: 0.60,
                child: Text(
                  'Demo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 48.0,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateToHome(context, AuthProvider _authProvider) async {
    final isLoggedIn = await _authProvider.getPrefsData();
    String routeName;

    Timer(
      Duration(seconds: 3),
      () {
        if (isLoggedIn) {
          routeName = HomeScreen.pageName;
        } else {
          routeName = PhoneLogineScreen.pageName;
        }
        Navigator.pushReplacementNamed(context, routeName);
      },
    );
  }
}
