import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0';

  void buttonPressed(String buttonText) {
  setState(() {
    if (buttonText == 'C') {
      output = '0'; // Reset output jika tombol 'C' ditekan
    } else if (buttonText == '=') {
      try {
        output = evaluateExpression(output); // Evaluasi ekspresi
      } catch (e) {
        output = 'error'; // Tampilkan 'error' jika terjadi kesalahan
      }
    } else {
      // Jika output saat ini adalah '0', ganti dengan buttonText
      if (output == '0') {
        output = buttonText;
      } else {
        // Tambahkan buttonText ke output yang ada
        output += buttonText;
      }
    }
  });
}

  String evaluateExpression (String expression) {
    final parsedExpression = Expression.parse(expression);
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(parsedExpression, {});
    return result.toString();
  }

  Widget buildButton (String buttonText, Color color, {double widthFactor = 1.0}) {
    return Expanded(
      flex: widthFactor.toInt(),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: ()=>buttonPressed(buttonText),
          child: Text (buttonText,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            color: Colors.white
          ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22),
            backgroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
            ),
          ),
        )
      )
    );
  }
  
  @override
  Widget build (BuildContext) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 24, right: 24),
              alignment: Alignment.bottomRight,
              child: Text(output,
                style: TextStyle(
                  fontSize: 89,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  buildButton('C', Colors.grey.shade500),
                  buildButton('+/-', Colors.grey.shade500),
                  buildButton('%', Colors.grey.shade500),
                  buildButton('/', Colors.orange.shade600),
                ],
              ),
              Row(
                children: [
                  buildButton('7', Colors.grey.shade800),
                  buildButton('8', Colors.grey.shade800),
                  buildButton('9', Colors.grey.shade800),
                  buildButton('x', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('4', Colors.grey.shade800),
                  buildButton('5', Colors.grey.shade800),
                  buildButton('6', Colors.grey.shade800),
                  buildButton('-', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('1', Colors.grey.shade800),
                  buildButton('2', Colors.grey.shade800),
                  buildButton('3', Colors.grey.shade800),
                  buildButton('+', Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton('0', Colors.grey.shade800, widthFactor: 2.0),
                  buildButton('.', Colors.grey.shade800),
                  buildButton('=', Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


Widget buildButton(String label, {Color color = Colors.grey}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          // Logika untuk aksi tombol
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.all(24),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    ),
  );
}