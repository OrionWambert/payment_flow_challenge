import 'package:flutter/material.dart';
import 'package:payment_flow_challenge/pages/app.dart';
import 'package:flutter/services.dart';


void main() =>
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,])
        .then((_) {
      runApp(new MyApp());
    });

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          accentColor: Color.fromARGB(255, 0, 204, 106),
          fontFamily: "Quicksand"),
      home: AppPage(title: 'Now Showing'),
      debugShowCheckedModeBanner: false,
    );
  }
}
