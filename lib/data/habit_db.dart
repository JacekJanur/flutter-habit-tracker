import 'package:habit/datatime/data_time.dart';
import 'package:hive_flutter/hive_flutter.dart';


final _myBox = Hive.box("Habit_DB");

class HabitDB{
  List todaysHabitList = [];

  //initial
  void createDefault(){
    todaysHabitList = [
      ["Run", false],
      ["Reading", true],
      ["Brazilian Jiu Jitsu", true]
    ];

    _myBox.put("START_DATA", todaysDateFormatted());
  }

  //load

  void loadHabits(){
    if(_myBox.get(todaysDateFormatted()==null)){
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for(int i =0; i<todaysHabitList.length; i++)
        {
          todaysHabitList[i][1]=false;
        }
    }
    else{
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  //update

  void updateHabits(){
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);
  }
}