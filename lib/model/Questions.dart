// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

// To parse this JSON data, do
//
//     final questions = questionsFromJson(jsonString);

import 'dart:convert';

List<Questions> questionsFromJson(String str) => List<Questions>.from(json.decode(str).map((x) => Questions.fromJson(x)));

String questionsToJson(List<Questions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Questions {
  Questions({
    this.id,
    this.question,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
    this.correctAnswer,
    this.isAnswered,
    this.answerStatus,
    this.modelTest,
  });

  int id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  dynamic option5;
  String correctAnswer;
  bool isAnswered;
  String answerStatus;
  ModelTest modelTest;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
    id: json["id"],
    question: json["question"],
    option1: json["option_1"],
    option2: json["option_2"],
    option3: json["option_3"],
    option4: json["option_4"],
    option5: json["option_5"],
    correctAnswer: json["correct_answer"],
    isAnswered: json["is_answered"] == null ? false : json["is_answered"],
    answerStatus: json["answer_status"] == null ? " " : json["answer_status"],
    modelTest: ModelTest.fromJson(json["model_test"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question": question,
    "option_1": option1,
    "option_2": option2,
    "option_3": option3,
    "option_4": option4,
    "option_5": option5,
    "correct_answer": correctAnswer,
    "is_answered": isAnswered == false ? null : isAnswered,
    "answer_status": answerStatus == null ? "" : answerStatus,
    "model_test": modelTest.toJson(),
  };
}

class ModelTest {
  ModelTest({
    this.url,
    this.id,
    this.title,
    this.shortDescription,
    this.examStartDateTime,
    this.examEndDateTime,
    this.examResultDateTime,
    this.examResultEndDateTime,
    this.coverImage,
    this.negativeMarks,
    this.subscription,
    this.examTime,
    this.passMarks,
    this.status,
  });

  String url;
  int id;
  Title title;
  String shortDescription;
  DateTime examStartDateTime;
  DateTime examEndDateTime;
  DateTime examResultDateTime;
  DateTime examResultEndDateTime;
  String coverImage;
  double negativeMarks;
  Status subscription;
  int examTime;
  double passMarks;
  Status status;

  factory ModelTest.fromJson(Map<String, dynamic> json) => ModelTest(
    url: json["url"],
    id: json["id"],
    title: titleValues.map[json["title"]],
    shortDescription: json["short_description"],
    examStartDateTime: DateTime.parse(json["exam_start_date_time"]),
    examEndDateTime: DateTime.parse(json["exam_end_date_time"]),
    examResultDateTime: DateTime.parse(json["exam_result_date_time"]),
    examResultEndDateTime: DateTime.parse(json["exam_result_end_date_time"]),
    coverImage: json["cover_image"],
    negativeMarks: json["negative_marks"].toDouble(),
    subscription: statusValues.map[json["subscription"]],
    examTime: json["exam_time"],
    passMarks: json["pass_marks"].toDouble(),
    status: statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "id": id,
    "title": titleValues.reverse[title],
    "short_description": shortDescription,
    "exam_start_date_time": examStartDateTime.toIso8601String(),
    "exam_end_date_time": examEndDateTime.toIso8601String(),
    "exam_result_date_time": examResultDateTime.toIso8601String(),
    "exam_result_end_date_time": examResultEndDateTime.toIso8601String(),
    "cover_image": coverImage,
    "negative_marks": negativeMarks,
    "subscription": statusValues.reverse[subscription],
    "exam_time": examTime,
    "pass_marks": passMarks,
    "status": statusValues.reverse[status],
  };
}

enum Status { F, P }

final statusValues = EnumValues({
  "F": Status.F,
  "P": Status.P
});

enum Title { MODEL_TEST_5, MODEL_TEST_2, MODEL_TEST_4, MODEL_TEST_1, MODEL_TEST_3, MODEL_TEST_6, MODEL_TEST_7, MODEL_TEST_8, MODEL_TEST_9 }

final titleValues = EnumValues({
  "Model Test 1": Title.MODEL_TEST_1,
  "Model Test 2": Title.MODEL_TEST_2,
  "Model Test 3": Title.MODEL_TEST_3,
  "Model Test 4": Title.MODEL_TEST_4,
  "Model Test 5": Title.MODEL_TEST_5,
  "Model Test 6": Title.MODEL_TEST_6,
  "Model Test 7": Title.MODEL_TEST_7,
  "Model Test 8": Title.MODEL_TEST_8,
  "Model Test 9": Title.MODEL_TEST_9
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
