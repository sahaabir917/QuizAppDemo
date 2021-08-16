// To parse this JSON data, do
//
//     final modelTests = modelTestsFromJson(jsonString);

import 'dart:convert';

List<ModelTests> modelTestsFromJson(String str) => List<ModelTests>.from(json.decode(str).map((x) => ModelTests.fromJson(x)));

String modelTestsToJson(List<ModelTests> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTests {
  ModelTests({
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
  String title;
  String shortDescription;
  DateTime examStartDateTime;
  DateTime examEndDateTime;
  DateTime examResultDateTime;
  DateTime examResultEndDateTime;
  String coverImage;
  double negativeMarks;
  String subscription;
  int examTime;
  double passMarks;
  String status;

  factory ModelTests.fromJson(Map<String, dynamic> json) => ModelTests(
    url: json["url"],
    id: json["id"],
    title: json["title"],
    shortDescription: json["short_description"],
    examStartDateTime: DateTime.parse(json["exam_start_date_time"]),
    examEndDateTime: DateTime.parse(json["exam_end_date_time"]),
    examResultDateTime: DateTime.parse(json["exam_result_date_time"]),
    examResultEndDateTime: DateTime.parse(json["exam_result_end_date_time"]),
    coverImage: json["cover_image"],
    negativeMarks: json["negative_marks"].toDouble(),
    subscription: json["subscription"],
    examTime: json["exam_time"],
    passMarks: json["pass_marks"].toDouble(),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "id": id,
    "title": title,
    "short_description": shortDescription,
    "exam_start_date_time": examStartDateTime.toIso8601String(),
    "exam_end_date_time": examEndDateTime.toIso8601String(),
    "exam_result_date_time": examResultDateTime.toIso8601String(),
    "exam_result_end_date_time": examResultEndDateTime.toIso8601String(),
    "cover_image": coverImage,
    "negative_marks": negativeMarks,
    "subscription": subscription,
    "exam_time": examTime,
    "pass_marks": passMarks,
    "status": status,
  };
}
