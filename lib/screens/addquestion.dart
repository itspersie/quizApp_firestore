import 'package:flutter/material.dart';
import 'package:quiz/services/database.dart';
import 'package:quiz/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  String quizId;

  AddQuestion({this.quizId});
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formkey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;

  bool _isLoading = false;

  DatabaseService databaseService = new DatabaseService();

  uploadQuestionData() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await databaseService
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: appBar(context),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
        ),
        body: _isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                child: Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val.isEmpty ? "Question" : null,
                        decoration: InputDecoration(
                          hintText: "Question",
                        ),
                        onChanged: (val) {
                          question = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Option 1" : null,
                        decoration: InputDecoration(
                          hintText: "Option 1",
                        ),
                        onChanged: (val) {
                          option1 = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Option 2" : null,
                        decoration: InputDecoration(
                          hintText: "Option 2",
                        ),
                        onChanged: (val) {
                          option2 = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Option 3" : null,
                        decoration: InputDecoration(
                          hintText: "Option 3",
                        ),
                        onChanged: (val) {
                          option3 = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Option 4" : null,
                        decoration: InputDecoration(
                          hintText: "Option 4",
                        ),
                        onChanged: (val) {
                          option4 = val;
                        },
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: amberButton(
                                context: context,
                                label: "SUBMIT",
                                buttonSize:
                                    MediaQuery.of(context).size.width / 2 - 36,
                              )),
                          SizedBox(
                            //horizontal spacing
                            width: 24,
                          ),
                          GestureDetector(
                              onTap: () {
                                uploadQuestionData();
                              },
                              child: amberButton(
                                context: context,
                                label: "ADD QUESTION ",
                                buttonSize:
                                    MediaQuery.of(context).size.width / 2 - 36,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              )));
  }
}
