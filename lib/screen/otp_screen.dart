import 'package:flutter/material.dart';
import 'package:mobile_authentication/helper/utility.dart';
import 'package:mobile_authentication/provider/auth_provider.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatelessWidget {
  static const String pageName = '/otp_screen';
  final _utility = Utility();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm OTP',
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
                  'Enter Your 6 digit OTP',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              PinInputTextFormField(
                pinLength: 6,
                decoration: UnderlineDecoration(),
                controller: _codeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  _authProvider.signIn(
                      context: context, smsOTP: _codeController.text);
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
