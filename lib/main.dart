import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.white10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      child: Text(
                        userQuestion,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: Text(
                        userAnswer,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButtons(
                        buttonTapped: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red,
                        textColor: Colors.white,
                      );
                    } else if (index == 1) {
                      return MyButtons(
                        buttonTapped: () {
                          setState(() {
                            if(userQuestion.length > 0){
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            }
                            if(userQuestion.length > 0){
                              equalPressed();
                            }
                            else if(userQuestion.length == 0){
                              userAnswer = '';
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == buttons.length - 1) {
                      return MyButtons(
                        buttonTapped: () {
                          setState(() {
                            if(userQuestion.length > 0){
                              equalPressed();
                            }
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      );
                    }
                    else if (index == buttons.length - 2) {
                      return MyButtons(
                        buttonTapped: () {
                          setState(() {
                            equalPressed();
                            userQuestion = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                      );
                    }else {
                      return MyButtons(
                        buttonTapped: () {
                          setState(() {
                            if(!(isOperator(buttons[index]))){
                              userQuestion += buttons[index];
                            }
                            else if(isOperator(buttons[index])){
                              if(isOperator(userQuestion[userQuestion.length-1])){
                                userQuestion = userQuestion.substring(0,userQuestion.length-1);
                                userQuestion += buttons[index];
                              }
                              else{
                                userQuestion += buttons[index];
                              }
                            }
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.teal
                            : Colors.white24,
                        textColor: Colors.white,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == 'x' || x == '/' || x == '%' || x == '*') return true;
    return false;
  }
  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    if(isOperator(finalQuestion[finalQuestion.length-1])){
      finalQuestion = finalQuestion.substring(0,finalQuestion.length-1);
    }
    if(finalQuestion.length > 0){
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      userAnswer = eval.toString();
    }
  }
}
