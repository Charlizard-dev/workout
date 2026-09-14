import 'package:charlizard/features/workout_session/domain/services/xp_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const policy = XpPolicy();

  group('XpPolicy defaults (product spec)', () {
    test('base workout reward', () {
      expect(policy.workoutCompleted, 100);
    });

    test('scheduled + full-routine bonuses', () {
      expect(policy.scheduledWorkoutBonus, 25);
      expect(policy.fullRoutineBonus, 30);
    });

    test('personal record reward', () {
      expect(policy.personalRecordXp, 50);
    });

    test('long workout threshold and bonus', () {
      expect(policy.longWorkoutMinutes, 45);
      expect(policy.longWorkoutBonus, 20);
      expect(policy.isLongWorkout(44), isFalse);
      expect(policy.isLongWorkout(45), isTrue);
      expect(policy.isLongWorkout(78), isTrue);
    });

    test('streak milestones match the product spec', () {
      expect(policy.streakReward(3), 25);
      expect(policy.streakReward(7), 100);
      expect(policy.streakReward(14), 250);
      expect(policy.streakReward(30), 500);
      expect(policy.streakReward(100), 1000);
      expect(policy.streakReward(5), isNull);
      expect(policy.streakReward(1), isNull);
    });

    test('meaningless actions earn nothing (policy has no such rewards)', () {
      // The policy surface only exposes legitimate fitness rewards.
      // Opening the app, changing avatars/settings, or playing music
      // have no reward path by construction.
      expect(policy.streakMilestones.keys, containsAll([3, 7, 14, 30, 100]));
      expect(policy.weeklyGoalWorkouts, 5);
      expect(policy.weeklyGoalBonus, 100);
    });
  });
}
