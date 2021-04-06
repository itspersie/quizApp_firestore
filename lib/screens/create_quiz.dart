import 'package:flutter/material.dart';
import 'package:quiz/screens/addquestion.dart';
import 'package:quiz/services/database.dart';
import 'package:random_string/random_string.dart';

import '../widgets/widgets.dart';

class CreateQuiz extends StatefulWidget {
  static const routeName = "/createQuiz";
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  String quizTitle, quizDescription, quizId;

  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  Future createQuiz() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      quizId = randomAlphaNumeric(16);

      print(quizId.toString());

      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizTitle": quizTitle,
        "quizDescription": quizDescription,
      };
      print(quizMap);
      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(quizId: quizId,)));
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
                child: Center(child: CircularProgressIndicator()),
              )
            : Form(
                key: _formkey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val.isEmpty ? "Enter Title" : null,
                        decoration: InputDecoration(
                          hintText: "quiz Title",
                        ),
                        onChanged: (val) {
                          quizTitle = val;
                        },
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? "Enter Description" : null,
                        decoration: InputDecoration(
                          hintText: "quiz Description",
                        ),
                        onChanged: (val) {
                          quizDescription = val;
                        },
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            createQuiz();
                          },
                          child: amberButton(
                            context: context, 
                            label: "Create Quiz",
                            //buttonSize: MediaQuery.of(context).size.width/2 - 36,
                            )),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ));
  }
}
