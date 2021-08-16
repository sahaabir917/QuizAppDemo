import 'package:flutter/material.dart';
import 'package:quizapp/model/Questions.dart';

class QuestionNotifier with ChangeNotifier {
  List<Questions> _questionsList = [];
  bool _isLoading = true;
  int _examTime = 0;
  int _incrementToast = 0;
  int _timeSpend = 0;



  setQuestionsList(List<Questions> questionsList) {
    _questionsList = [];
    _questionsList = questionsList;
    if (_questionsList.length > 0) {
      setDurations(_questionsList[0].modelTest.examTime);
    } else {
      setDurations(0);
    }

    notifyListeners();
  }

  List<Questions> getQuestionsList() {
    return _questionsList;
  }

  bool getLoadingStatus() {
    return _isLoading;
  }

  void setAnswered(int index) {
    _questionsList[index].isAnswered = true;

    notifyListeners();
  }

  bool getisAnswered(index) {
    return _questionsList[index].isAnswered;
  }

  void updateAnswerStatus(int index) {
    _questionsList[index].answerStatus = "answered";
    notifyListeners();
  }

  void setEmptyQuestionList() {
    _questionsList = [];
  }

  void setDurations(int examTime) {
    _examTime = examTime;
    notifyListeners();
  }

  int getDurations() {
    return _examTime;
  }

  void setDefault() {
    _examTime = 0;
    _isLoading = true;
    _incrementToast = 0;
    _timeSpend = 0;
    // notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool getIsLoading() {
    return _isLoading;
  }

  void incrementToast() {
    _incrementToast = _incrementToast+1;
    notifyListeners();
  }

  int getIncrementToast(){
    return _incrementToast;
  }

  void setTimeSpend(int time_spend) {
    _timeSpend = time_spend;
    notifyListeners();
  }

  int getTimeSpend(){
    return _timeSpend;
  }

}
