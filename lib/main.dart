import 'package:flutter/material.dart';
import 'package:quiz/screens/create_quiz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 // final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  // This widget is the root of your application.
  //
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.amber,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: Home(),
            routes: {
              CreateQuiz.routeName: (ctx) => CreateQuiz(),
            },
          );
  }
}

/*FutureBuilder(
        future: _fbApp,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("ERROR ${snapshot.error.toString()}");
            return Text("ERROR");
          } else if (snapshot.hasData) {
            return Home();
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
*/
