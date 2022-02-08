import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:prsin/src/data_models/answer_data_model.dart';
import 'package:prsin/src/data_models/user_data_model.dart';

class Question {
  String? questionTitle;
  List<Answer>? answers;
  int? viewCount;
  List<dynamic>? correctUsers; //
  String? author;
  DocumentReference? reference;
  Question({
    this.questionTitle,
    this.answers,
    this.viewCount,
    this.correctUsers,
    this.author,
    this.reference,
  });

  // Question from snapshot factory
  Question.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  Question.fromMap(Map<String, dynamic> map, {this.reference})
      : questionTitle = map['questionTitle'],
        viewCount = map['viewCount'],
        correctUsers = map['correctUsers'],
        author = map['author'],
        answers =
            List<Answer>.from(map['answers'].map((x) => Answer.fromMap(x)));

  Question copyWith({
    String? questionTitle,
    List<Answer>? answers,
    int? viewCount,
    List<GeneralUser>? correctUsers,
    String? author,
    DocumentReference? reference,
  }) {
    return Question(
      questionTitle: questionTitle ?? this.questionTitle,
      answers: answers ?? this.answers,
      viewCount: viewCount ?? this.viewCount,
      correctUsers: correctUsers ?? this.correctUsers,
      author: author ?? this.author,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionTitle': questionTitle,
      'answers': answers!.map((x) => x.toMap()).toList(),
      'viewCount': viewCount,
      'correctUsers': correctUsers!.map((x) => x.toMap()).toList(),
      'author': author,
      'reference': reference,
    };
  }

  // factory Question.fromMap(Map<String, dynamic> map) {
  //   return Question(
  //     map['questionTitle'] ?? '',
  //     List<Answer>.from(map['answers']?.map((x) => Answer.fromMap(x))),
  //     map['viewCount']?.toInt() ?? 0,
  //     List<GeneralUser>.from(map['correctUsers']?.map((x) => GeneralUser.fromMap(x))),
  //     map['author'] ?? '',
  //     map['reference'],
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(questionTitle: $questionTitle, answers: $answers, viewCount: $viewCount, correctUsers: $correctUsers, author: $author, reference: $reference)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.questionTitle == questionTitle &&
        listEquals(other.answers, answers) &&
        other.viewCount == viewCount &&
        listEquals(other.correctUsers, correctUsers) &&
        other.author == author &&
        other.reference == reference;
  }

  @override
  int get hashCode {
    return questionTitle.hashCode ^
        answers.hashCode ^
        viewCount.hashCode ^
        correctUsers.hashCode ^
        author.hashCode ^
        reference.hashCode;
  }
}
