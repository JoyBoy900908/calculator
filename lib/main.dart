import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  String memory = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CE") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "DEL") {
      _output = _output.substring(0, _output.length - 1);
    } else if (buttonText == "MEM") {
      _output = memory;
    } else {
      _output = _output + buttonText;
    }

    if (buttonText == "=") {
      num2 = double.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      memory = _output;
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("計算機"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Flexible(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  ...["7", "8", "9", "/"].map((btnText) => buildButton(btnText)),
                  ...["4", "5", "6", "*"].map((btnText) => buildButton(btnText)),
                  ...["1", "2", "3", "-"].map((btnText) => buildButton(btnText)),
                  ...[".", "0", "00", "+"].map((btnText) => buildButton(btnText)),
                  ...["CE","MEM","DEL", "="].map((btnText) => buildButton(btnText)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String buttonText) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        //padding: EdgeInsets.all(24.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
