import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/loading_indicator_with_text.dart';
import 'package:mobile_authentication/customWidgets/platform_dialog.dart';
import 'package:mobile_authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String pageName = '/home_screen';
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.power_settings_new,
            ),
            onPressed: () {
              PlatFormDialogBox(
                content: LoadingIndicatorWithMessage(text: 'Loggign Out'),
              ).show(context);
              _authProvider.signOut(context);
            },
          )
        ],
      ),
      body: Center(
        child: Text('Hello'),
      ),
    );
  }
}
