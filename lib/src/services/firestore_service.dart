import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prsin/src/data_models/question_model.dart';
import 'package:prsin/src/data_models/user_data_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addPoints(GeneralUser gUser) async {
    await _db
        .collection('users')
        .doc(gUser.uid)
        .update({'correctAnswersCount': FieldValue.increment(1)});
  }

  removePoints(GeneralUser gUser) async {
    await _db
        .collection('users')
        .doc(gUser.uid)
        .update({'correctAnswersCount': FieldValue.increment(-1)});
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

  //read the entire questions from the database
  //add to answered questions
  Future<void> addToAnsweredQuestions(
      Question question, GeneralUser user) async {
    await _db.collection('users').doc(user.uid).update({
      'answeredQuestions':
          FieldValue == null ? [] : FieldValue.arrayUnion([question.toMap()])
    });
  }
}
