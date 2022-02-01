import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prsin/src/data_models/question_model.dart';

class GeneralUser {
  String email;
  String userName;
  String uid;
  List<Question> createdQuestions;
  int correctAnswersCount;
  List<String> tokens;
  GeneralUser({
    required this.email,
    required this.userName,
    required this.uid,
    required this.createdQuestions,
    required this.correctAnswersCount,
    required this.tokens,
  });

  GeneralUser copyWith({
    String? email,
    String? userName,
    String? uid,
    List<Question>? createdQuestions,
    int? correctAnswersCount,
    List<String>? tokens,
  }) {
    return GeneralUser(
      email: email ?? this.email,
      userName: userName ?? this.userName,
      uid: uid ?? this.uid,
      createdQuestions: createdQuestions ?? this.createdQuestions,
      correctAnswersCount: correctAnswersCount ?? this.correctAnswersCount,
      tokens: tokens ?? this.tokens,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'userName': userName,
      'uid': uid,
      'createdQuestions': createdQuestions.map((x) => x.toMap()).toList(),
      'correctAnswersCount': correctAnswersCount,
      'tokens': tokens,
    };
  }

  factory GeneralUser.fromMap(Map<String, dynamic> map) {
    return GeneralUser(
      email: map['email'] ?? '',
      userName: map['userName'] ?? '',
      uid: map['uid'] ?? '',
      createdQuestions: List<Question>.from(
          map['createdQuestions']?.map((x) => Question.fromMap(x))),
      correctAnswersCount: map['correctAnswersCount']?.toInt() ?? 0,
      tokens: List<String>.from(map['tokens']),
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralUser.fromJson(String source) =>
      GeneralUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeneralUser(email: $email, userName: $userName, uid: $uid, createdQuestions: $createdQuestions, correctAnswersCount: $correctAnswersCount, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralUser &&
        other.email == email &&
        other.userName == userName &&
        other.uid == uid &&
        listEquals(other.createdQuestions, createdQuestions) &&
        other.correctAnswersCount == correctAnswersCount &&
        listEquals(other.tokens, tokens);
  }

  @override
  int get hashCode {
    return email.hashCode ^
        userName.hashCode ^
        uid.hashCode ^
        createdQuestions.hashCode ^
        correctAnswersCount.hashCode ^
        tokens.hashCode;
  }
}
