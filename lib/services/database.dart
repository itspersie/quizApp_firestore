import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// class DatabaseService1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Firestore"),
//       ),
//       body: FutureBuilder(
//         future: getData(),

//       ),

//     );
//   }
// }

class DatabaseService {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // CollectionReference ref = FirebaseFirestore.instance.collection("Quiz");
  Future<void> addQuizData(Map quizData, String quizId) async {
    print("databaseservice_addquiz");
    //await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizId)
        .set(quizData)
        .whenComplete(() => print("done"))
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection('Quiz')
        .doc(quizId)
        .collection('QNA')
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }

  // getQuizData() async {
  //  await FirebaseFirestore.instance.collection('Quiz').snapshots();
  // }
}
