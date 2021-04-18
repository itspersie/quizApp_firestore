import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/database.dart';
import 'package:quiz/widgets/quiz_play_widget.dart';
import 'package:quiz/widgets/widgets.dart';

import '../model/question_model.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  Stream playQuizStream;

  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0, correct = 0, incorrect = 0, notattempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot querySnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionDocumentSnapshot) {
    QuestionModel questionModel = new QuestionModel();

    Map<String, dynamic> doc = questionDocumentSnapshot.data();
    questionModel.question = doc['question'];

    //print('question model question' + questionModel.question);

    print(doc);

    List<String> options = [
      doc['option1'],
      doc['option2'],
      doc['option3'],
      doc['option4'],
    ];

    options.shuffle();

    //print(options);

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctAnswer = doc['option1'];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");

    databaseService.getQuizData(widget.quizId).then((value) {
      // print("getquizdata" + value);
      querySnapshot = value;
      notattempted = 0;
      correct = 0;
      incorrect = 0;
      total = querySnapshot.docs.length;
      print("$total + length h ye");
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            querySnapshot.docs == null
                ? Container()
                : ListView.builder(
                   shrinkWrap: true,
                   physics: ClampingScrollPhysics(),
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (context, index) {
                      return QuizPlayTile(questionmodel:
                        getQuestionModelFromDataSnapshot(
                            querySnapshot.docs[index]),
                        index: index,
                      );
                    })
          ],
        ),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionmodel;
  final int index;
  QuizPlayTile(
      {this.questionmodel, this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
      
        children: [
          Text(widget.questionmodel.question),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionmodel.option1,
            description: widget.questionmodel.option1,
            option: "A",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionmodel.option1,
            description: widget.questionmodel.option2,
            option: "B",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionmodel.option1,
            description: widget.questionmodel.option3,
            option: "C",
            optionSelected: optionSelected,
          ),
          SizedBox(height: 4),
          OptionTile(
            correctAnswer: widget.questionmodel.option1,
            description: widget.questionmodel.option4,
            option: "D",
            optionSelected: optionSelected,
          ),
        ],
      ),
    );
  }
}
