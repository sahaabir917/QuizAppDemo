import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quizapp/model/AllResultResponse.dart';
import 'package:quizapp/model/ModelTests.dart';
import 'package:quizapp/model/Questions.dart';
import 'package:quizapp/model/ResultResponse.dart';
import 'package:quizapp/notifiers/ModelTestNotifier.dart';
import 'package:quizapp/notifiers/QuestionNotifier.dart';
import 'package:quizapp/notifiers/ResultResponseNotifier.dart';

class ApiService {
  static const String API_ENDPOINT = "http://165.22.196.82:8080/api/v1/";

  static getQuestions(
      QuestionNotifier questionNotifier, int modelTestId) async {
    http
        .get(
            "http://165.22.196.82:8080/api/v1/question-bank?model_test=$modelTestId")
        .then((response) {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        List<Questions> questionsList =
            questionsFromJson(utf8.decode(response.bodyBytes));
        questionNotifier.setQuestionsList(questionsList);
      }
      questionNotifier.setIsLoading(false);
    });
  }

  static void getAllModelTest(ModelTestNotifier modelTestNotifier) {
    http.get(API_ENDPOINT + "mcq-model-test").then((response) {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        List<ModelTests> modelTestList =
            modelTestsFromJson(utf8.decode(response.bodyBytes));
        modelTestNotifier.setModelTestList(modelTestList);
      }
      modelTestNotifier.setIsLoading(false);
    });
  }

  static void saveResult(
      ResultResponseNotifier resultResponseNotifier,
      int modelTestId,
      int givenedAnswer,
      int rightAnswer,
      int negativeCount,
      double totalNegativeMarks,
      double totalMarks,
      String isPassed,
      int durations) {
    var body = {
      "student_full_name": 'Abir Saha',
      "student_id": "108",
      "model_test": modelTestId.toString(),
      "total_question_attended": givenedAnswer.toString(),
      "total_right_answer": rightAnswer.toString(),
      "total_wrong_answer": negativeCount.toString(),
      "total_negative_marks": totalNegativeMarks.toString(),
      "total_marks": totalMarks.toString(),
      "pass_fail": isPassed,
      "duration": durations.toString()
    };
    http
        .post(Uri.parse(API_ENDPOINT + "mcq-exam-result-post/"), body: body)
        .then((response) {
      if (response.statusCode == 201) {
        print(response.body);
        ResultResponse resultResponse = resultResponseFromJson(response.body);
        resultResponseNotifier.setResultResponse(resultResponse);
      } else {
        print(response.body);
      }
      resultResponseNotifier.isLoading(false);
    });
  }

  static void getAllResult(
      ResultResponseNotifier resultResponseNotifier, int modelTestId) {
    http
        .get(API_ENDPOINT + "mcq-exam-result-get/?model_test=$modelTestId")
        .then((response) {
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        List<AllResultResponse> allResultResponseList =
            allResultResponseFromJson(response.body);
        resultResponseNotifier.setAllResult(allResultResponseList);
      }
      resultResponseNotifier.isLoading(false);
    });
  }
}
