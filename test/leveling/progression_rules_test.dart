import 'package:charlizard/features/leveling/domain/services/progression_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const rules = ProgressionRules();

  group('ProgressionRules.xpRequiredForLevel', () {
    test('level 1 requires the base amount', () {
      expect(rules.xpRequiredForLevel(1), 500);
    });

    test('requirements increase monotonically', () {
      var previous = rules.xpRequiredForLevel(1);
      for (var level = 2; level <= 120; level++) {
        final current = rules.xpRequiredForLevel(level);
        expect(current, greaterThan(previous),
            reason: 'level $level should cost more than level ${level - 1}');
        previous = current;
      }
    });

    test('curve is nonlinear (growth accelerates)', () {
      final early = rules.xpRequiredForLevel(3) - rules.xpRequiredForLevel(2);
      final late = rules.xpRequiredForLevel(60) - rules.xpRequiredForLevel(59);
      expect(late, greaterThan(early));
    });

    test('requirements are rounded to tens', () {
      for (var level = 1; level <= 100; level++) {
        expect(rules.xpRequiredForLevel(level) % 10, 0);
      }
    });

    test('clamps invalid levels to 1', () {
      expect(rules.xpRequiredForLevel(0), rules.xpRequiredForLevel(1));
      expect(rules.xpRequiredForLevel(-5), rules.xpRequiredForLevel(1));
    });
  });

  group('ProgressionRules.lifetimeXpForLevel / levelForLifetimeXp', () {
    test('level 1 starts at zero lifetime XP', () {
      expect(rules.lifetimeXpForLevel(1), 0);
      expect(rules.levelForLifetimeXp(0), 1);
    });

    test('level boundaries round-trip', () {
      for (var level = 1; level <= 60; level++) {
        final threshold = rules.lifetimeXpForLevel(level);
        expect(rules.levelForLifetimeXp(threshold), level,
            reason: 'threshold for level $level');
        if (threshold > 0) {
          expect(rules.levelForLifetimeXp(threshold - 1), level - 1,
              reason: 'just below level $level threshold');
        }
      }
    });
  });

  group('ranks', () {
    test('rank ladder covers every level without gaps', () {
      for (var level = 1; level <= 150; level++) {
        final rank = rules.rankForLevel(level);
        expect(rank.contains(level), isTrue,
            reason: 'level $level should fall inside ${rank.name}');
      }
    });

    test('shipped boundaries match the product spec', () {
      expect(rules.rankForLevel(1).id, 'rookie');
      expect(rules.rankForLevel(9).id, 'rookie');
      expect(rules.rankForLevel(10).id, 'bronze');
      expect(rules.rankForLevel(24).id, 'silver');
      expect(rules.rankForLevel(30).id, 'gold');
      expect(rules.rankForLevel(40).id, 'platinum');
      expect(rules.rankForLevel(50).id, 'diamond');
      expect(rules.rankForLevel(64).id, 'diamond');
      expect(rules.rankForLevel(65).id, 'master');
      expect(rules.rankForLevel(80).id, 'elite');
      expect(rules.rankForLevel(100).id, 'legend');
      expect(rules.rankForLevel(250).id, 'legend');
    });
  });

  group('titles', () {
    test('title ladder covers every level without gaps', () {
      for (var level = 1; level <= 150; level++) {
        final title = rules.titleForLevel(level);
        expect(title.contains(level), isTrue);
      }
    });

    test('shipped titles match the product spec', () {
      expect(rules.titleForLevel(1).name, 'Rookie');
      expect(rules.titleForLevel(5).name, 'Beginner');
      expect(rules.titleForLevel(10).name, 'Active');
      expect(rules.titleForLevel(15).name, 'Athlete');
      expect(rules.titleForLevel(24).name, 'Advanced Athlete');
      expect(rules.titleForLevel(30).name, 'Elite Athlete');
      expect(rules.titleForLevel(40).name, 'Power Athlete');
      expect(rules.titleForLevel(50).name, 'Champion');
      expect(rules.titleForLevel(75).name, 'Elite Champion');
      expect(rules.titleForLevel(100).name, 'Legend');
    });
  });
}
