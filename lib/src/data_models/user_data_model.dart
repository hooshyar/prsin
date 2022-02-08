import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:prsin/src/data_models/question_model.dart';

//TODO: Add from snapshot
class GeneralUser {
  String email;
  String userName;
  String uid;
  String phoneNumber;
  List<Question> createdQuestions;
  List<Question>? answeredQuestions;
  int correctAnswersCount;
  List<String> tokens;
  DocumentReference? reference;
  GeneralUser(
      {required this.email,
      required this.userName,
      required this.uid,
      required this.phoneNumber,
      required this.createdQuestions,
      this.answeredQuestions,
      required this.correctAnswersCount,
      required this.tokens,
      this.reference});

  GeneralUser.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  // factory GeneralUser.fromSnapshot(DocumentSnapshot snapshot) {

  //   return GeneralUser.fromMap(snapshot.data() as Map<String, dynamic>,
  //       reference: snapshot.reference);

  // }

  GeneralUser copyWith({
    String? email,
    String? userName,
    String? uid,
    String? phoneNumber,
    List<Question>? createdQuestions,
    List<Question>? answeredQuestions,
    int? correctAnswersCount,
    List<String>? tokens,
  }) {
    return GeneralUser(
      email: email ?? this.email,
      userName: userName ?? this.userName,
      uid: uid ?? this.uid,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdQuestions: createdQuestions ?? this.createdQuestions,
      answeredQuestions: answeredQuestions ?? this.createdQuestions,
      correctAnswersCount: correctAnswersCount ?? this.correctAnswersCount,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'createdQuestions': createdQuestions.map((x) => x.toMap()).toList(),
      'answeredQuestions': answeredQuestions == null
          ? []
          : answeredQuestions!.map((x) => x.toMap()).toList(),
      'correctAnswersCount': correctAnswersCount,
      'tokens': tokens,
    };
  }

  GeneralUser.fromMap(Map<String, dynamic> map, {DocumentReference? reference})
      : email = map['email'] ?? '',
        userName = map['userName'] ?? '',
        uid = map['uid'] ?? '',
        phoneNumber = map['phoneNumber'],
        createdQuestions = List<Question>.from(
            map['createdQuestions']?.map((x) => Question.fromMap(x))),
        answeredQuestions = map['answeredQuestions'] == null
            ? []
            : List<Question>.from(
                map['answeredQuestions']?.map((x) => Question.fromMap(x))),
        correctAnswersCount = map['correctAnswersCount']?.toInt() ?? 0,
        tokens = List<String>.from(map['tokens']);

  String toJson() => json.encode(toMap());

  factory GeneralUser.fromJson(String source) =>
      GeneralUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeneralUser(email: $email, userName: $userName, uid: $uid, phoneNumber: $phoneNumber, createdQuestions: $createdQuestions, correctAnswersCount: $correctAnswersCount, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralUser &&
        other.email == email &&
        other.userName == userName &&
        other.uid == uid &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.createdQuestions, createdQuestions) &&
        other.correctAnswersCount == correctAnswersCount &&
        listEquals(other.tokens, tokens);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        userName.hashCode ^
        uid.hashCode ^
        phoneNumber.hashCode ^
        createdQuestions.hashCode ^
        correctAnswersCount.hashCode ^
        tokens.hashCode;
  }
}
