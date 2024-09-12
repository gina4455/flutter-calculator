import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
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
  String _expression = '';
  String _result = '';

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
      } else if (value == '=') {
        try {
          final expression = Expression.parse(_expression);
          const evaluator = ExpressionEvaluator();
          final result = evaluator.eval(expression, {});
          _result = result.toString();
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += value;
      }
    });
  }

  Widget _buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[200], // Match background color
          //onPrimary: Colors.black,
          padding:
              const EdgeInsets.all(18), // Reduced padding for smaller buttons
          minimumSize: const Size(90, 60), // Set a smaller size for the buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Keep a slight roundness
          ),
        ),
        onPressed: () => _onButtonPressed(value),
        child: Text(value,
            style: const TextStyle(fontSize: 20)), // Reduced font size
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Calculator',
              style: TextStyle(
                color: Colors.purple, // Match title color from previous app
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'by Gina Vincent',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 15,
              ),
            ),
          ],
        ),
        backgroundColor:
            Colors.blueGrey[200], // Match background color from previous app
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.all(20), // Adjust padding for a cleaner look
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _expression,
                    style: const TextStyle(fontSize: 32, color: Colors.black54),
                  ),
                  Text(
                    _result,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('/'),
                ],
              ),
              const SizedBox(height: 30), // Add spacing for visual clarity
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('*'),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('-'),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildButton('0'),
                  _buildButton('C'),
                  _buildButton('='),
                  _buildButton('+'),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  _buildButton('.'),
                  _buildButton('%'),
                  _buildButton('√'),
                  _buildButton('mod'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
