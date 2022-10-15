import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {

  final Function()? addHabit;

  const FloatingButton({Key? key, required this.addHabit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: addHabit,
      child: Icon(Icons.add),
    );
  }
}
