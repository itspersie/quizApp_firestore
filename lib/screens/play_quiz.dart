import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/result.dart';
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
        child: SingleChildScrollView(
                  child: Column(
            children: [
              querySnapshot == null
                  ? Container(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: querySnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                          questionmodel: getQuestionModelFromDataSnapshot(
                              querySnapshot.docs[index]),
                          index: index,
                        );
                      })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Results(
                correct: correct,
                incorrect: incorrect,
                total: total,
              )));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionmodel;
  final int index;
  QuizPlayTile({this.questionmodel, this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Q.${widget.index + 1} ${widget.questionmodel.question}",
            style: TextStyle(fontSize: 18, color: Colors.black87),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.questionmodel.answered) {
                if (widget.questionmodel.option1 ==
                    widget.questionmodel.correctAnswer) {
                  optionSelected = widget.questionmodel.option1;
                  widget.questionmodel.answered = true;
                  correct += 1;
                  notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionmodel.option1;
                  widget.questionmodel.answered = true;
                  incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionmodel.correctAnswer,
              description: widget.questionmodel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionmodel.answered) {
                if (widget.questionmodel.option2 ==
                    widget.questionmodel.correctAnswer) {
                  optionSelected = widget.questionmodel.option2;
                  widget.questionmodel.answered = true;
                  correct += 1;
                  notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionmodel.option2;
                  widget.questionmodel.answered = true;
                  incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionmodel.correctAnswer,
              description: widget.questionmodel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionmodel.answered) {
                if (widget.questionmodel.option3 ==
                    widget.questionmodel.correctAnswer) {
                  optionSelected = widget.questionmodel.option3;
                  widget.questionmodel.answered = true;
                  correct += 1;
                  notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionmodel.option3;
                  widget.questionmodel.answered = true;
                  incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionmodel.correctAnswer,
              description: widget.questionmodel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionmodel.answered) {
                if (widget.questionmodel.option4 ==
                    widget.questionmodel.correctAnswer) {
                  optionSelected = widget.questionmodel.option4;
                  widget.questionmodel.answered = true;
                  correct += 1;
                  notattempted -= 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionmodel.option4;
                  widget.questionmodel.answered = true;
                  incorrect += 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionmodel.correctAnswer,
              description: widget.questionmodel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
