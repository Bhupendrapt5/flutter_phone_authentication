import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/plateform_dialog_box.dart';
import 'package:mobile_authentication/customWidgets/platform_circle_indicator.dart';
import 'package:mobile_authentication/customWidgets/platform_dialog.dart';
import 'package:mobile_authentication/helper/utility.dart';
import 'package:mobile_authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../helper/utility.dart';

class PhoneLogineScreen extends StatelessWidget {
  static const String pageName = '/phone_verification';
  final _utility = Utility();
  final _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter your phone number',
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Container(
          width: _utility.getSize(context).width * 0.7,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'Need to verify your number before we can proceed',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              _customBorderText(context: context, text: 'India (+91)'),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _numberController,
                  keyboardType: TextInputType.phone,
                  // maxLength: 10,
                  decoration: InputDecoration(
                    hintText: '10 digit mobile number',
                    contentPadding: const EdgeInsets.only(left: 10),
                  ),
                  validator: (value) {
                    var _num = int.tryParse(value);
                    if (_num == null || value.length != 10) {
                      return 'Enter valid number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _confirmDialogBOx(context, _authProvider);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customBorderText(
      {BuildContext context, String text, double width = double.infinity}) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Future _confirmDialogBOx(BuildContext context, AuthProvider provider) async {
    final confimr = await PlatFormAlertDialogBox(
      title: 'Verify Number',
      content:
          'Is +91-${_numberController.text} your number?\n Do you want to verify or edit your number?',
      defaultActionText: 'Verify',
      cancelActionText: 'Edit',
    ).show(context);
    if (confimr) {
      PlatFormDialogBox(
        content: _dialogContent(context, 'Verifying number'),
      ).show(context);
      var res = await provider.isNumberExist(_numberController.text);
      print('number exist : $res');
      Navigator.pop(context);
      if (res) {
        PlatFormDialogBox(
          content: _dialogContent(context, 'Redirecting to OTP Screen'),
        ).show(context);
        provider.verifyPhoneNumber(context, '+91' + _numberController.text);
      } else {
        PlatFormAlertDialogBox(
          title: 'ALERT',
          content: 'Your are not registered with FOLK App',
          defaultActionText: 'OK',
        ).show(context);
      }
    }
  }

  Widget _dialogContent(BuildContext context, String text) {
    return Container(
      height: Utility().getSize(context).height * 0.25,
      width: Utility().getSize(context).width * 0.30,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PlatformCircularProgressIndicator().show(context),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(text),
            )
          ],
        ),
      ),
    );
  }
}
