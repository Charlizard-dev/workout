import 'package:equatable/equatable.dart';

/// Rank bands layered above levels. Boundaries are config-driven.
class Rank extends Equatable {
  const Rank({
    required this.id,
    required this.name,
    required this.minLevel,
    this.maxLevel,
  });

  final String id;
  final String name;
  final int minLevel;
  final int? maxLevel;

  bool contains(int level) =>
      level >= minLevel && (maxLevel == null || level <= maxLevel!);

  @override
  List<Object?> get props => [id, name, minLevel, maxLevel];
}

/// Level titles within/between rank bands.
class LevelTitle extends Equatable {
  const LevelTitle({required this.name, required this.minLevel, this.maxLevel});

  final String name;
  final int minLevel;
  final int? maxLevel;

  bool contains(int level) => level >= minLevel && (maxLevel == null || level <= maxLevel!);

  @override
  List<Object?> get props => [name, minLevel, maxLevel];
}

/// Snapshot of a user's full progression state at a point in time.
class UserProgression extends Equatable {
  const UserProgression({
    required this.level,
    required this.currentXp,
    required this.xpForNextLevel,
    required this.lifetimeXp,
    required this.rank,
    required this.title,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalWorkouts,
    required this.achievementsUnlocked,
    required this.achievementsTotal,
    required this.badgeCount,
    required this.challengesCompleted,
  });

  /// Current level, 1-based.
  final int level;

  /// XP accumulated within the current level.
  final int currentXp;

  /// XP required to reach [level] + 1 from zero of current level.
  final int xpForNextLevel;

  /// All XP ever earned (never resets).
  final int lifetimeXp;

  final Rank rank;
  final LevelTitle title;
  final int currentStreak;
  final int longestStreak;
  final int totalWorkouts;
  final int achievementsUnlocked;
  final int achievementsTotal;
  final int badgeCount;
  final int challengesCompleted;

  double get levelProgress =>
      xpForNextLevel == 0 ? 0 : (currentXp / xpForNextLevel).clamp(0.0, 1.0);

  int get xpUntilNextLevel => xpForNextLevel - currentXp;

  UserProgression copyWith({
    int? level,
    int? currentXp,
    int? xpForNextLevel,
    int? lifetimeXp,
    Rank? rank,
    LevelTitle? title,
    int? currentStreak,
    int? longestStreak,
    int? totalWorkouts,
    int? achievementsUnlocked,
    int? achievementsTotal,
    int? badgeCount,
    int? challengesCompleted,
  }) =>
      UserProgression(
        level: level ?? this.level,
        currentXp: currentXp ?? this.currentXp,
        xpForNextLevel: xpForNextLevel ?? this.xpForNextLevel,
        lifetimeXp: lifetimeXp ?? this.lifetimeXp,
        rank: rank ?? this.rank,
        title: title ?? this.title,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        totalWorkouts: totalWorkouts ?? this.totalWorkouts,
        achievementsUnlocked: achievementsUnlocked ?? this.achievementsUnlocked,
        achievementsTotal: achievementsTotal ?? this.achievementsTotal,
        badgeCount: badgeCount ?? this.badgeCount,
        challengesCompleted: challengesCompleted ?? this.challengesCompleted,
      );

  @override
  List<Object?> get props => [
        level, currentXp, xpForNextLevel, lifetimeXp, rank, title,
        currentStreak, longestStreak, totalWorkouts,
        achievementsUnlocked, achievementsTotal, badgeCount, challengesCompleted,
      ];
}

/// Describes the result of applying XP to a progression snapshot.
class XpApplicationResult extends Equatable {
  const XpApplicationResult({
    required this.before,
    required this.after,
    required this.levelsGained,
    this.rankBefore,
    this.rankAfter,
  });

  final UserProgression before;
  final UserProgression after;

  /// Number of levels gained (can be many for huge XP grants).
  final int levelsGained;

  final Rank? rankBefore;
  final Rank? rankAfter;

  bool get rankedUp => rankBefore != null && rankAfter != null && rankBefore!.id != rankAfter!.id;

  @override
  List<Object?> get props => [before, after, levelsGained, rankBefore, rankAfter];
}
