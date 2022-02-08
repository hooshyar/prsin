import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prsin/src/data_models/question_model.dart';
import 'package:prsin/src/data_models/user_data_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addPoints() {
    //TODO: ++ user points
  }

  removePoints() {
    //TODO: -- user points
  }

  //add questions to questions collection
  //todo add questions to current user

  addAquestion(
      {required Question question, required GeneralUser generalUser}) async {
    await _db
        .collection('users')
        .doc(generalUser.uid)
        .collection('questions')
        .add(question.toMap());
  }

  Future<List<Question>> fetchAllUsersQuestions() async {
    var snapshot = await _db.collectionGroup('questions').get();
    return snapshot.docs.map((e) => Question.fromSnapshot(e)).toList();
  }

  Future<void> updateTheTitle(Question question) async {
    await question.reference!.update({'questionTitle': 'new Title'}).then(
        (value) => debugPrint('changed'));
  }

  //read the entire questions from the database

}
