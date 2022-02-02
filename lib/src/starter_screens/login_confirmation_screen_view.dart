import 'package:flutter/material.dart';

class LoginConfirmationScreenView extends StatelessWidget {
  LoginConfirmationScreenView({Key? key})
      : super(key: key);
  static const routeName = '/login_confirmation_screen';
  String? uid;
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
                onPressed: () {
                  // verify the recieved code
                  verificationCode = verificationCode!.trim();
                  debugPrint('login confirmation code ======>' + verificationCode!);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text('Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
