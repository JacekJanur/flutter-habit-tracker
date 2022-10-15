import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {

  final String name;
  final bool completed;
  final Function(bool?)? onChanged;

  const HabitTile({Key? key, required this.name, required this.completed, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Checkbox(value: completed, onChanged: onChanged),
            Text(name),
          ],
        ),
      ),
    );
  }
}
