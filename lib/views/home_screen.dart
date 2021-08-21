import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/notifiers/ModelTestNotifier.dart';
import 'package:quizapp/notifiers/QuestionNotifier.dart';
import 'package:quizapp/notifiers/ResultResponseNotifier.dart';
import 'package:quizapp/service/api_service.dart';
import 'package:quizapp/views/AllModelTest.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  final int time;

  HomeScreen({@required this.index, @required this.time});

  @override
  _MyHomePageState createState() => _MyHomePageState(index, time);
}

class _MyHomePageState extends State<HomeScreen> with TickerProviderStateMixin {
  int index;
  int time;

  int time_spend;

  _MyHomePageState(int index, int time) {
    this.index = index;
  }

  @override
  void initState() {
    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context, listen: false);
    var modelTestId = modelTestNotifier.getModelTestId();
    QuestionNotifier questionNotifier =
        Provider.of<QuestionNotifier>(context, listen: false);
    // ApiService.getQuestions(questionNotifier, modelTestNotifier.getModelTestIdforResult(this.index));
    modelTestNotifier.setDefault();
    questionNotifier.setDefault();
    questionNotifier.setEmptyQuestionList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QuestionNotifier questionNotifier = Provider.of<QuestionNotifier>(context);
    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context);
    ResultResponseNotifier resultResponseNotifier =
        Provider.of<ResultResponseNotifier>(context);
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) {
      this.index = arguments['index'];
      this.time = arguments['time'];
      print(this.index);
      print(this.time);

      if(modelTestNotifier.getIsFirstTime()){
        ApiService.getQuestions(questionNotifier, modelTestNotifier.getModelTestIdforResult(index));
      }
    }

    void finishExam() {
      var score = modelTestNotifier.getScore(this.index);
      questionNotifier.setEmptyQuestionList();
      questionNotifier.setTimeSpend(time_spend);
      Navigator.pushNamed(context, '/resultpage');
      print(score);
    }

    void onSubmitAnswer(int index, int answeredpostion) {
      var answeredoption = "";
      switch (answeredpostion) {
        case 1:
          answeredoption = questionNotifier.getQuestionsList()[index].option1;
          // answeredoption = " " + answeredoption;
          break;
        case 2:
          answeredoption = questionNotifier.getQuestionsList()[index].option2;
          // answeredoption = " " + answeredoption;
          break;
        case 3:
          answeredoption = questionNotifier.getQuestionsList()[index].option3;
          // answeredoption = " " + answeredoption;
          break;
        case 4:
          answeredoption = questionNotifier.getQuestionsList()[index].option4;
          // answeredoption = " " + answeredoption;
          break;

        default:
          answeredoption = questionNotifier.getQuestionsList()[index].option4;
          answeredoption = " " + answeredoption;
          break;
      }

      var answer = " "+questionNotifier.getQuestionsList()[index].correctAnswer;

      if (answer ==
          answeredoption) {
        print("correct answer :" + questionNotifier.getQuestionsList()[index].correctAnswer);
        print("option answer :" + answeredoption);
        print("correct update");
        //update correct answer
        modelTestNotifier.onRightAnswer();
        modelTestNotifier.givenAnswer();
      } else {
        print("wrong update");
        print("correct answer :" + questionNotifier.getQuestionsList()[index].correctAnswer);
        print("option answer :" + answeredoption);
        modelTestNotifier.onWrongAnswer();
        modelTestNotifier.givenAnswer();
      }

      var toast = questionNotifier.getIncrementToast();
      print(toast);
      if (questionNotifier.getIncrementToast() == 0) {
        //show toast
        Fluttertoast.showToast(
            msg: 'You cannot change the answer again!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.lightBlueAccent,
            textColor: Colors.white);
      } else {
        //do nothing ..
      }
      questionNotifier.incrementToast();
    }

    Future<bool> _onBackPressed() {
      // Navigator.pushNamed(context, "/resultpage");
      if (questionNotifier.getQuestionsList().isEmpty) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => AllModelTest()),
                (Route<dynamic> route) => false);
      }
      else {
        showDialog(
            context: context,
            builder: (BuildContext buildcontext) {
              return AlertDialog(
                title: new Text("AI Soultions"),
                content: new Text("Do you want to finish the exam ?"),
                actions: [
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text("Ok"),
                      onPressed: () {
                        finishExam();
                      }),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Model Test"),
          ),
          body: !questionNotifier.getIsLoading()
              ? questionNotifier.getQuestionsList().length > 0
                  ? Scaffold(
                      body: Center(
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  color: Colors.deepPurpleAccent,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          modelTestNotifier
                                              .getModelTestList()[index]
                                              .title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Container(
                                          height: 28,
                                          child: RaisedButton(
                                            color: Colors.redAccent,
                                            onPressed: _onBackPressed,
                                            child: Text(
                                              "finish",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Countdown(
                                  duration: Duration(seconds: time),
                                  onFinish: () {
                                    finishExam();
                                  },
                                  builder:
                                      (BuildContext ctx, Duration remaining) {
                                    time_spend = time - remaining.inSeconds;
                                    return Text(
                                      'Time Left : ${remaining} ',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Container(
                                    height: 400,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 0),
                                      child: ListView.builder(
                                        itemCount: questionNotifier
                                            .getQuestionsList()
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return AbsorbPointer(
                                            absorbing: questionNotifier
                                                .getQuestionsList()[index]
                                                .isAnswered,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: 350,
                                              margin: EdgeInsets.all(5),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                elevation: 10,
                                                child: Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20, right: 20),
                                                      child: Text(
                                                        questionNotifier
                                                            .getQuestionsList()[
                                                                index]
                                                            .question,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: RaisedButton(
                                                              color: !questionNotifier
                                                                      .getisAnswered(
                                                                          index)
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors.teal,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              onPressed: () {
                                                                questionNotifier
                                                                    .setAnswered(
                                                                        index);
                                                                onSubmitAnswer(
                                                                    index, 1);
                                                                questionNotifier
                                                                    .updateAnswerStatus(
                                                                        index);
                                                              },
                                                              child: Text(
                                                                questionNotifier
                                                                    .getQuestionsList()[
                                                                        index]
                                                                    .option1
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                    InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: RaisedButton(
                                                              color: !questionNotifier
                                                                      .getisAnswered(
                                                                          index)
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors.teal,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              onPressed: () {
                                                                questionNotifier
                                                                    .setAnswered(
                                                                        index);
                                                                onSubmitAnswer(
                                                                    index, 2);
                                                                questionNotifier
                                                                    .updateAnswerStatus(
                                                                        index);
                                                              },
                                                              child: Text(
                                                                  questionNotifier
                                                                      .getQuestionsList()[
                                                                          index]
                                                                      .option2
                                                                      .toString()),
                                                            ),
                                                          ),
                                                        )),
                                                    InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: RaisedButton(
                                                              color: !questionNotifier
                                                                      .getisAnswered(
                                                                          index)
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors.teal,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              onPressed: () {
                                                                questionNotifier
                                                                    .setAnswered(
                                                                        index);
                                                                onSubmitAnswer(
                                                                    index, 3);
                                                                questionNotifier
                                                                    .updateAnswerStatus(
                                                                        index);
                                                              },
                                                              child: Text(
                                                                  questionNotifier
                                                                      .getQuestionsList()[
                                                                          index]
                                                                      .option3
                                                                      .toString()),
                                                            ),
                                                          ),
                                                        )),
                                                    InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            child: RaisedButton(
                                                              color: !questionNotifier
                                                                      .getisAnswered(
                                                                          index)
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors.teal,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0)),
                                                              onPressed: () {
                                                                questionNotifier
                                                                    .setAnswered(
                                                                        index);
                                                                onSubmitAnswer(
                                                                    index, 4);
                                                                questionNotifier
                                                                    .updateAnswerStatus(
                                                                        index);
                                                              },
                                                              child: Text(
                                                                  questionNotifier
                                                                      .getQuestionsList()[
                                                                          index]
                                                                      .option4
                                                                      .toString()),
                                                            ),
                                                          ),
                                                        )),
                                                    Text(questionNotifier
                                                        .getQuestionsList()[
                                                            index]
                                                        .answerStatus),
                                                  ],
                                                ),
                                              ),
                                              color: Colors.transparent,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ]))),
                    ))
                  : Center(
                      child: Text("No data found"),
                    )
              : Center(child: CircularProgressIndicator())),
    );
  }
}
