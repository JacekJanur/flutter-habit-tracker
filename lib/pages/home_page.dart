import 'package:flutter/material.dart';
import 'package:habit/components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todaysHabitList = [
    ["Run", false],
    ["Reading", true]
  ];

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: ListView.builder(
          itemCount: todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(name: todaysHabitList[index][0], completed: todaysHabitList[index][1], onChanged: (value) => checkBoxTapped(value, index) );
            }
        )
    );
  }
}
