import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/data_models/question_model.dart';
import 'package:prsin/src/data_models/user_data_model.dart';
import 'package:prsin/src/services/firebase_auth.dart';
import 'package:prsin/src/services/firestore_service.dart';

enum Answers { answer1, answer2, answer3, answer4 }

class QuestionCardWidget extends StatefulWidget {
  const QuestionCardWidget({Key? key, required this.question})
      : super(key: key);
  final Question question;

  @override
  _QuestionCardWidgetState createState() => _QuestionCardWidgetState();
}

class _QuestionCardWidgetState extends State<QuestionCardWidget> {
  FirestoreService _db = FirestoreService();

  Answers? _answer = Answers.answer1;
  bool _isCorrect = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.question.questionTitle ?? 'no title'),
      subtitle: Text(widget.question.author ?? 'no author'),
      children: answers(widget.question),
      trailing: Text(widget.question.viewCount.toString()),
    );
  }

  List<Widget> answers(Question question) {
    GeneralUser? _user =
        Provider.of<AuthProvider>(context, listen: false).generalUser;
    return [
      RadioListTile<Answers>(
        title: Text(
          question.answers![0].title,
        ),
        value: Answers.answer1,
        groupValue: _answer,
        onChanged: (Answers? value) {
          setState(() {
            _isCorrect = question.answers![0].isCorrect;
            _answer = value;
          });
        },
      ),
      RadioListTile<Answers>(
        title: Text(
          question.answers![1].title,
        ),
        value: Answers.answer2,
        groupValue: _answer,
        onChanged: (Answers? value) {
          setState(() {
            _isCorrect = question.answers![1].isCorrect;
            _answer = value;
          });
        },
      ),
      RadioListTile<Answers>(
        title: Text(
          question.answers![2].title,
        ),
        value: Answers.answer3,
        groupValue: _answer,
        onChanged: (Answers? value) {
          setState(() {
            _isCorrect = question.answers![2].isCorrect;
            _answer = value;
          });
        },
      ),
      RadioListTile<Answers>(
        title: Text(
          question.answers![3].title,
        ),
        value: Answers.answer4,
        groupValue: _answer,
        onChanged: (Answers? value) {
          setState(() {
            _isCorrect = question.answers![3].isCorrect;
            _answer = value;
          });
        },
      ),
      ElevatedButton(
          onPressed: () async {
            debugPrint(_isCorrect.toString());
            await _db
                .addToAnsweredQuestions(question, _user!)
                .then((value) => debugPrint('added to answered'));
            if (_isCorrect == true) {
              await _db.addPoints(_user);
            }
            _db.removePoints(_user);
          },
          child: Text('submit')),
      SizedBox(
        height: 50,
      ),
    ];
  }

  // to decide if the answer is correct

}
