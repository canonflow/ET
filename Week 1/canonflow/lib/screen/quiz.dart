import 'package:flutter/material.dart';
import 'dart:async';
import 'package:canonflow/class/question.dart' as question_class;

import 'package:percent_indicator/percent_indicator.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  
  int _hitung = 10;
  int _initValue = 10;
  bool isEnd = false;

  late List<question_class.Question> questions;

  // Initi in initState
  late Timer _timer;

  void initState() {
    super.initState();
    startTimer();
    questions = question_class.getQuestions();

    // Setup Questions
    // question_class.questions.add(question_class.Question("Not a member of Avenger ", 'Ironman','Spiderman', 'Thor', 'Hulk Hogan', 'Hulk Hogan'));
    // question_class.questions.add(question_class.Question("Not a member of Teletubbies", 'Dipsy', 'Patrick','Laalaa', 'Poo', 'Patrick'));
    // question_class.questions.add(question_class.Question("Not a member of justice league", 'batman', 'aquades','superman', 'flash', 'aquades'));
    // question_class.questions.add(question_class.Question("Not a member of BTS", 'Jungkook','Jimin', 'Gong Yoo', 'Suga', 'Gong Yoo'));
  }

  void endGame() {
    setState(() {
      _timer.cancel();
      _hitung = 0;
      // question_class.question_no = 0;  // Reset the number
      // question_class.point = 0;
      showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text("Quiz"),
          content: Text("Quiz Ended.\nYour point is ${question_class.point}"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'), 
              child: const Text("OK")
            )
          ],
        )
      );
    });
  }

  void startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_timer) {
        setState(() {
          if (_hitung == 0) {
            if (question_class.question_no == question_class.maxQuestionNo - 1) {
              // Timer is up and we already in the last question
              endGame();
            } else {
              question_class.question_no++;
              _hitung = _initValue;
              _timer.cancel();
              startTimer();
            }
            // showDialog(
            //   context: context, 
            //   builder: (BuildContext context) => AlertDialog(
            //     title: Text("Quiz"),
            //     content: Text("Quiz Ended"),
            //     actions: <Widget>[
            //       TextButton(
            //         onPressed: () => Navigator.pop(context, 'OK'), 
            //         child: const Text("OK")
            //       )
            //     ],
            //   )
            // );
          } else {
            _hitung--;
          }
        });
      }
    );
  }

  void checkAnswer(String answer) {
    setState(() {
      if (!isEnd) {
        if (answer == questions[question_class.question_no].answer) {
            question_class.point += 100;
        } else {
          question_class.point -= 50;
        }
      }

      if (question_class.question_no == question_class.maxQuestionNo - 1) {
        endGame();
        isEnd = true;
      } else {
        _hitung = _initValue;
        question_class.question_no++;
      }
    });
  }

  String formatTimer(int hitung) {
    // ~/ is a truncating division operator
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');

    return "$hours:$minutes:$seconds";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    _hitung = 100;
    question_class.question_no = 0;  // Reset the number
    question_class.point = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Text(
              //   formatTimer(_hitung),
              //   style: const TextStyle(
              //     fontSize: 24,
              //   )
              // ),
              Text("Number: ${question_class.question_no + 1}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(height: 6),
              Text("Point: ${question_class.point}"),
              SizedBox(height: 6),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 20.0,
                percent: 1 - (_hitung / _initValue),
                center: Text(formatTimer(_hitung)),
                progressColor: Colors.red,
              ),
              const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () {
              //     setState(() {
              //       _timer.isActive ? _timer.cancel() : startTimer();
              //     });
              //   },
              //   child: Text(_timer.isActive ? "Stop" : "Start"),
              // )

              const SizedBox(height: 12),
              Container(
                width: 300,
                height: 200,
                alignment: Alignment(0, 0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(questions[question_class.question_no].photo),
                    fit: BoxFit.cover
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(16))
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${questions[question_class.question_no].narration}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () { 
                  checkAnswer(questions[question_class.question_no].optionA);
                },
                child: Text("A. ${questions[question_class.question_no].optionA}")
              ),
              TextButton(
                onPressed: () { 
                  checkAnswer(questions[question_class.question_no].optionB);
                },
                child: Text("B. ${questions[question_class.question_no].optionB}")
              ),
              TextButton(
                onPressed: () { 
                  checkAnswer(questions[question_class.question_no].optionC);
                },
                child: Text("C. ${questions[question_class.question_no].optionC}")
              ),
              TextButton(
                onPressed: () { 
                  checkAnswer(questions[question_class.question_no].optionD);
                },
                child: Text("D. ${questions[question_class.question_no].optionD}")
              ),
            ]
          ),
        )
      ),
    );

  }
}
