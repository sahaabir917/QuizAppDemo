// To parse this JSON data, do
//
//     final allResultResponse = allResultResponseFromJson(jsonString);

import 'dart:convert';

List<AllResultResponse> allResultResponseFromJson(String str) => List<AllResultResponse>.from(json.decode(str).map((x) => AllResultResponse.fromJson(x)));

String allResultResponseToJson(List<AllResultResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllResultResponse {
  AllResultResponse({
    this.id,
    this.studentFullName,
    this.studentId,
    this.modelTest,
    this.totalQuestionAttended,
    this.totalRightAnswer,
    this.totalWrongAnswer,
    this.totalNegativeMarks,
    this.totalMarks,
    this.duration,
    this.passFail,
  });

  int id;
  String studentFullName;
  String studentId;
  int modelTest;
  int totalQuestionAttended;
  int totalRightAnswer;
  int totalWrongAnswer;
  double totalNegativeMarks;
  double totalMarks;
  int duration;
  String passFail;

  factory AllResultResponse.fromJson(Map<String, dynamic> json) => AllResultResponse(
    id: json["id"],
    studentFullName: json["student_full_name"],
    studentId: json["student_id"],
    modelTest: json["model_test"],
    totalQuestionAttended: json["total_question_attended"],
    totalRightAnswer: json["total_right_answer"],
    totalWrongAnswer: json["total_wrong_answer"],
    totalNegativeMarks: json["total_negative_marks"].toDouble(),
    totalMarks: json["total_marks"].toDouble(),
    duration: json["duration"],
    passFail: json["pass_fail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "student_full_name": studentFullName,
    "student_id": studentId,
    "model_test": modelTest,
    "total_question_attended": totalQuestionAttended,
    "total_right_answer": totalRightAnswer,
    "total_wrong_answer": totalWrongAnswer,
    "total_negative_marks": totalNegativeMarks,
    "total_marks": totalMarks,
    "duration": duration,
    "pass_fail": passFail,
  };
}
