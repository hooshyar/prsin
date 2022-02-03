import 'package:flutter/material.dart';
import 'package:prsin/src/starter_screens/login_screen_view.dart';
import 'package:prsin/src/starter_screens/register_screen_view.dart';

class StartScreenView extends StatelessWidget {
  const StartScreenView({Key? key}) : super(key: key);

    static const routeName = '/starter_screen';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome'),),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(40),
          padding: const EdgeInsets.all(40),
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Psrin Quiz', textAlign: TextAlign.center, style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              
              ),),
              const SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterScreenView.routeName);
                },
                child: const Text('Register'),
              ),
            const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginScreenView.routeName);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
