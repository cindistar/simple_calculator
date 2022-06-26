import 'package:flutter/material.dart';
import 'package:simple_calculator_app/display.dart';
import 'package:simple_calculator_app/number_button.dart';
import 'package:simple_calculator_app/operator_button.dart';
import 'package:simple_calculator_app/theme.dart';

const appName = 'Simple Calculator';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode currentThemeMode = ThemeMode.light;

  void toggledThemeMode() {
    setState(() {
      currentThemeMode = currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      themeMode: currentThemeMode,
      theme: SimpleCalculatorTheme.light,
      darkTheme: SimpleCalculatorTheme.dark,
      home: SimpleCalculator(
        onThemeModePressed: toggledThemeMode,
      ),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  final VoidCallback onThemeModePressed;
  const SimpleCalculator({Key? key, required this.onThemeModePressed}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  static const operators = ['x', '-', '+'];
  String display = '0';
  String firstNumber = '';
  String operator = '';
  String secondNumber = '';
  double progress = 0.0;
  bool disableOperatorButton = false;

  void insert(String char) {
    if (char == '0') {
      if (operator.isEmpty && firstNumber.isEmpty) return;
      if (operator.isNotEmpty && secondNumber.isEmpty) return;
    }
    if (operators.contains(char)) {
      if (firstNumber.isEmpty) {
        firstNumber = '0';
      }
      operator = char;
    } else {
      if (operator.isEmpty) {
        firstNumber += char;
      } else {
        secondNumber += char;
      }
    }
    setState(() {
      if (operator.isEmpty) {
        display = firstNumber;
        progress = 0.33;
      } else {
        if (secondNumber.isEmpty) {
          display = '$firstNumber $operator';
          progress = 0.66;
        } else {
          display = '$firstNumber $operator $secondNumber';
          progress = 1.0;
          disableOperatorButton = true;
        }
      }
    });
  }

  void clear() {
    firstNumber = '';
    operator = '';
    secondNumber = '';
    setState(() {
      display = '0';
      progress = 0.0;
      disableOperatorButton = false;
    });
  }

  void calculate() {
    final number1 = int.parse(firstNumber);
    final number2 = int.parse(secondNumber);
    int result = 0;

    switch (operator) {
      case 'x':
        result = number1 * number2;
        break;
      case '-':
        result = number1 - number2;
        break;
      default:
        result = number1 + number2;
    }

    firstNumber = result.toString();
    secondNumber = '';
    operator = '-';
    setState(() {
      display = result.toString();
      progress = 0.33;
      disableOperatorButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          IconButton(
            onPressed: widget.onThemeModePressed,
            icon: Icon(
              theme.brightness == Brightness.light ? Icons.dark_mode : Icons.light_mode,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: FloatingActionButton(
          onPressed: clear,
          child: const Text('C'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Display(display: display),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Center(
              child: LinearProgressIndicator(
                backgroundColor: theme.scaffoldBackgroundColor,
                value: progress,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumberButton(number: '7', onNumberPressed: insert),
                NumberButton(number: '8', onNumberPressed: insert),
                NumberButton(number: '9', onNumberPressed: insert),
                OperatorButton(
                  operator: 'x',
                  onOperatorPressed: insert,
                  disabled: disableOperatorButton,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumberButton(number: '4', onNumberPressed: insert),
                NumberButton(number: '5', onNumberPressed: insert),
                NumberButton(number: '6', onNumberPressed: insert),
                OperatorButton(
                  operator: '-',
                  onOperatorPressed: insert,
                  disabled: disableOperatorButton,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumberButton(number: '1', onNumberPressed: insert),
                NumberButton(number: '2', onNumberPressed: insert),
                NumberButton(number: '3', onNumberPressed: insert),
                OperatorButton(
                  operator: '+',
                  onOperatorPressed: insert,
                  disabled: disableOperatorButton,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 3,
                  child: TextButton(
                    onPressed: () => insert('0'),
                    child: const Text('0'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      onPressed: calculate,
                      child: const Text('='),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
