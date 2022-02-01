import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:prsin/src/data_models/answer_data_model.dart';

import 'package:prsin/src/data_models/user_data_model.dart';

class Question {
  String questionTitle;
  List<Answer> answers;
  int viewCount;
  List<GeneralUser> correctUsers;
  Question({
    required this.questionTitle,
    required this.answers,
    required this.viewCount,
    required this.correctUsers,
  });

  Question copyWith({
    String? questionTitle,
    List<Answer>? answers,
    int? viewCount,
    List<GeneralUser>? correctUsers,
  }) {
    return Question(
      questionTitle: questionTitle ?? this.questionTitle,
      answers: answers ?? this.answers,
      viewCount: viewCount ?? this.viewCount,
      correctUsers: correctUsers ?? this.correctUsers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionTitle': questionTitle,
      'answers': answers.map((x) => x.toMap()).toList(),
      'viewCount': viewCount,
      'correctUsers': correctUsers.map((x) => x.toMap()).toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionTitle: map['questionTitle'] ?? '',
      answers: List<Answer>.from(map['answers']?.map((x) => Answer.fromMap(x))),
      viewCount: map['viewCount']?.toInt() ?? 0,
      correctUsers: List<GeneralUser>.from(
          map['correctUsers']?.map((x) => GeneralUser.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(questionTitle: $questionTitle, answers: $answers, viewCount: $viewCount, correctUsers: $correctUsers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        other.questionTitle == questionTitle &&
        listEquals(other.answers, answers) &&
        other.viewCount == viewCount &&
        listEquals(other.correctUsers, correctUsers);
  }

  @override
  int get hashCode {
    return questionTitle.hashCode ^
        answers.hashCode ^
        viewCount.hashCode ^
        correctUsers.hashCode;
  }
}
