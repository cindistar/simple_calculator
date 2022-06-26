import 'package:flutter/material.dart';

typedef OperatorPressedCallback = void Function(String);

class OperatorButton extends StatelessWidget {
  final String operator;
  final OperatorPressedCallback onOperatorPressed;
  final bool disabled;
  const OperatorButton({
    Key? key,
    required this.operator,
    required this.onOperatorPressed,
    required this.disabled,
  }) : super(key: key);

  IconData mapOperatorToIcon() {
    switch (operator) {
      case 'x':
        return Icons.close;
      case '-':
        return Icons.remove;
      default:
        return Icons.add;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconButton(
      onPressed: disabled ? null : () => onOperatorPressed(operator),
      icon: Icon(mapOperatorToIcon()),
    ));
  }
}
