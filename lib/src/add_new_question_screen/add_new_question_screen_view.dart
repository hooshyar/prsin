import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prsin/src/data_models/answer_data_model.dart';
import 'package:prsin/src/data_models/question_model.dart';
import 'package:prsin/src/services/firestore_service.dart';

enum Answers { answer1, answer2, answer3, answer4 }

class AddNewQuestionScreenView extends StatefulWidget {
  AddNewQuestionScreenView({Key? key}) : super(key: key);

  @override
  State<AddNewQuestionScreenView> createState() =>
      _AddNewQuestionScreenViewState();
}

class _AddNewQuestionScreenViewState extends State<AddNewQuestionScreenView> {
  final FirestoreService _firestoreService = FirestoreService();

  Answers? _answer = Answers.answer1;

  TextEditingController _questionController = TextEditingController();

  TextEditingController _answer1Controller = TextEditingController();

  TextEditingController _answer2Controller = TextEditingController();

  TextEditingController _answer3Controller = TextEditingController();

  TextEditingController _answer4Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
          child: ListView(
        children: [
          Text('question'),
          TextFormField(
            controller: _questionController,
            decoration: const InputDecoration(
              labelText: 'Question',
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text('answers'),
          RadioListTile<Answers>(
            title: TextFormField(
              controller: _answer1Controller,
              decoration: const InputDecoration(
                labelText: 'Answer 1',
              ),
            ),
            value: Answers.answer1,
            groupValue: _answer,
            onChanged: (Answers? value) {
              setState(() {
                _answer = value;
              });
            },
          ),
          RadioListTile<Answers>(
            title: TextFormField(
              controller: _answer2Controller,
              decoration: const InputDecoration(
                labelText: 'Answer 2',
              ),
            ),
            value: Answers.answer2,
            groupValue: _answer,
            onChanged: (Answers? value) {
              setState(() {
                _answer = value;
              });
            },
          ),
          RadioListTile<Answers>(
            title: TextFormField(
              controller: _answer3Controller,
              decoration: const InputDecoration(
                labelText: 'Answer 3',
              ),
            ),
            value: Answers.answer3,
            groupValue: _answer,
            onChanged: (Answers? value) {
              setState(() {
                _answer = value;
              });
            },
          ),
          RadioListTile<Answers>(
            title: TextFormField(
              controller: _answer4Controller,
              decoration: const InputDecoration(
                labelText: 'Answer 4',
              ),
            ),
            value: Answers.answer4,
            groupValue: _answer,
            onChanged: (Answers? value) {
              setState(() {
                _answer = value;
              });
            },
          ),
          SizedBox(
            height: 50,
          ),
          Align(
            widthFactor: 2,
            heightFactor: 1,
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width - 140,
              child: ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  Question _currentQuestion = Question(
                      questionTitle: _questionController.value.text,
                      viewCount: 0,
                      correctUsers: [],
                      answers: [
                        Answer(
                            priority: 0,
                            title: _answer1Controller.value.text,
                            isCorrect:
                                _answer == Answers.answer1 ? true : false),
                        Answer(
                            priority: 1,
                            title: _answer2Controller.value.text,
                            isCorrect: _answer == Answers.answer2),
                        Answer(
                            priority: 2,
                            title: _answer3Controller.value.text,
                            isCorrect: _answer == Answers.answer3),
                        Answer(
                            priority: 3,
                            title: _answer4Controller.value.text,
                            isCorrect: _answer == Answers.answer4),
                      ]);
                  _firestoreService.addAquestion(question: _currentQuestion);
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
