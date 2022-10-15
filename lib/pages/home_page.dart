import 'package:flutter/material.dart';
import 'package:habit/components/alert-box.dart';
import 'package:habit/components/floating_button.dart';
import 'package:habit/components/habit_tile.dart';
import 'package:habit/data/habit_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HabitDB db = HabitDB();
  final _myBox = Hive.box("Habit_DB");

  @override
  void initState() {

    if(_myBox.get("CURRENT_HABIT_LIST")==null){
      db.createDefault();
    }else{
      db.loadHabits();
    }

    db.updateHabits();

    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateHabits();
  }

  final _newHabitNameController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelAlertBox,
        );
      },
    );
  }

  void saveNewHabit(){
      setState(() {
        db.todaysHabitList.add([_newHabitNameController.text, false]);
      });
      cancelAlertBox();
      db.updateHabits();
  }

  void cancelAlertBox(){
    _newHabitNameController.clear();
      Navigator.of(context).pop();
  }

  void openHabitSetting(int index){
    _newHabitNameController.text = db.todaysHabitList[index][0];
    showDialog(context: context, builder: (context){
      return AlertBox(controller: _newHabitNameController, onSave: () => saveExistingHabit(index), onCancel: cancelAlertBox);
    });
  }

  void deleteHabit(int index){
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateHabits();
  }

  void saveExistingHabit(int index){
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    cancelAlertBox();
    db.updateHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        floatingActionButton: FloatingButton(
          addHabit: createNewHabit,
        ),
        body: ListView.builder(
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                  name: db.todaysHabitList[index][0],
                  completed: db.todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingTapped: (context) => openHabitSetting(index),
                  deleteTapped: (context) => deleteHabit(index),
              );
            }));
  }
}
