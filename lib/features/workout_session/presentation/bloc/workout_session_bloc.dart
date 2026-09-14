import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/complete_workout.dart';
import '../../data/repositories/workout_session_repository_impl.dart';
import '../../domain/entities/workout_completion.dart';
import '../../domain/entities/workout_session.dart';
import '../../domain/services/xp_policy.dart';

sealed class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

final class SessionStarted extends SessionEvent {
  const SessionStarted(this.session);

  final WorkoutSession session;

  @override
  List<Object?> get props => [session];
}

final class SessionResumed extends SessionEvent {
  const SessionResumed(this.session);

  final WorkoutSession session;

  @override
  List<Object?> get props => [session];
}

final class SetCompleted extends SessionEvent {
  const SetCompleted(this.exerciseId, this.setId, {this.weightKg, this.reps});

  final String exerciseId;
  final String setId;
  final double? weightKg;
  final int? reps;

  @override
  List<Object?> get props => [exerciseId, setId, weightKg, reps];
}

final class SetUpdated extends SessionEvent {
  const SetUpdated(this.exerciseId, this.setId, {this.weightKg, this.reps});

  final String exerciseId;
  final String setId;
  final double? weightKg;
  final int? reps;

  @override
  List<Object?> get props => [exerciseId, setId, weightKg, reps];
}

final class RestStarted extends SessionEvent {
  const RestStarted(this.duration);

  final Duration duration;

  @override
  List<Object?> get props => [duration];
}

final class RestAdjusted extends SessionEvent {
  const RestAdjusted(this.delta);

  final Duration delta;

  @override
  List<Object?> get props => [delta];
}

final class RestSkipped extends SessionEvent {
  const RestSkipped();
}

final class _RestTicked extends SessionEvent {
  const _RestTicked();
}

final class WorkoutFinished extends SessionEvent {
  const WorkoutFinished();
}

final class WorkoutAbandoned extends SessionEvent {
  const WorkoutAbandoned();
}

final class FocusExercise extends SessionEvent {
  const FocusExercise(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class SpotifySessionInfoChanged extends SessionEvent {
  const SpotifySessionInfoChanged({this.spotifyUsed, this.tracksPlayed, this.playlistUsed});

  final bool? spotifyUsed;
  final int? tracksPlayed;
  final bool? playlistUsed;

  @override
  List<Object?> get props => [spotifyUsed, tracksPlayed, playlistUsed];
}

/// ---------------------------------------------------------------- States

sealed class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object?> get props => [];
}

final class SessionIdle extends SessionState {
  const SessionIdle();
}

final class SessionInactive extends SessionState {
  const SessionInactive();
}

/// Live session state.
class SessionActive extends SessionState {
  const SessionActive({
    required this.session,
    required this.currentExerciseIndex,
    this.spottingExerciseId,
    this.spottingSetId,
    this.sessionXpPreview = 0,
  });

  final WorkoutSession session;
  final int currentExerciseIndex;

  /// UI focus (which set row is "next").
  final String? spottingExerciseId;
  final String? spottingSetId;

  /// Informational only — never awarded until completion.
  final int sessionXpPreview;

  SessionExercise get currentExercise =>
      session.exercises[currentExerciseIndex.clamp(0, session.exercises.length - 1)];

  int get completedSetCount =>
      session.exercises.fold(0, (sum, e) => sum + e.completedSets.length);

  int get plannedSetCount =>
      session.exercises.fold(0, (sum, e) => sum + e.sets.length);

  double get progress => plannedSetCount == 0
      ? 0
      : (completedSetCount / plannedSetCount).clamp(0.0, 1.0);

  SessionActive copyWith({
    WorkoutSession? session,
    int? currentExerciseIndex,
    String? spottingExerciseId,
    String? spottingSetId,
    int? sessionXpPreview,
    bool clearSpotting = false,
  }) =>
      SessionActive(
        session: session ?? this.session,
        currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
        spottingExerciseId: clearSpotting ? null : (spottingExerciseId ?? this.spottingExerciseId),
        spottingSetId: clearSpotting ? null : (spottingSetId ?? this.spottingSetId),
        sessionXpPreview: sessionXpPreview ?? this.sessionXpPreview,
      );

  @override
  List<Object?> get props => [
        session, currentExerciseIndex, spottingExerciseId,
        spottingSetId, sessionXpPreview,
      ];
}

/// Rest countdown overlay state; [SessionActive] fields remain available.
class SessionResting extends SessionActive {
  const SessionResting({
    required super.session,
    required super.currentExerciseIndex,
    required this.remaining,
    required this.totalRest,
    super.spottingExerciseId,
    super.spottingSetId,
    super.sessionXpPreview,
  });

  final Duration remaining;
  final Duration totalRest;

  double get restProgress =>
      totalRest.inSeconds == 0 ? 1 : 1 - (remaining.inSeconds / totalRest.inSeconds);

  @override
  List<Object?> get props => [...super.props, remaining, totalRest];
}

final class SessionCompleting extends SessionState {
  const SessionCompleting();
}

final class SessionComplete extends SessionState {
  const SessionComplete(this.result);

  final WorkoutCompletionResult result;

  @override
  List<Object?> get props => [result];
}

final class SessionError extends SessionState {
  const SessionError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// ------------------------------------------------------------------ Bloc

/// Drives the live workout: set logging, rest countdown, autosave, and the
/// completion cascade. The timer lives here, never in widgets.
class WorkoutSessionBloc extends Bloc<SessionEvent, SessionState> {
  WorkoutSessionBloc({
    required WorkoutSessionRepositoryImpl sessionRepository,
    required CompleteWorkout completeWorkout,
    XpPolicy xpPolicy = const XpPolicy(),
    Future<void> Function()? onRestComplete,
  })  : _sessions = sessionRepository,
        _completeWorkout = completeWorkout, // ignore: prefer_initializing_formals
        _xp = xpPolicy,
        _onRestComplete = onRestComplete, // ignore: prefer_initializing_formals
        super(const SessionIdle()) {
    on<SessionStarted>(_onStarted);
    on<SessionResumed>(_onResumed);
    on<SetCompleted>(_onSetCompleted);
    on<SetUpdated>(_onSetUpdated);
    on<RestStarted>(_onRestStarted);
    on<RestAdjusted>(_onRestAdjusted);
    on<RestSkipped>(_onRestSkipped);
    on<_RestTicked>(_onRestTicked);
    on<WorkoutFinished>(_onFinished);
    on<WorkoutAbandoned>(_onAbandoned);
    on<FocusExercise>(_onFocusExercise);
    on<SpotifySessionInfoChanged>(_onSpotifyInfo);
  }

  final WorkoutSessionRepositoryImpl _sessions;
  final CompleteWorkout _completeWorkout;
  final XpPolicy _xp;

  /// Fired exactly when a rest countdown reaches zero naturally.
  final Future<void> Function()? _onRestComplete;

  Timer? _restTimer;

  /// Session start reference for duration; reset on start/resume.
  DateTime _sessionStart = DateTime.now();

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }

  Future<void> _onStarted(SessionStarted event, Emitter<SessionState> emit) async {
    _restTimer?.cancel();
    _sessionStart = event.session.startedAt;
    final next = _firstIncompleteExercise(event.session);
    emit(SessionActive(
      session: event.session,
      currentExerciseIndex: next,
      spottingExerciseId: _nextSpotting(event.session).$1,
      spottingSetId: _nextSpotting(event.session).$2,
    ));
  }

  (String?, String?) _nextSpotting(WorkoutSession session) {
    for (final exercise in session.exercises) {
      for (final set in exercise.sets) {
        if (!set.completed) return (exercise.id, set.id);
      }
    }
    return (null, null);
  }

  Future<void> _onResumed(SessionResumed event, Emitter<SessionState> emit) async {
    _restTimer?.cancel();
    _sessionStart = event.session.startedAt;
    await _sessions.save(event.session);
    emit(SessionActive(
      session: event.session,
      currentExerciseIndex: _firstIncompleteExercise(event.session),
    ));
  }

  int _firstIncompleteExercise(WorkoutSession session) {
    for (var i = 0; i < session.exercises.length; i++) {
      if (session.exercises[i].sets.any((s) => !s.completed)) return i;
    }
    return 0;
  }

  Future<void> _onSetCompleted(
      SetCompleted event, Emitter<SessionState> emit) async {
    final state = this.state;
    if (state is! SessionActive) return;

    final session = _applySetChange(
      state.session,
      event.exerciseId,
      event.setId,
      completed: true,
      weightKg: event.weightKg,
      reps: event.reps,
      completedAt: DateTime.now(),
    );

    await _sessions.save(session);

    final nextSet = _findNextSet(session);
    final nextIndex = nextSet == null
        ? state.currentExerciseIndex
        : session.exercises.indexWhere((e) => e.id == nextSet.$1);

    final rest = _restForNext(session, nextSet);

    final updated = state.copyWith(
      session: session,
      currentExerciseIndex: nextIndex.clamp(0, session.exercises.length - 1),
      spottingExerciseId: nextSet?.$1,
      spottingSetId: nextSet?.$2,
    );

    if (rest > Duration.zero && nextSet != null) {
      emit(SessionResting(
        session: updated.session,
        currentExerciseIndex: updated.currentExerciseIndex,
        remaining: rest,
        totalRest: rest,
        spottingExerciseId: updated.spottingExerciseId,
        spottingSetId: updated.spottingSetId,
        sessionXpPreview: _previewXp(updated.session),
      ));
      _startRestTicker();
    } else {
      emit(updated.copyWith(sessionXpPreview: _previewXp(session)));
    }
  }

  Future<void> _onSetUpdated(SetUpdated event, Emitter<SessionState> emit) async {
    final state = this.state;
    if (state is! SessionActive) return;
    final session = _applySetChange(
      state.session,
      event.exerciseId,
      event.setId,
      weightKg: event.weightKg,
      reps: event.reps,
    );
    await _sessions.save(session);
    emit(state.copyWith(session: session));
  }

  void _onRestStarted(RestStarted event, Emitter<SessionState> emit) {
    final state = this.state;
    if (state is! SessionActive) return;
    _restTimer?.cancel();
    emit(SessionResting(
      session: state.session,
      currentExerciseIndex: state.currentExerciseIndex,
      remaining: event.duration,
      totalRest: event.duration,
      spottingExerciseId: state.spottingExerciseId,
      spottingSetId: state.spottingSetId,
      sessionXpPreview: state.sessionXpPreview,
    ));
    _startRestTicker();
  }

  void _onRestAdjusted(RestAdjusted event, Emitter<SessionState> emit) {
    final state = this.state;
    if (state is! SessionResting) return;
    final newRemaining = state.remaining + event.delta;
    if (newRemaining <= Duration.zero) {
      _restTimer?.cancel();
      emit(SessionActive(
        session: state.session,
        currentExerciseIndex: state.currentExerciseIndex,
        sessionXpPreview: state.sessionXpPreview,
      ));
      return;
    }
    emit(SessionResting(
      session: state.session,
      currentExerciseIndex: state.currentExerciseIndex,
      remaining: newRemaining,
      totalRest: state.totalRest + event.delta,
      spottingExerciseId: state.spottingExerciseId,
      spottingSetId: state.spottingSetId,
      sessionXpPreview: state.sessionXpPreview,
    ));
    _restTimer?.cancel();
    _startRestTicker();
  }

  void _onRestSkipped(RestSkipped event, Emitter<SessionState> emit) {
    _restTimer?.cancel();
    final state = this.state;
    if (state is! SessionActive) return;
    emit(SessionActive(
      session: state.session,
      currentExerciseIndex: state.currentExerciseIndex,
      sessionXpPreview: state.sessionXpPreview,
    ));
  }

  void _onRestTicked(_RestTicked event, Emitter<SessionState> emit) {
    final state = this.state;
    if (state is! SessionResting) {
      _restTimer?.cancel();
      return;
    }
    final nextRemaining = state.remaining - const Duration(seconds: 1);
    if (nextRemaining <= Duration.zero) {
      _restTimer?.cancel();
      _onRestComplete?.call();
      emit(SessionActive(
        session: state.session,
        currentExerciseIndex: state.currentExerciseIndex,
        sessionXpPreview: state.sessionXpPreview,
      ));
    } else {
      emit(SessionResting(
        session: state.session,
        currentExerciseIndex: state.currentExerciseIndex,
        remaining: nextRemaining,
        totalRest: state.totalRest,
        spottingExerciseId: state.spottingExerciseId,
        spottingSetId: state.spottingSetId,
        sessionXpPreview: state.sessionXpPreview,
      ));
    }
  }

  void _startRestTicker() {
    _restTimer?.cancel();
    _restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) add(const _RestTicked());
    });
  }

  Future<void> _onFinished(WorkoutFinished event, Emitter<SessionState> emit) async {
    final state = this.state;
    if (state is! SessionActive) return;
    _restTimer?.cancel();
    emit(const SessionCompleting());

    final ended = state.session.copyWith(
      status: SessionStatus.active,
      completedAt: DateTime.now(),
    );
    // Fix duration: use real elapsed time from start.
    final withDuration = ended;
    final result = await _completeWorkout(withDuration);

    result.fold(
      (failure) {
        emit(SessionError(failure.message));
        emit(SessionActive(
          session: state.session,
          currentExerciseIndex: state.currentExerciseIndex,
          sessionXpPreview: _previewXp(state.session),
        ));
      },
      (completion) => emit(SessionComplete(completion)),
    );
  }

  Future<void> _onAbandoned(WorkoutAbandoned event, Emitter<SessionState> emit) async {
    final state = this.state;
    _restTimer?.cancel();
    final sessionId = state is SessionActive ? state.session.id : null;
    if (sessionId != null) {
      await _sessions.abandon(sessionId);
    }
    emit(const SessionInactive());
  }

  void _onFocusExercise(FocusExercise event, Emitter<SessionState> emit) {
    final state = this.state;
    if (state is! SessionActive) return;
    if (event.index < 0 || event.index >= state.session.exercises.length) return;
    emit(state.copyWith(currentExerciseIndex: event.index));
  }

  void _onSpotifyInfo(SpotifySessionInfoChanged event, Emitter<SessionState> emit) {
    final state = this.state;
    if (state is! SessionActive) return;
    final session = state.session.copyWith(
      spotifyUsed: event.spotifyUsed ?? state.session.spotifyUsed,
      spotifyTracksPlayed: event.tracksPlayed ?? state.session.spotifyTracksPlayed,
      playlistUsed: event.playlistUsed ?? state.session.playlistUsed,
    );
    emit(state is SessionResting
        ? SessionResting(
            session: session,
            currentExerciseIndex: state.currentExerciseIndex,
            remaining: state.remaining,
            totalRest: state.totalRest,
            sessionXpPreview: state.sessionXpPreview,
          )
        : state.copyWith(session: session));
  }

  // ------------------------------------------------------------ helpers

  WorkoutSession _applySetChange(
    WorkoutSession session,
    String exerciseId,
    String setId, {
    bool? completed,
    double? weightKg,
    int? reps,
    DateTime? completedAt,
  }) {
    final exercises = session.exercises.map((exercise) {
      if (exercise.id != exerciseId) return exercise;
      final sets = exercise.sets.map((set) {
        if (set.id != setId) return set;
        return set.copyWith(
          completed: completed ?? set.completed,
          weightKg: weightKg ?? set.weightKg,
          reps: reps ?? set.reps,
          completedAt: completedAt ?? set.completedAt,
        );
      }).toList();
      return SessionExercise(
        id: exercise.id,
        exercise: exercise.exercise,
        position: exercise.position,
        sets: sets,
        notes: exercise.notes,
        isReplaced: exercise.isReplaced,
      );
    }).toList();

    return session.copyWith(exercises: exercises);
  }

  (String, String)? _findNextSet(WorkoutSession session) {
    for (final exercise in session.exercises) {
      for (final set in exercise.sets) {
        if (!set.completed) return (exercise.id, set.id);
      }
    }
    return null;
  }

  Duration _restForNext(WorkoutSession session, (String, String)? nextSet) {
    if (nextSet == null) return Duration.zero;
    final exercise =
        session.exercises.firstWhere((e) => e.id == nextSet.$1);
    // 90s default; refined per-exercise in a later pass.
    return exercise.sets.isEmpty
        ? const Duration(seconds: 90)
        : const Duration(seconds: 90);
  }

  /// Informational XP estimate for the live session header.
  int _previewXp(WorkoutSession session) {
    final duration = DateTime.now().difference(_sessionStart);
    var xp = _xp.workoutCompleted;
    if (session.everyPlannedExerciseCompleted) xp += _xp.fullRoutineBonus;
    if (duration.inMinutes >= _xp.longWorkoutMinutes) xp += _xp.longWorkoutBonus;
    return xp;
  }
}
