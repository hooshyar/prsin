import 'dart:convert';

class Answer {
  int priority;
  String title;
  bool isCorrect;
  Answer({
    required this.priority,
    required this.title,
    required this.isCorrect,
  });

  Answer copyWith({
    int? priority,
    String? title,
    bool? isCorrect,
  }) {
    return Answer(
      priority: priority ?? this.priority,
      title: title ?? this.title,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'priority': priority,
      'title': title,
      'isCorrect': isCorrect,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      priority: map['priority']?.toInt() ?? 0,
      title: map['title'] ?? '',
      isCorrect: map['isCorrect'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() =>
      'Answer(priority: $priority, title: $title, isCorrect: $isCorrect)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Answer &&
        other.priority == priority &&
        other.title == title &&
        other.isCorrect == isCorrect;
  }

  @override
  int get hashCode => priority.hashCode ^ title.hashCode ^ isCorrect.hashCode;
}
