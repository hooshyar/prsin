import 'package:flutter/material.dart';

class LoginScreenView extends StatelessWidget {
  LoginScreenView({Key? key}) : super(key: key);

  static const routeName = '/login_screen';
  final phoneNumberController = TextEditingController();
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // phone number text field
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          label: Text('phone number'),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //submit button
            ElevatedButton(
                onPressed: () {
                  phoneNumber = phoneNumberController.text.trim();
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
