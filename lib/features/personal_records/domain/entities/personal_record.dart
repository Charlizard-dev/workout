import 'package:equatable/equatable.dart';


/// The kind of record being tracked for an exercise.
enum PersonalRecordType { heaviestWeight, mostReps, bestSet, highestVolume, estimatedOneRm }

extension PersonalRecordTypeX on PersonalRecordType {
  String get label => switch (this) {
        PersonalRecordType.heaviestWeight => 'Heaviest Weight',
        PersonalRecordType.mostReps => 'Most Reps',
        PersonalRecordType.bestSet => 'Best Set',
        PersonalRecordType.highestVolume => 'Highest Volume',
        PersonalRecordType.estimatedOneRm => 'Estimated 1RM',
      };
}

/// A personal record for one exercise.
class PersonalRecord extends Equatable {
  const PersonalRecord({
    required this.id,
    required this.userId,
    required this.exerciseId,
    required this.exerciseName,
    required this.type,
    required this.value,
    required this.achievedAt,
    this.weightKg,
    this.reps,
    this.previousValue,
    this.workoutSessionId,
  });

  final String id;
  final String userId;
  final String exerciseId;
  final String exerciseName;
  final PersonalRecordType type;

  /// Comparable metric for [type]: kg, reps, volume, or estimated 1RM.
  final double value;
  final double? weightKg;
  final int? reps;
  final double? previousValue;
  final DateTime achievedAt;
  final String? workoutSessionId;

  String formatValue() => switch (type) {
        PersonalRecordType.mostReps => '${reps ?? value.toInt()} reps',
        _ => _formatKg(value),
      };

  static String _formatKg(double kg) {
    final rounded = (kg * 2).round() / 2; // nearest 0.5
    return rounded == rounded.roundToDouble() ? '${rounded.toInt()} kg' : '${rounded.toStringAsFixed(1)} kg';
  }

  @override
  List<Object?> get props =>
      [id, userId, exerciseId, exerciseName, type, value, weightKg, reps, previousValue, achievedAt, workoutSessionId];
}
