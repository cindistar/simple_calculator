import 'package:flutter/material.dart';

typedef NumberPressedCallback = void Function(String);

class NumberButton extends StatelessWidget {
  final NumberPressedCallback onNumberPressed;
  final String number;
  const NumberButton({
    Key? key,
    required this.number,
    required this.onNumberPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(),
        ),
        onPressed: () => onNumberPressed(number),
        child: Text(number),
      ),
    );
  }
}
