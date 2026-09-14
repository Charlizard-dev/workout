import '../../../exercises/domain/entities/exercise.dart';

/// Stock exercise library shipped with the app. Custom exercises are added
/// by users at runtime; this list seeds first launch only.
const List<Exercise> seedExercises = [
  // Chest
  Exercise(id: 'ex_bench_press', name: 'Barbell Bench Press', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.shoulders], equipment: 'barbell'),
  Exercise(id: 'ex_incline_bench', name: 'Incline Barbell Bench Press', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [MuscleGroup.shoulders, MuscleGroup.triceps], equipment: 'barbell'),
  Exercise(id: 'ex_db_bench', name: 'Dumbbell Bench Press', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [MuscleGroup.triceps], equipment: 'dumbbell'),
  Exercise(id: 'ex_db_fly', name: 'Dumbbell Fly', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [], equipment: 'dumbbell'),
  Exercise(id: 'ex_cable_cross', name: 'Cable Crossover', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [], equipment: 'cable'),
  Exercise(id: 'ex_dips', name: 'Chest Dips', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [MuscleGroup.triceps], equipment: 'bodyweight'),
  Exercise(id: 'ex_pushup', name: 'Push-Up', primaryMuscle: MuscleGroup.chest, secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.core], equipment: 'bodyweight'),
  // Back
  Exercise(id: 'ex_deadlift', name: 'Barbell Deadlift', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.legs, MuscleGroup.glutes, MuscleGroup.core], equipment: 'barbell'),
  Exercise(id: 'ex_pullup', name: 'Pull-Up', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.biceps], equipment: 'bodyweight'),
  Exercise(id: 'ex_lat_pulldown', name: 'Lat Pulldown', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.biceps], equipment: 'cable'),
  Exercise(id: 'ex_barbell_row', name: 'Barbell Row', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.biceps, MuscleGroup.core], equipment: 'barbell'),
  Exercise(id: 'ex_db_row', name: 'Dumbbell Row', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.biceps], equipment: 'dumbbell'),
  Exercise(id: 'ex_seated_row', name: 'Seated Cable Row', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.biceps], equipment: 'cable'),
  Exercise(id: 'ex_face_pull', name: 'Face Pull', primaryMuscle: MuscleGroup.back, secondaryMuscles: [MuscleGroup.shoulders], equipment: 'cable'),
  Exercise(id: 'ex_shrug', name: 'Barbell Shrug', primaryMuscle: MuscleGroup.back, secondaryMuscles: [], equipment: 'barbell'),
  // Shoulders
  Exercise(id: 'ex_ohp', name: 'Overhead Press', primaryMuscle: MuscleGroup.shoulders, secondaryMuscles: [MuscleGroup.triceps, MuscleGroup.core], equipment: 'barbell'),
  Exercise(id: 'ex_db_ohp', name: 'Dumbbell Shoulder Press', primaryMuscle: MuscleGroup.shoulders, secondaryMuscles: [MuscleGroup.triceps], equipment: 'dumbbell'),
  Exercise(id: 'ex_lateral_raise', name: 'Lateral Raise', primaryMuscle: MuscleGroup.shoulders, secondaryMuscles: [], equipment: 'dumbbell'),
  Exercise(id: 'ex_rear_delt_fly', name: 'Rear Delt Fly', primaryMuscle: MuscleGroup.shoulders, secondaryMuscles: [MuscleGroup.back], equipment: 'dumbbell'),
  Exercise(id: 'ex_arnold_press', name: 'Arnold Press', primaryMuscle: MuscleGroup.shoulders, secondaryMuscles: [MuscleGroup.triceps], equipment: 'dumbbell'),
  Exercise(id: 'ex_upright_row', name: 'Upright Row', primaryMuscle: MuscleGroup.shoulders, secondaryMuscles: [MuscleGroup.triceps], equipment: 'barbell'),
  // Biceps
  Exercise(id: 'ex_barbell_curl', name: 'Barbell Curl', primaryMuscle: MuscleGroup.biceps, secondaryMuscles: [], equipment: 'barbell'),
  Exercise(id: 'ex_db_curl', name: 'Dumbbell Curl', primaryMuscle: MuscleGroup.biceps, secondaryMuscles: [], equipment: 'dumbbell'),
  Exercise(id: 'ex_hammer_curl', name: 'Hammer Curl', primaryMuscle: MuscleGroup.biceps, secondaryMuscles: [], equipment: 'dumbbell'),
  Exercise(id: 'ex_preacher_curl', name: 'Preacher Curl', primaryMuscle: MuscleGroup.biceps, secondaryMuscles: [], equipment: 'machine'),
  Exercise(id: 'ex_cable_curl', name: 'Cable Curl', primaryMuscle: MuscleGroup.biceps, secondaryMuscles: [], equipment: 'cable'),
  Exercise(id: 'ex_chinup', name: 'Chin-Up', primaryMuscle: MuscleGroup.biceps, secondaryMuscles: [MuscleGroup.back], equipment: 'bodyweight'),
  // Triceps
  Exercise(id: 'ex_close_bench', name: 'Close-Grip Bench Press', primaryMuscle: MuscleGroup.triceps, secondaryMuscles: [MuscleGroup.chest], equipment: 'barbell'),
  Exercise(id: 'ex_skullcrusher', name: 'Skull Crusher', primaryMuscle: MuscleGroup.triceps, secondaryMuscles: [], equipment: 'barbell'),
  Exercise(id: 'ex_pushdown', name: 'Triceps Pushdown', primaryMuscle: MuscleGroup.triceps, secondaryMuscles: [], equipment: 'cable'),
  Exercise(id: 'ex_overhead_ext', name: 'Overhead Triceps Extension', primaryMuscle: MuscleGroup.triceps, secondaryMuscles: [], equipment: 'dumbbell'),
  Exercise(id: 'ex_bench_dip', name: 'Bench Dip', primaryMuscle: MuscleGroup.triceps, secondaryMuscles: [], equipment: 'bodyweight'),
  // Legs
  Exercise(id: 'ex_squat', name: 'Barbell Back Squat', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.core], equipment: 'barbell'),
  Exercise(id: 'ex_front_squat', name: 'Front Squat', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [MuscleGroup.core], equipment: 'barbell'),
  Exercise(id: 'ex_leg_press', name: 'Leg Press', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [], equipment: 'machine'),
  Exercise(id: 'ex_lunge', name: 'Walking Lunge', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [MuscleGroup.glutes], equipment: 'dumbbell'),
  Exercise(id: 'ex_leg_extension', name: 'Leg Extension', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [], equipment: 'machine'),
  Exercise(id: 'ex_leg_curl', name: 'Leg Curl', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [], equipment: 'machine'),
  Exercise(id: 'ex_romanian_dl', name: 'Romanian Deadlift', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.back], equipment: 'barbell'),
  Exercise(id: 'ex_calf_raise', name: 'Standing Calf Raise', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [], equipment: 'machine'),
  Exercise(id: 'ex_stepup', name: 'Step-Up', primaryMuscle: MuscleGroup.legs, secondaryMuscles: [MuscleGroup.glutes], equipment: 'dumbbell'),
  // Glutes
  Exercise(id: 'ex_hip_thrust', name: 'Barbell Hip Thrust', primaryMuscle: MuscleGroup.glutes, secondaryMuscles: [MuscleGroup.legs], equipment: 'barbell'),
  Exercise(id: 'ex_glute_bridge', name: 'Glute Bridge', primaryMuscle: MuscleGroup.glutes, secondaryMuscles: [MuscleGroup.core], equipment: 'bodyweight'),
  Exercise(id: 'ex_kickback', name: 'Cable Glute Kickback', primaryMuscle: MuscleGroup.glutes, secondaryMuscles: [], equipment: 'cable'),
  Exercise(id: 'ex_sumo_dl', name: 'Sumo Deadlift', primaryMuscle: MuscleGroup.glutes, secondaryMuscles: [MuscleGroup.legs, MuscleGroup.back], equipment: 'barbell'),
  // Core
  Exercise(id: 'ex_plank', name: 'Plank', primaryMuscle: MuscleGroup.core, secondaryMuscles: [], equipment: 'bodyweight'),
  Exercise(id: 'ex_hanging_leg_raise', name: 'Hanging Leg Raise', primaryMuscle: MuscleGroup.core, secondaryMuscles: [], equipment: 'bodyweight'),
  Exercise(id: 'ex_cable_crunch', name: 'Cable Crunch', primaryMuscle: MuscleGroup.core, secondaryMuscles: [], equipment: 'cable'),
  Exercise(id: 'ex_russian_twist', name: 'Russian Twist', primaryMuscle: MuscleGroup.core, secondaryMuscles: [], equipment: 'bodyweight'),
  Exercise(id: 'ex_ab_wheel', name: 'Ab Wheel Rollout', primaryMuscle: MuscleGroup.core, secondaryMuscles: [], equipment: 'other'),
  Exercise(id: 'ex_side_plank', name: 'Side Plank', primaryMuscle: MuscleGroup.core, secondaryMuscles: [], equipment: 'bodyweight'),
  // Cardio
  Exercise(id: 'ex_treadmill', name: 'Treadmill Run', primaryMuscle: MuscleGroup.cardio, secondaryMuscles: [MuscleGroup.legs], equipment: 'machine'),
  Exercise(id: 'ex_cycling', name: 'Stationary Cycling', primaryMuscle: MuscleGroup.cardio, secondaryMuscles: [MuscleGroup.legs], equipment: 'machine'),
  Exercise(id: 'ex_rowing', name: 'Rowing Machine', primaryMuscle: MuscleGroup.cardio, secondaryMuscles: [MuscleGroup.back, MuscleGroup.legs], equipment: 'machine'),
  Exercise(id: 'ex_jump_rope', name: 'Jump Rope', primaryMuscle: MuscleGroup.cardio, secondaryMuscles: [MuscleGroup.legs], equipment: 'other'),
  Exercise(id: 'ex_burpee', name: 'Burpee', primaryMuscle: MuscleGroup.cardio, secondaryMuscles: [MuscleGroup.fullBody], equipment: 'bodyweight'),
  Exercise(id: 'ex_stair_climb', name: 'Stair Climber', primaryMuscle: MuscleGroup.cardio, secondaryMuscles: [MuscleGroup.legs], equipment: 'machine'),
  // Full Body
  Exercise(id: 'ex_clean_press', name: 'Clean & Press', primaryMuscle: MuscleGroup.fullBody, secondaryMuscles: [MuscleGroup.shoulders, MuscleGroup.legs], equipment: 'barbell'),
  Exercise(id: 'ex_snatch', name: 'Barbell Snatch', primaryMuscle: MuscleGroup.fullBody, secondaryMuscles: [MuscleGroup.shoulders, MuscleGroup.legs], equipment: 'barbell'),
  Exercise(id: 'ex_kettlebell_swing', name: 'Kettlebell Swing', primaryMuscle: MuscleGroup.fullBody, secondaryMuscles: [MuscleGroup.glutes, MuscleGroup.core], equipment: 'kettlebell'),
  Exercise(id: 'ex_farmer_walk', name: 'Farmer\u2019s Walk', primaryMuscle: MuscleGroup.fullBody, secondaryMuscles: [MuscleGroup.core], equipment: 'dumbbell'),
  Exercise(id: 'ex_thruster', name: 'Dumbbell Thruster', primaryMuscle: MuscleGroup.fullBody, secondaryMuscles: [MuscleGroup.shoulders, MuscleGroup.legs], equipment: 'dumbbell'),
];
