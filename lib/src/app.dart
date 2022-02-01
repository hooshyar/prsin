import 'package:flutter/material.dart';
import 'package:prsin/src/add_new_question_screen/add_new_question_screen_view.dart';
import 'package:prsin/src/questions_screen/questions_screen_view.dart';
import 'package:prsin/src/ranking_screens/rankings_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigatorHelperWidget(),
    );
  }
}

class NavigatorHelperWidget extends StatefulWidget {
  const NavigatorHelperWidget({Key? key}) : super(key: key);

  @override
  _NavigatorHelperWidgetState createState() => _NavigatorHelperWidgetState();
}

class _NavigatorHelperWidgetState extends State<NavigatorHelperWidget> {
  int _currentIndex = 0;

  List<Widget> _pages = [
    QuestionsScreenViews(),
    AddNewQuestionScreenView(),
    RankingScreenView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer), label: 'questions'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'new'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'rankings'),
        ],
      ),
    );
  }
}
