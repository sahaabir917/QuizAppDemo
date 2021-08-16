import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/notifiers/ModelTestNotifier.dart';
import 'package:quizapp/service/api_service.dart';

class AllModelTest extends StatefulWidget {
  const AllModelTest({Key key}) : super(key: key);

  @override
  _AllModelTestState createState() => _AllModelTestState();
}

class _AllModelTestState extends State<AllModelTest> {
  @override
  Widget build(BuildContext context) {
    ModelTestNotifier modelTestNotifier =
        Provider.of<ModelTestNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("All Model Test"),
        ),
        body: !modelTestNotifier.getIsLoading()
            ? !modelTestNotifier.getModelTestList().isEmpty
                ? Scaffold(
                    body: Container(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount:
                              modelTestNotifier.getModelTestList().length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: ListTile(
                                title: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  elevation: 10.0,
                                  child: Column(
                                    children: <Widget>[
                                      Image.network(
                                        modelTestNotifier
                                            .getModelTestList()[index]
                                            .coverImage,
                                        height: 170,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Text(
                                        modelTestNotifier
                                            .getModelTestList()[index]
                                            .title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Text(
                                            modelTestNotifier
                                                .getModelTestList()[index]
                                                .shortDescription,
                                            style: TextStyle(fontSize: 12),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                            "Start Date : " +
                                                modelTestNotifier
                                                    .getModelTestList()[index]
                                                    .examStartDateTime
                                                    .toString() +
                                                "+06:00 GMT",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                            "End Date : " +
                                                modelTestNotifier
                                                    .getModelTestList()[index]
                                                    .examEndDateTime
                                                    .toString() +
                                                "+06:00 GMT",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                            "Result Date : " +
                                                modelTestNotifier
                                                    .getModelTestList()[index]
                                                    .examResultDateTime
                                                    .toString() +
                                                "+06:00 GMT",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(
                                            "Result End Date : " +
                                                modelTestNotifier
                                                    .getModelTestList()[index]
                                                    .examResultEndDateTime
                                                    .toString() +
                                                "+06:00 GMT",
                                            style: TextStyle(fontSize: 12)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // InkWell(
                                      //   child: Padding(
                                      //     padding: EdgeInsets.only(
                                      //         left: 20, right: 20),
                                      //     child: Container(
                                      //       width:
                                      //           MediaQuery.of(context).size.width,
                                      //       child: RaisedButton(
                                      //         color: Colors.blueGrey,
                                      //           shape: RoundedRectangleBorder(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       20.0)),
                                      //           child: Text(
                                      //             modelTestNotifier
                                      //                 .getExamStatus(index),
                                      //             style: TextStyle(
                                      //                 color: Colors.white),
                                      //           )),
                                      //     ),
                                      //   ),
                                      // ),
                                      InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: RaisedButton(
                                                color: getColor(
                                                    modelTestNotifier
                                                        .getExamStatus(index)),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                onPressed: () {
                                                  initModelTest(
                                                      context,
                                                      index,
                                                      modelTestNotifier
                                                          .getExamStatus(index)
                                                          .toString(),
                                                      modelTestNotifier
                                                          .getModelTestList()[
                                                              index]
                                                          .examTime);
                                                },
                                                child: Text(
                                                  modelTestNotifier
                                                      .getExamStatus(index),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  modelTestNotifier.setModelTestId(index);
                                  initModelTest(
                                      context,
                                      index,
                                      modelTestNotifier
                                          .getExamStatus(index)
                                          .toString(),
                                      modelTestNotifier
                                          .getModelTestList()[index]
                                          .examTime);
                                },
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
    ApiService.getAllModelTest(modelTestNotifier);
    super.initState();
  }

  void initModelTest(
      BuildContext context, int modelTestId, String exam_status, int examTime) {
    if (exam_status == "Upcoming") {
      Fluttertoast.showToast(
          msg: 'Exam is not start yet!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.lightBlueAccent,
          textColor: Colors.white);
    } else if (exam_status == "Get Result") {
      Navigator.pushNamed(context, '/getAllResult',
          arguments: {'modelTestId': modelTestId});
    } else if (exam_status == "Proccessing Result") {
      Fluttertoast.showToast(
          msg: 'Result is processing. Will published soon',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.lightBlueAccent,
          textColor: Colors.white);
    } else{
      //for take and archived
      Navigator.pushNamed(context, '/all_questions',
          arguments: {'index': modelTestId, 'time': examTime});
    }
  }

  Color getColor(String examStatus) {
    if (examStatus == "Upcoming") {
      return Colors.teal;
    } else if (examStatus == "Get Result") {
      return Colors.lightGreen;
    } else if (examStatus == "Proccessing Result") {
      return Colors.grey;
    } else{
      //for take and archived
      return Colors.lightBlueAccent;
    }
  }
}
