import 'package:flutter/material.dart';
import 'package:prsin/src/starter_screens/register_confirmation_screen.dart';

class RegisterScreenView extends StatelessWidget {
  RegisterScreenView({Key? key}) : super(key: key);

  static const routeName = '/register_screen';

  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String? username = '';
  String? phoneNumber = '';
  String? uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
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
                    // username text field
                    Container(
                      child: TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'username',
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

                    const SizedBox(
                      height: 20,
                    ),

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
                username = usernameController.text.trim();
                phoneNumber = phoneNumberController.text.trim();
                debugPrint('register screen view =======> $username');
                debugPrint('register screen view =======> $phoneNumber');
                // navigate to confirm the phone number
                Navigator.of(context).pushNamed(RegisterConfirmationScreenView.routeName);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
