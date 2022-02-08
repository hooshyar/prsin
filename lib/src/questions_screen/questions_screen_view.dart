import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prsin/src/data_models/question_model.dart';
import 'package:prsin/src/questions_screen/question_card.dart';
import 'package:prsin/src/services/firebase_auth.dart';
import 'package:prsin/src/services/firestore_service.dart';

class QuestionsScreenViews extends StatelessWidget {
  QuestionsScreenViews({Key? key}) : super(key: key);
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        child: FutureBuilder<List<Question>>(
            future: _firestoreService.fetchAllUsersQuestions(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snap.hasError) {
                return Text(snap.error.toString());
              }
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, index) {
                    debugPrint('====?' + snap.data![index].reference!.path);
                    // to hide the questions of the current user
                    if (snap.data![index].author ==
                        Provider.of<AuthProvider>(context, listen: false)
                            .generalUser!
                            .uid) {
                      return Container();
                    }
                    return QuestionCardWidget(
                      question: snap.data![index],
                    );
                  });
            }),
      ),
    );
  }
}
