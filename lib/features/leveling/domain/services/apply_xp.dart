import '../entities/progression.dart';
import 'progression_rules.dart';

/// Applies XP to a [UserProgression] snapshot, carrying overflow across any
/// number of level-ups. Pure domain service — persistence lives in
/// repositories; the UI never computes progression.
class ApplyXp {
  const ApplyXp(this.rules);

  final ProgressionRules rules;

  XpApplicationResult call(UserProgression before, int amount) {
    var level = before.level;
    var currentXp = before.currentXp + amount;

    // Consume XP across as many level boundaries as needed; overflow is
    // never discarded.
    var levelsGained = 0;
    while (currentXp >= rules.xpRequiredForLevel(level)) {
      currentXp -= rules.xpRequiredForLevel(level);
      level++;
      levelsGained++;
    }

    return XpApplicationResult(
      before: before,
      after: before.copyWith(
        level: level,
        currentXp: currentXp,
        xpForNextLevel: rules.xpRequiredForLevel(level),
        lifetimeXp: before.lifetimeXp + amount,
        rank: rules.rankForLevel(level),
        title: rules.titleForLevel(level),
      ),
      levelsGained: levelsGained,
      rankBefore: before.rank,
      rankAfter: rules.rankForLevel(level),
    );
  }
}
