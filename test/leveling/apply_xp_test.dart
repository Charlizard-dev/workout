import 'package:charlizard/features/leveling/domain/entities/progression.dart';
import 'package:charlizard/features/leveling/domain/services/apply_xp.dart';
import 'package:charlizard/features/leveling/domain/services/progression_rules.dart';
import 'package:flutter_test/flutter_test.dart';

UserProgression _snapshot({
  required int level,
  required int currentXp,
  required int lifetimeXp,
}) {
  const rules = ProgressionRules();
  return UserProgression(
    level: level,
    currentXp: currentXp,
    xpForNextLevel: rules.xpRequiredForLevel(level),
    lifetimeXp: lifetimeXp,
    rank: rules.rankForLevel(level),
    title: rules.titleForLevel(level),
    currentStreak: 0,
    longestStreak: 0,
    totalWorkouts: 0,
    achievementsUnlocked: 0,
    achievementsTotal: 18,
    badgeCount: 0,
    challengesCompleted: 0,
  );
}

void main() {
  const rules = ProgressionRules();
  const apply = ApplyXp(rules);

  group('ApplyXp', () {
    test('adds XP within the current level', () {
      final before = _snapshot(level: 1, currentXp: 100, lifetimeXp: 100);
      final result = apply(before, 50);

      expect(result.levelsGained, 0);
      expect(result.after.level, 1);
      expect(result.after.currentXp, 150);
      expect(result.after.lifetimeXp, 150);
      expect(result.rankedUp, isFalse);
    });

    test('levels up exactly at the boundary with zero remainder', () {
      final need = rules.xpRequiredForLevel(1); // 500
      final before = _snapshot(level: 1, currentXp: 0, lifetimeXp: 0);
      final result = apply(before, need);

      expect(result.levelsGained, 1);
      expect(result.after.level, 2);
      expect(result.after.currentXp, 0);
      expect(result.after.lifetimeXp, need);
    });

    test('carries overflow into the next level (never discards XP)', () {
      final need = rules.xpRequiredForLevel(1);
      final before = _snapshot(level: 1, currentXp: 0, lifetimeXp: 0);
      final result = apply(before, need + 120);

      expect(result.levelsGained, 1);
      expect(result.after.level, 2);
      expect(result.after.currentXp, 120);
      expect(result.after.lifetimeXp, need + 120);
    });

    test('processes multiple level-ups from a single grant', () {
      final before = _snapshot(level: 1, currentXp: 0, lifetimeXp: 0);
      // Enough for several levels.
      final grant = rules.lifetimeXpForLevel(6) + 42;
      final result = apply(before, grant);

      expect(result.after.level, 6);
      expect(result.after.currentXp, 42);
      expect(result.after.lifetimeXp, grant);
      expect(result.levelsGained, 5);
    });

    test('result lifetime XP always equals before + grant (audit invariant)', () {
      final before = _snapshot(level: 24, currentXp: 2480 - 0, lifetimeXp: 50000);
      for (final grant in [1, 50, 220, 4000, 100000]) {
        final result = apply(before, grant);
        expect(result.after.lifetimeXp, before.lifetimeXp + grant);
      }
    });

    test('updates rank and title on promotion', () {
      // Level 9 (rookie) -> level 10 (bronze) boundary.
      final threshold9 = rules.lifetimeXpForLevel(9);
      final before = _snapshot(
        level: 9,
        currentXp: rules.xpRequiredForLevel(9) - 1,
        lifetimeXp: threshold9 + rules.xpRequiredForLevel(9) - 1,
      );
      final result = apply(before, 1);

      expect(result.after.level, 10);
      expect(result.after.rank.id, 'bronze');
      expect(result.after.title.name, 'Active');
      expect(result.rankedUp, isTrue);
      expect(result.rankBefore?.id, 'rookie');
      expect(result.rankAfter?.id, 'bronze');
    });

    test('rankedUp is false when the rank does not change', () {
      final before = _snapshot(level: 24, currentXp: 0, lifetimeXp: 99999);
      final result = apply(before, 10);
      expect(result.rankedUp, isFalse);
    });
  });
}
