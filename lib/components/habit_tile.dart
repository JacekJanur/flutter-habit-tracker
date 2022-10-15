import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String name;
  final bool completed;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingTapped;
  final Function(BuildContext)? deleteTapped;

  const HabitTile(
      {Key? key,
      required this.name,
      required this.completed,
      required this.onChanged,
      required this.settingTapped,
      required this.deleteTapped,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(onPressed: settingTapped,
            backgroundColor: Colors.grey.shade800,
              icon: Icons.settings,
            ),
            SlidableAction(onPressed: deleteTapped,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Checkbox(value: completed, onChanged: onChanged),
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
