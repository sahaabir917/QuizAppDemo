import 'package:flutter/cupertino.dart';
import 'package:quizapp/model/AllResultResponse.dart';
import 'package:quizapp/model/ResultResponse.dart';

class ResultResponseNotifier with ChangeNotifier {
  ResultResponse _resultResponse = null;
  List<AllResultResponse> _allResultResponse = [];
  bool _isLoading = true;

  void setResultResponse(ResultResponse resultResponse) {
    _resultResponse = resultResponse;
    notifyListeners();
  }

  ResultResponse getResultResponse() {
    return _resultResponse;
  }

  void isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  bool getLoading() {
    return _isLoading;
  }

  void resetAll() {
    _isLoading = true;
    _resultResponse = null;
    _allResultResponse = [];
  }

  void setAllResult(List<AllResultResponse> allResultResponseList) {
    _allResultResponse = allResultResponseList;
    notifyListeners();
  }

  List<AllResultResponse> getAllResult() {
    return _allResultResponse;
  }
}
