import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/app.dart';
import 'package:prsin/src/services/firebase_auth.dart';
import 'package:prsin/src/starter_screens/start_screen_view.dart';

class AuthHandler extends StatefulWidget {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  _AuthHandlerState createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<AuthProvider>(context, listen: false).isUserLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == false) {
            return StartScreenView();
          } else if (snapshot.hasError) {
            return Text('err');
          }
          return NavigatorHelperWidget();
        },
      ),
    );
  }
}
