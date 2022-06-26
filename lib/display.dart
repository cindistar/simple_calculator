import 'package:flutter/material.dart';

class Display extends StatefulWidget {
  final String display;
  const Display({
    Key? key,
    required this.display,
  }) : super(key: key);

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  int easterEgg = 0;

  void showEasterEgg(int value, BuildContext context) {
    easterEgg += value;
    if (easterEgg >= 7) {
      easterEgg = 0;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Flutter is amazing!'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('One click');
        showEasterEgg(1, context);
      },
      onDoubleTap: () {
        debugPrint('Double click');
        showEasterEgg(2, context);
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(widget.display),
          ),
        ),
      ),
    );
  }
}
