import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 28;
  double resultFontSize = 32;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 28;
        resultFontSize = 32;
      } else if (buttonText == "⌫") {
        equationFontSize = 32;
        resultFontSize = 28;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 28;
        resultFontSize = 32;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 32;
        resultFontSize = 28;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonColor,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      // ignore: deprecated_member_use
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1, style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background1,
      appBar: AppBar(title: Text('Simple Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1, MyColors.operators),
                      buildButton("⌫", 1, MyColors.operators),
                      buildButton("÷", 1, MyColors.operators),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, MyColors.background2),
                      buildButton("8", 1, MyColors.background2),
                      buildButton("9", 1, MyColors.background2),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, MyColors.background2),
                      buildButton("5", 1, MyColors.background2),
                      buildButton("6", 1, MyColors.background2),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, MyColors.background2),
                      buildButton("2", 1, MyColors.background2),
                      buildButton("3", 1, MyColors.background2),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, MyColors.background2),
                      buildButton("0", 1, MyColors.background2),
                      buildButton("00", 1, MyColors.background2),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, MyColors.operators),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, MyColors.operators),
                    ]),
                    TableRow(children: [
                      buildButton(
                        "+",
                        1,
                        MyColors.operators,
                      )
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, MyColors.operators),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
