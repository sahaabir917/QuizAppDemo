import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/notifiers/ModelTestNotifier.dart';
import 'package:quizapp/notifiers/QuestionNotifier.dart';
import 'package:quizapp/notifiers/ResultResponseNotifier.dart';
import 'package:quizapp/views/AllModelTest.dart';
import 'package:quizapp/views/AllResultPage.dart';
import 'package:quizapp/views/ResultPage.dart';
import 'package:quizapp/views/home_screen.dart';

Future<void> main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => QuestionNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ModelTestNotifier(),
      ),
      ChangeNotifierProvider(create: (context) => ResultResponseNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('bn', ''),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AllModelTest(),
      routes: {
        "/all_questions": (context) => HomeScreen(),
        "/all_model_test": (context) => AllModelTest(),
        "/resultpage": (context) => ResultPage(),
        "/getAllResult" :(context) =>AllResultPage(),
      },
    );
  }
}
