import 'package:flutter/material.dart';
import 'package:workout_tracker_app/data/hive.database.dart';
import 'package:workout_tracker_app/datetime/date_time.dart';

import '../models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDataBase();
  /*
  Workout DATA STRUCTURE

  -this overall list contsins the different workouts
  -each workout has a name, and lisyt of exercise


  
   */

  List<Workout> workoutList = [
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(
          name: "Bicep Curls",
          sets: "3",
          reps: "10",
          weight: "10",
        ),
      ],
    ),
    Workout(
      name: "Lower Body",
      exercises: [
        Exercise(
          name: "Squats",
          sets: "3",
          reps: "10",
          weight: "10",
        ),
      ],
    ),
  ];
  // if there are workouts already  in database, then get that workout list otherwise use default workouts
  void iniTalizeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    }
    // otherwise use default workouts
    else {
      db.saveToDatabase(workoutList);
    }
    // load heat map
    loadHeatMap();
  }

  // get the list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  //get lenght of a given workout
  int numberOfExerciseInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // add a workout
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
  }

  //add a exercise
  void addExercise(String workoutName, String execiseName, String weight,
      String reps, String sets) {
    // find the  relevant workout

    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
      Exercise(
        name: execiseName,
        weight: weight,
        reps: reps,
        sets: sets,
      ),
    );
    notifyListeners();
    // save to database

    db.saveToDatabase(workoutList);
  }

  // check off exercise
  void checkOffExercise(String workoutName, String exerciseName) {
    //get length of a given workout
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    //check off boolean to show user completed the exercise

    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    print('tapped');

    notifyListeners();
    // save to database
    db.saveToDatabase(workoutList);
    // load heat map
    loadHeatMap();
  }

  //return relevant workout oblect ,given a workout name
  Workout getRelevantWorkout(String workoutName) {
    // find the  relevant workout
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  //return relevant exercise object, given a workout name +exercise name

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // Find relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    // then find the relevant exercise in that workout
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relevantExercise;
  }

  //get start date
  String getStartDate() {
    return db.getStartDate();
  }

  /*
  

         HEAT MAP


  */
  Map<DateTime, int> heatMapDataSet = {};

  void loadHeatMap() {
    DateTime startDate = createDdateTimeObject(getStartDate());

    // count the number of day to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    // go from start date to today , and add each completion status to the dataset
    // "COMPLETION_STATUS_yyyymmdd" will be the key in the database

    for (int i = 0; i <= daysInBetween + 1; i++) {
      String yyyymmdd =
          convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));

// completion status = 0 or 1
      int completionStatus = db.getCompletionStatus(yyyymmdd);

      // year
      int year = startDate.add(Duration(days: i)).year;

      // month
      int month = startDate.add(Duration(days: i)).month;

      //day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus
      };

      // add to the heat map dataset
      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
