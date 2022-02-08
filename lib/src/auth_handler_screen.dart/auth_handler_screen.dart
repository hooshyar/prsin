import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/app.dart';
import 'package:prsin/src/services/firebase_auth.dart';
import 'package:prsin/src/starter_screens/start_screen_view.dart';

class AuthHandlerScreen extends StatelessWidget {
  const AuthHandlerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            Provider.of<AuthProvider>(context, listen: false).isUserLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data == true) {
            return NavigatorHelperWidget();
          }
          return StartScreenView();
        },
      ),
    );
  }
}
