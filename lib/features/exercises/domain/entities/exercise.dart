import 'package:equatable/equatable.dart';

/// Muscle groups are typed to keep charts/filters typo-free.
enum MuscleGroup {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  legs,
  glutes,
  core,
  cardio,
  fullBody,
}

extension MuscleGroupX on MuscleGroup {
  String get label => switch (this) {
        MuscleGroup.chest => 'Chest',
        MuscleGroup.back => 'Back',
        MuscleGroup.shoulders => 'Shoulders',
        MuscleGroup.biceps => 'Biceps',
        MuscleGroup.triceps => 'Triceps',
        MuscleGroup.legs => 'Legs',
        MuscleGroup.glutes => 'Glutes',
        MuscleGroup.core => 'Core',
        MuscleGroup.cardio => 'Cardio',
        MuscleGroup.fullBody => 'Full Body',
      };
}

/// A single exercise in the library (stock or user-created).
class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.name,
    required this.primaryMuscle,
    this.secondaryMuscles = const [],
    this.isCustom = false,
    this.isFavorite = false,
    this.equipment,
    this.lastUsedAt,
  });

  final String id;
  final String name;
  final MuscleGroup primaryMuscle;
  final List<MuscleGroup> secondaryMuscles;
  final bool isCustom;
  final bool isFavorite;
  final String? equipment;
  final DateTime? lastUsedAt;

  Exercise copyWith({
    String? name,
    MuscleGroup? primaryMuscle,
    List<MuscleGroup>? secondaryMuscles,
    bool? isCustom,
    bool? isFavorite,
    String? equipment,
    DateTime? lastUsedAt,
  }) =>
      Exercise(
        id: id,
        name: name ?? this.name,
        primaryMuscle: primaryMuscle ?? this.primaryMuscle,
        secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
        isCustom: isCustom ?? this.isCustom,
        isFavorite: isFavorite ?? this.isFavorite,
        equipment: equipment ?? this.equipment,
        lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      );

  @override
  List<Object?> get props =>
      [id, name, primaryMuscle, secondaryMuscles, isCustom, isFavorite, equipment, lastUsedAt];
}
