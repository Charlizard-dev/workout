/// XP policy for workouts. Pure domain — one source of truth for reward
/// values so the summary, engine, and tests can never disagree.
class XpPolicy {
  const XpPolicy({
    this.workoutCompleted = 100,
    this.scheduledWorkoutBonus = 25,
    this.fullRoutineBonus = 30,
    this.personalRecordXp = 50,
    this.longWorkoutMinutes = 45,
    this.longWorkoutBonus = 20,
    this.weeklyGoalWorkouts = 5,
    this.weeklyGoalBonus = 100,
    this.streakMilestones = const {3: 25, 7: 100, 14: 250, 30: 500, 100: 1000},
  });

  final int workoutCompleted;
  final int scheduledWorkoutBonus;
  final int fullRoutineBonus;
  final int personalRecordXp;
  final int longWorkoutMinutes;
  final int longWorkoutBonus;
  final int weeklyGoalWorkouts;
  final int weeklyGoalBonus;
  final Map<int, int> streakMilestones;

  int? streakReward(int streakDays) => streakMilestones[streakDays];

  bool isLongWorkout(int minutes) => minutes >= longWorkoutMinutes;
}
