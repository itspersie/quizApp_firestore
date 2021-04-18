import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;

  Results({this.correct, this.incorrect, this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}"),
              SizedBox(
                height: 8,
              ),
              Text(
                  "You answered ${widget.correct} correctly And ${widget.incorrect} incorrectly"),
            ],
          ),
        ),
      ),
    );
  }
}
