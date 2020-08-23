import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/loading_indicator_with_text.dart';
import 'package:mobile_authentication/customWidgets/platform_circle_indicator.dart';
import 'package:mobile_authentication/customWidgets/platform_dialog.dart';
import 'package:mobile_authentication/provider/auth_provider.dart';
import 'package:mobile_authentication/services/firebase_queryies.dart';
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FireBaseQueries().streamUserData(_authProvider.user.uId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            print(
              'data = ${_authProvider.user.uId}',
            );
            var uData = snapshot.data.documents[0];
            return ListView(
              children: [
                Text('name : ${uData['name']}'),
                Text('number : ${uData['mobile']}'),
                Text('FOLK Guide : ${uData['folk_guide']}'),
                Text('author code : ${_authProvider.user.uId}'),
              ],
            );
          }
          return PlatformCircularProgressIndicator().show(context);
        },
      ),
    );
  }
}
