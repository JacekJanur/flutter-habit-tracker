import 'package:habit/datatime/data_time.dart';
import 'package:hive_flutter/hive_flutter.dart';


final _myBox = Hive.box("Habit_DB");

class HabitDB {
  List todaysHabitList = [];
  Map<DateTime, int>? heatMapDataSet = {};

  //initial
  void createDefault() {
    todaysHabitList = [
      ["Run", false],
      ["Reading", true],
      ["Brazilian Jiu Jitsu", true]
    ];

    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //load

  void loadHabits() {
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

  //update

  void updateHabits() {
    _myBox.put(todaysDateFormatted(), todaysHabitList);

    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

    calculateHabitPercentage();

    loadHeatMap();
  }

  void calculateHabitPercentage() {
    int count = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1]) {
        count++;
      }
    }

    String percent = todaysHabitList.isEmpty ? '0.0' : ((count) /
        todaysHabitList.length).toStringAsFixed(1);

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

    // count the number of days to load
    int daysInBetween = DateTime
        .now()
        .difference(startDate)
        .inDays;

    // go from start date to today and add each percentage to the dataset
    // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

      // split the datetime up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate
          .add(Duration(days: i))
          .year;

      // month
      int month = startDate
          .add(Duration(days: i))
          .month;

      // day
      int day = startDate
          .add(Duration(days: i))
          .day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet?.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}