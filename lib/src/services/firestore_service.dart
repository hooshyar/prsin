import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prsin/src/data_models/question_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //add questions to questions collection
  //todo add questions to current user

  addAquestion({required Question question}) async {
    await _db.collection('questions').add(question.toMap());
  }

  //read the entire questions from the database

}
