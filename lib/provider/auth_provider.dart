import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/customWidgets/plateform_dialog_box.dart';
import 'package:mobile_authentication/model/user_model.dart';
import 'package:mobile_authentication/screen/home_screen.dart';
import 'package:mobile_authentication/screen/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/phone_login.dart';

class AuthProvider with ChangeNotifier {
  SharedPreferences _sharedPrefs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  User _userModel;
  TextEditingController phoneNo;
  // String smsOTP;
  String verificationCode;
  String errorMessage = '';
  bool isLoggedIn = false;
  bool isLoading = false;

  User get user => _userModel;
  FirebaseUser get firebaseUser => _user;

  // AuthProvider.initialize() {
  //   getPrefsData();
  // }

  Future<bool> getPrefsData() async {
    // await Future.delayed(Duration(seconds: 3)).then((value) async {
    _sharedPrefs = await SharedPreferences.getInstance();

    isLoggedIn = _sharedPrefs.getBool('loggedIn') ?? false;
    // print('isLoggedIn : $isLoggedIn');
    if (isLoggedIn) {
      var userData = _sharedPrefs.getString('userData');
      _userModel = User.fromFirebase(userData);
      _user = await _auth.currentUser();
    }
    notifyListeners();
    // });

    return isLoggedIn;
  }

  handleError(error, BuildContext context) {
    print('error: ' + error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        print("The verification code is invalid");
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    print('number : $number');
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      print('move to OTP');
      Navigator.pop(context);
      Navigator.pushNamed(context, OTPScreen.pageName);
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: number.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified,
            //or sign's the user in and [verificationCompleted] is called.
            this.verificationCode = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 60),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
    } catch (e) {
      handleError(e, context);
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void signIn({
    BuildContext context,
    String smsOTP,
  }) async {
    try {
      final AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: verificationCode,
        smsCode: smsOTP,
      );

      final AuthResult _userResult =
          await _auth.signInWithCredential(_authCredential).then(
        (value) => value,
        onError: (er) {
          Navigator.pop(context);
          PlatFormAlertDialogBox(
            title: 'ALERT',
            content: 'You have entered wrong OTP.',
            defaultActionText: 'OK',
          ).show(context);
        },
      );
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(_userResult.user.uid == currentUser.uid);
      Navigator.pop(context);
      if (_userResult != null) {
        _userModel = User.fromFirebase(
          userMapString(_userResult.user),
        );
        _sharedPrefs.setString('userData', _userModel.toJson());
        _sharedPrefs.setBool('loggedIn', true);

        this.isLoggedIn = true;
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          ModalRoute.withName(PhoneLogineScreen.pageName),
        );
      }
    } catch (e) {
      print("${e.toString()}");
    }
  }

  Future signOut(BuildContext context) async {
    await Future<void>.delayed(Duration(seconds: 1));
    var _shredPref = await SharedPreferences.getInstance();
    _shredPref.clear();
    await _auth.signOut();
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      ModalRoute.withName(HomeScreen.pageName),
    );
  }

  Future<bool> isNumberExist(String number) async {
    var qs = await Firestore.instance
        .collection('Profile')
        .where('mobile', isEqualTo: number)
        .limit(1)
        .getDocuments();

    return qs.documents.isNotEmpty;
  }

  String userMapString(FirebaseUser user) {
    return jsonEncode(<String, dynamic>{
      'phoneNumber': user.phoneNumber,
      'uid': user.uid,
    });
  }
}
