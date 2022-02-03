import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prsin/src/app.dart';
import 'package:prsin/src/data_models/user_data_model.dart';

class RegisterConfirmationScreenView extends StatelessWidget {
  RegisterConfirmationScreenView({Key? key, this.verificationID, this.userName})
      : super(key: key);

  static const routeName = '/register_confirmation_screen';
  FirebaseAuth _auth = FirebaseAuth.instance;
  final String? verificationID;
  final String? userName;

  String? uid;
  String? username = '';
  String? phoneNumber = '';
  String? verificationCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Phone Number'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'A Verification Code is sent to $phoneNumber',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              const Text(
                'Enter Verification Code',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              // text field for recieved code from firebase auth
              TextField(
                onChanged: (code) {
                  verificationCode = code;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Verification code',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              // verify button
              ElevatedButton(
                onPressed: () async {
                  verificationCode = verificationCode!.trim();
                  //recieved code from firebase auth on server side

// returns a user credential
                  PhoneAuthCredential _credential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationID!,
                          smsCode: verificationCode!);

                  debugPrint('before');
                  //login using created credentials
                  UserCredential _userCredential =
                      await _auth.signInWithCredential(_credential);
//todo generate the device token here
                  GeneralUser _gUser = GeneralUser(
                      email: '',
                      userName: userName ?? 'no name',
                      uid: _userCredential.user!.uid,
                      phoneNumber: _userCredential.user!.phoneNumber!,
                      createdQuestions: [],
                      correctAnswersCount: 0,
                      tokens: []);

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_userCredential.user!.uid)
                      .set(_gUser.toMap(), SetOptions(merge: true));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NavigatorHelperWidget(
                        gUser: _gUser,
                      ),
                    ),
                  );
                },
                child: Text('Verify Phone Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
