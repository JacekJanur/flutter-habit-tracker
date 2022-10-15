import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {
  final controller;
  final Function() onSave;
  final Function() onCancel;

  const AlertBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
      ),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.red),
          ),
        ),
        MaterialButton(
          onPressed: onSave,
          color: Colors.green,
          child: const Text("Save"),
        ),
      ],
    );
  }
}
