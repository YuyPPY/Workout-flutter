import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExericseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckChanged;
  ExericseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[400],
      child: ListTile(
        title: Text(
          exerciseName,
        ),
        subtitle: Row(
          children: [
            // weight
            Chip(
              label: Text(
                "${weight} Kg",
              ),
            ),

            // reps
            Chip(
              label: Text(
                "${reps} reps",
              ),
            ),

            // sets
            Chip(
              label: Text(
                "${sets} sets",
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckChanged!(value),
        ),
      ),
    );
  }
}
