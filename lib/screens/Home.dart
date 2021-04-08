import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/create_quiz.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/database.dart';

import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Quiz').snapshots(),
          builder: (context, snapshot) {
            return snapshot.data == null
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return QuizTile(
                        title: snapshot.data.docs[index].get('quizTitle'),
                        description: snapshot
                            .data.docs[index].get('quizDescription'),
                      );
                    },
                  );
          }),
    );
  }

  // @override
  // void initState() {
  //   databaseService.getQuizData().then((value) {
  //     setState(() {
  //       quizStream = value;
  //       print(value.toString()+" bilkul");
  //     });
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   Timer(Duration(seconds: 0), () async {
  //     print("1");

  //     await Firebase.initializeApp();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title, description;
  QuizTile({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 10),
        child: Stack(
      children: [
        ClipRect(
          
                  child: Image.asset('lib/assets/bg.jpg', width: MediaQuery.of(context).size.width-48,
          fit: BoxFit.cover,),
        ),
        Container(
          //color: Colors.black,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,style: TextStyle(color: Colors.amber,fontSize:18,fontWeight:FontWeight.w600),),
              Text(description,style:TextStyle(color: Colors.amber,fontSize:12,fontWeight:FontWeight.w400)),
            ],
          ),
        )
      ],
    ));
  }
}
