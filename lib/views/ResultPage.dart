import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/notifiers/ModelTestNotifier.dart';
import 'package:quizapp/notifiers/QuestionNotifier.dart';
import 'package:quizapp/notifiers/ResultResponseNotifier.dart';
import 'package:quizapp/service/api_service.dart';
import 'package:quizapp/views/AllModelTest.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context);

    ResultResponseNotifier resultResponseNotifier =
        Provider.of<ResultResponseNotifier>(context);

    QuestionNotifier questionNotifier = Provider.of<QuestionNotifier>(context);

    return WillPopScope(
      onWillPop: _backPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Result page"),
        ),
        body: !resultResponseNotifier.getLoading()
            ? Scaffold(
                body: Center(
                  child: Container(
                    height: 450,
                    child: ListTile(
                      title: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Center(
                                  child: Text(
                                "Your Result :",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                height: 30,
                              ),
                              Row(children: [
                                Text(
                                  "Student Id : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  resultResponseNotifier
                                      .getResultResponse()
                                      .studentId,
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Student Name : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  "Abir Saha",
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Total Answered : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  resultResponseNotifier
                                      .getResultResponse()
                                      .totalQuestionAttended
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Total Wrong Answered : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  resultResponseNotifier
                                      .getResultResponse()
                                      .totalWrongAnswer
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Total Right Answered : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  resultResponseNotifier
                                      .getResultResponse()
                                      .totalRightAnswer
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Total Negative Marks : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  resultResponseNotifier
                                      .getResultResponse()
                                      .totalNegativeMarks
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Total Marks : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  resultResponseNotifier
                                      .getResultResponse()
                                      .totalMarks
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(children: [
                                Text(
                                  "Time Spend : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(
                                  questionNotifier.getTimeSpend().toString() +
                                      " sec",
                                  style: TextStyle(fontSize: 18),
                                )
                              ]),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "Thank you for attending exam.",
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    ResultResponseNotifier resultResponseNotifier =
        Provider.of<ResultResponseNotifier>(context, listen: false);
    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context, listen: false);
    QuestionNotifier questionNotifier =
        Provider.of<QuestionNotifier>(context, listen: false);
    resultResponseNotifier.resetAll();

    ApiService.saveResult(
        resultResponseNotifier,
        modelTestNotifier.getModelTestId(),
        modelTestNotifier.getGivenedAnswer(),
        modelTestNotifier.getPositiveCount(),
        modelTestNotifier.getNegativeCount(),
        modelTestNotifier.getTotalNegativeMarks(),
        modelTestNotifier.getTotalMarks(),
        modelTestNotifier.getIsPassed(),
        questionNotifier.getTimeSpend());
  }

  Future<bool> _backPressed() {
    // Navigator.pushNamed(context, "/all_model_test");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => AllModelTest()),
        (Route<dynamic> route) => false);
  }
}
