import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/app.dart';
import 'package:prsin/src/data_models/user_data_model.dart';
import 'package:prsin/src/services/firebase_auth.dart';

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
  String? smsCode;

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
                  smsCode = code;
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
                  smsCode = smsCode!.trim();
                  Provider.of<AuthProvider>(context, listen: false)
                      .setTheSmsCode(smsCode!);
                  await Provider.of<AuthProvider>(context, listen: false)
                      .verifySmsCode();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NavigatorHelperWidget(),
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
