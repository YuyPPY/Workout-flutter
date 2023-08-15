import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_tracker_app/components/exercise_tile.dart';

import '../data/workout_data.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({
    super.key,
    required this.workoutName,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // checkbox was tapped
  void onCheckChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  // text controllers
  final exerciseNameController = TextEditingController();
  final weightNameController = TextEditingController();
  final repsNameController = TextEditingController();
  final setsNameController = TextEditingController();

  // create a new exercise

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(' Add a new exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //exericse name
            TextField(
              controller: exerciseNameController,
              decoration: InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),

            // weight
            TextField(
              controller: weightNameController,
              decoration: InputDecoration(
                labelText: 'Weight',
              ),
            ),

            //reps

            TextField(
              controller: repsNameController,
              decoration: InputDecoration(
                labelText: 'Reps',
              ),
            ),
            // sets

            TextField(
              controller: setsNameController,
              decoration: InputDecoration(
                labelText: 'Sets',
              ),
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text("Save"),
          ),

          // cancal button
          MaterialButton(
            onPressed: cancel,
            child: Text("cancel"),
          ),
        ],
      ),
    );
  }

  // save workout
  void save() {
// get exercise name from text controller
    String newExeciseName = exerciseNameController.text;
    String weight = weightNameController.text;
    String reps = repsNameController.text;
    String sets = setsNameController.text;
    // add workout to workoutdata list
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      newExeciseName,
      weight,
      reps,
      sets,
    );
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

// cancel workout
  void cancel() {
    // pop dialog box
    Navigator.pop(context);
    clear();
  }

// clear Controller
  void clear() {
    exerciseNameController.clear();
    weightNameController.clear();
    repsNameController.clear();
    setsNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewExercise,
          child: Icon(
            Icons.add,
          ),
        ),
        body: ListView.builder(
          itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExericseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckChanged: (val) => onCheckChanged(
              widget.workoutName,
              value
                  .getRelevantWorkout(widget.workoutName)
                  .exercises[index]
                  .name,
            ),
          ),
        ),
      ),
    );
  }
}
