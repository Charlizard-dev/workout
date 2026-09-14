import '../entities/progression.dart';

/// Canonical XP curve and rank/title resolution.
///
/// Pure domain service — no I/O, no Flutter, fully unit-testable. The UI
/// never computes progression rules; it always asks this service.
class ProgressionRules {
  const ProgressionRules({
    this.ranks = defaultRanks,
    this.titles = defaultTitles,
    this.baseXp = 500,
    this.growthXp = 100,
    this.curve = 1.06,
  });

  /// XP needed to advance FROM level [level] TO level [level]+1.
  ///
  /// Nonlinear: base 500 + growth scaled by a compounding curve, so long-term
  /// progression keeps pace with a user's increasing training capacity.
  int xpRequiredForLevel(int level) {
    final l = level < 1 ? 1 : level;
    final raw = baseXp + growthXp * _pow(curve, l - 1) * (l - 1);
    return (raw / 10).ceil() * 10; // round to friendly tens
  }

  /// Total lifetime XP required to REACH [level] (level 1 == 0 XP).
  int lifetimeXpForLevel(int level) {
    var total = 0;
    for (var l = 1; l < level; l++) {
      total += xpRequiredForLevel(l);
    }
    return total;
  }

  /// Resolves the level for a lifetime XP total.
  int levelForLifetimeXp(int lifetimeXp) {
    var level = 1;
    var remaining = lifetimeXp;
    while (remaining >= xpRequiredForLevel(level)) {
      remaining -= xpRequiredForLevel(level);
      level++;
    }
    return level;
  }

  Rank rankForLevel(int level) => ranks.firstWhere(
        (r) => r.contains(level),
        orElse: () => ranks.first,
      );

  LevelTitle titleForLevel(int level) => titles.firstWhere(
        (t) => t.contains(level),
        orElse: () => titles.first,
      );

  final List<Rank> ranks;
  final List<LevelTitle> titles;
  final int baseXp;
  final int growthXp;
  final double curve;

  static double _pow(double base, int exponent) {
    var result = 1.0;
    for (var i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }
}

/// Shipped rank ladder. Configurable via [ProgressionRules.ranks].
const List<Rank> defaultRanks = [
  Rank(id: 'rookie', name: 'ROOKIE', minLevel: 1, maxLevel: 9),
  Rank(id: 'bronze', name: 'BRONZE', minLevel: 10, maxLevel: 19),
  Rank(id: 'silver', name: 'SILVER', minLevel: 20, maxLevel: 29),
  Rank(id: 'gold', name: 'GOLD', minLevel: 30, maxLevel: 39),
  Rank(id: 'platinum', name: 'PLATINUM', minLevel: 40, maxLevel: 49),
  Rank(id: 'diamond', name: 'DIAMOND', minLevel: 50, maxLevel: 64),
  Rank(id: 'master', name: 'MASTER', minLevel: 65, maxLevel: 79),
  Rank(id: 'elite', name: 'ELITE', minLevel: 80, maxLevel: 99),
  Rank(id: 'legend', name: 'LEGEND', minLevel: 100),
];

/// Shipped level titles.
const List<LevelTitle> defaultTitles = [
  LevelTitle(name: 'Rookie', minLevel: 1, maxLevel: 4),
  LevelTitle(name: 'Beginner', minLevel: 5, maxLevel: 9),
  LevelTitle(name: 'Active', minLevel: 10, maxLevel: 14),
  LevelTitle(name: 'Athlete', minLevel: 15, maxLevel: 19),
  LevelTitle(name: 'Advanced Athlete', minLevel: 20, maxLevel: 29),
  LevelTitle(name: 'Elite Athlete', minLevel: 30, maxLevel: 39),
  LevelTitle(name: 'Power Athlete', minLevel: 40, maxLevel: 49),
  LevelTitle(name: 'Champion', minLevel: 50, maxLevel: 74),
  LevelTitle(name: 'Elite Champion', minLevel: 75, maxLevel: 99),
  LevelTitle(name: 'Legend', minLevel: 100),
];
