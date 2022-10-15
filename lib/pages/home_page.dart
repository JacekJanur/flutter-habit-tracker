import 'package:flutter/material.dart';
import 'package:habit/components/enter-habit-name.dart';
import 'package:habit/components/floating_button.dart';
import 'package:habit/components/habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todaysHabitList = [
    ["Run", false],
    ["Reading", true],
    ["Brazilian Jiu Jitsu", true]
  ];

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value!;
    });
  }

  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterHabitName(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );

  }

  void saveNewHabit(){
      setState(() {
        todaysHabitList.add([_newHabitNameController.text, false]);
      });
      Navigator.of(context).pop();
  }

  void cancelNewHabit(){
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        floatingActionButton: FloatingButton(
          addHabit: createNewHabit,
        ),
        body: ListView.builder(
            itemCount: todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                  name: todaysHabitList[index][0],
                  completed: todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index));
            }));
  }
}
