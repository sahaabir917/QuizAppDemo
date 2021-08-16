import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/notifiers/ModelTestNotifier.dart';
import 'package:quizapp/notifiers/ResultResponseNotifier.dart';
import 'package:quizapp/service/api_service.dart';

class AllResultPage extends StatefulWidget {
  @override
  _AllResultPageState createState() => _AllResultPageState();
}

class _AllResultPageState extends State<AllResultPage> {
  int modelTestId;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    ResultResponseNotifier resultResponseNotifier =
        Provider.of<ResultResponseNotifier>(context);

    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context, listen: false);

    if (arguments != null) {
      this.modelTestId = arguments['modelTestId'];
      print(this.modelTestId);
      print(this.modelTestId);
      // modelTestNotifier.setModelTestId(modelTestId);
      ApiService.getAllResult(resultResponseNotifier,
          modelTestNotifier.getModelTestIdforResult(modelTestId));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("All Results"),
        ),
        body: !resultResponseNotifier.getLoading()
            ? !resultResponseNotifier.getAllResult().isEmpty
                ? Scaffold(
                    body: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:
                              resultResponseNotifier.getAllResult().length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: ListTile(
                                title: Card(
                                  color: getColors(index),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  elevation: 10.0,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: Column(
                                      children: <Widget>[
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
                                                .getAllResult()[index]
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
                                            resultResponseNotifier
                                                .getAllResult()[index]
                                                .studentFullName
                                                .toString(),
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
                                                .getAllResult()[index]
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
                                                .getAllResult()[index]
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
                                                .getAllResult()[index]
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
                                                .getAllResult()[index]
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
                                                .getAllResult()[index]
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
                                            resultResponseNotifier
                                                    .getAllResult()[index]
                                                    .duration
                                                    .toString() +
                                                " sec",
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(children: [
                                          Text(
                                            "Result : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            resultResponseNotifier
                                                .getAllResult()[index]
                                                .passFail.toString(),
                                            style: TextStyle(fontSize: 18),
                                          )
                                        ]),
                                        SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            );
                          }),
                    ),
                  )
                : Center(child: Text("no data found"))
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  @override
  void initState() {
    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context, listen: false);
    ResultResponseNotifier resultResponseNotifier =
        Provider.of(context, listen: false);
    var modelTestId = modelTestNotifier.getModelTestId();

    resultResponseNotifier.resetAll();
  }

  Color getColors(int index) {
    var position = index % 4;
    if (position == 1) {
      return Colors.lightGreen;
    } else if (position == 2) {
      return Colors.greenAccent;
    } else if (position == 3) {
      return Colors.lightBlue;
    } else if (position == 0) {
      return Colors.lightGreenAccent;
    }
  }
}
