import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quizapp/model/ModelTests.dart';

class ModelTestNotifier with ChangeNotifier {
  List<ModelTests> _modelTestList = [];
  int _negativeCount = 0;
  bool _isLoading = true;

  int _positiveCount = 0;
  int _attendAnswerCount = 0;
  double totalNegativeMarks = 0;
  double totalMarks = 0;
  String isPassed = "";
  int _modelTestId;

  bool _isFirstTime = true;

  void setDefault() {
    _negativeCount = 0;
    _positiveCount = 0;
    _attendAnswerCount = 0;
    totalNegativeMarks = 0;
    totalMarks = 0;
    isPassed = "";
    _isFirstTime = true;
    // notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    _isFirstTime = false;
    notifyListeners();
  }

  bool getIsLoading() {
    _isFirstTime = false;
    return _isLoading;
  }

  void setModelTestList(List<ModelTests> modelTestList) {
    _modelTestList = [];
    _modelTestList = modelTestList;
    _isFirstTime = false;
    notifyListeners();
  }

  List<ModelTests> getModelTestList() {
    return _modelTestList;
  }

  String getExamStatus(int index) {
    String exam_status = "";
    DateTime startDate = _modelTestList[index].examStartDateTime;
    DateTime endDate = _modelTestList[index].examEndDateTime;
    DateTime resultDate = _modelTestList[index].examResultDateTime;
    DateTime resultEndDate = _modelTestList[index].examResultEndDateTime;

    //current time and format matching
    DateTime currentDate = DateTime.now();
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss+06:00").format(currentDate);
    currentDate = DateTime.parse(formattedDate);

    bool isAfterResultEnd = currentDate.isAfter(resultEndDate);
    bool isbeforeResultEnd = currentDate.isBefore(resultEndDate);
    bool isAfterResultDate = currentDate.isAfter(resultDate);
    bool isbeforeResultDate = currentDate.isBefore(resultDate);
    bool isAfterEndDate = currentDate.isAfter(endDate);
    bool isbeforeEndDate = currentDate.isBefore(endDate);
    bool isAfterStartDate = currentDate.isAfter(startDate);
    bool isbeforeStartDate = currentDate.isBefore(startDate);

    if (isAfterResultEnd) {
      exam_status = "Archived";
    } else if (isbeforeResultEnd && isAfterResultDate) {
      exam_status = "Get Result";
    } else if (isbeforeEndDate && isAfterStartDate) {
      exam_status = "Take";
    } else if (isbeforeStartDate) {
      exam_status = "Upcoming";
    } else if (isbeforeResultDate && isAfterEndDate) {
      exam_status = "Proccessing Result";
    }

    return exam_status;
  }

  void setModelTestId(int index) {
    _modelTestId = _modelTestList[index].id;
    notifyListeners();
  }

  int getModelTestId() {
    return _modelTestId;
  }

  double getScore(int index) {
    var negative_marks = _modelTestList[index].negativeMarks * _negativeCount;
    setTotalNegativeMarks(negative_marks);
    var score = _positiveCount - negative_marks;
    setTotalMarks(score);
    if (score >= _modelTestList[index].passMarks) {
      isPassed = "P";
      setIsPassed(isPassed);
    } else {
      isPassed = "F";
      setIsPassed(isPassed);
    }
    return score;
  }

  void onRightAnswer() {
    _positiveCount = _positiveCount + 1;
    _isFirstTime = false;
    print(_positiveCount);
    notifyListeners();
  }

  void onWrongAnswer() {
    _negativeCount = _negativeCount + 1;
    _isFirstTime = false;
    print(_negativeCount);
    notifyListeners();
  }

  int getPositiveCount() {
    return _positiveCount;
  }

  int getNegativeCount() {
    return _negativeCount;
  }

  void givenAnswer() {
    _attendAnswerCount = _attendAnswerCount + 1;
    _isFirstTime = false;
    notifyListeners();
  }

  int getGivenedAnswer() {
    return _attendAnswerCount;
  }

  void setTotalNegativeMarks(double negative_marks) {
    totalNegativeMarks = negative_marks;
    _isFirstTime = false;
    notifyListeners();
  }

  double getTotalNegativeMarks() {
    return totalNegativeMarks;
  }

  void setTotalMarks(double score) {
    totalMarks = score;
    _isFirstTime = false;
    notifyListeners();
  }

  double getTotalMarks() {
    return totalMarks;
  }

  void setIsPassed(String isPassed) {
    isPassed = isPassed;
    _isFirstTime = false;
    notifyListeners();
  }

  String getIsPassed() {
    return isPassed;
  }

  int getModelTestIdforResult(int modelTestId) {
    return _modelTestList[modelTestId].id;
  }

  bool getIsFirstTime() {
    return _isFirstTime;
  }

}
