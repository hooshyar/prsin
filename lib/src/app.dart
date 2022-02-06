import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/add_new_question_screen/add_new_question_screen_view.dart';
import 'package:prsin/src/data_models/user_data_model.dart';
import 'package:prsin/src/questions_screen/questions_screen_view.dart';
import 'package:prsin/src/ranking_screens/rankings_screen_view.dart';
import 'package:prsin/src/services/firebase_auth.dart';
import 'package:prsin/src/starter_screens/login_confirmation_screen_view.dart';
import 'package:prsin/src/starter_screens/login_screen_view.dart';
import 'package:prsin/src/starter_screens/register_confirmation_screen.dart';
import 'package:prsin/src/starter_screens/register_screen_view.dart';
import 'package:prsin/src/starter_screens/start_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: NavigatorHelperWidget(),
      // home: NavigatorHelperWidget(),
      initialRoute: '/',
      routes: {
        '/': (_) => StartScreenView(),
        RegisterScreenView.routeName: (context) => RegisterScreenView(),
        RegisterConfirmationScreenView.routeName: (context) =>
            RegisterConfirmationScreenView(),
        LoginScreenView.routeName: (context) => LoginScreenView(),
        LoginConfirmationScreenView.routeName: (context) =>
            LoginConfirmationScreenView(),
      },
    );
  }
}

class NavigatorHelperWidget extends StatefulWidget {
  const NavigatorHelperWidget({Key? key}) : super(key: key);

  @override
  _NavigatorHelperWidgetState createState() => _NavigatorHelperWidgetState();
}

class _NavigatorHelperWidgetState extends State<NavigatorHelperWidget> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  List<Widget> _pages = [
    QuestionsScreenViews(),
    AddNewQuestionScreenView(),
    RankingScreenView()
  ];

  @override
  Widget build(BuildContext context) {
    AuthProvider _auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_auth.generalUser!.phoneNumber),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: 'questions'),
          const BottomNavigationBarItem(icon: Icon(Icons.add), label: 'new'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'rankings'),
        ],
      ),
    );
  }
}
