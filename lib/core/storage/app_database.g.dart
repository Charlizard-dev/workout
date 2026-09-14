// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, UserRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lifetimeXpMeta = const VerificationMeta(
    'lifetimeXp',
  );
  @override
  late final GeneratedColumn<int> lifetimeXp = GeneratedColumn<int>(
    'lifetime_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastWorkoutAtMeta = const VerificationMeta(
    'lastWorkoutAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastWorkoutAt =
      GeneratedColumn<DateTime>(
        'last_workout_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _totalWorkoutsMeta = const VerificationMeta(
    'totalWorkouts',
  );
  @override
  late final GeneratedColumn<int> totalWorkouts = GeneratedColumn<int>(
    'total_workouts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalVolumeKgMeta = const VerificationMeta(
    'totalVolumeKg',
  );
  @override
  late final GeneratedColumn<double> totalVolumeKg = GeneratedColumn<double>(
    'total_volume_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalTrainingSecondsMeta =
      const VerificationMeta('totalTrainingSeconds');
  @override
  late final GeneratedColumn<int> totalTrainingSeconds = GeneratedColumn<int>(
    'total_training_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _spotifyWorkoutsMeta = const VerificationMeta(
    'spotifyWorkouts',
  );
  @override
  late final GeneratedColumn<int> spotifyWorkouts = GeneratedColumn<int>(
    'spotify_workouts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _spotifyTracksPlayedMeta =
      const VerificationMeta('spotifyTracksPlayed');
  @override
  late final GeneratedColumn<int> spotifyTracksPlayed = GeneratedColumn<int>(
    'spotify_tracks_played',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _playlistWorkoutsMeta = const VerificationMeta(
    'playlistWorkouts',
  );
  @override
  late final GeneratedColumn<int> playlistWorkouts = GeneratedColumn<int>(
    'playlist_workouts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _challengesCompletedMeta =
      const VerificationMeta('challengesCompleted');
  @override
  late final GeneratedColumn<int> challengesCompleted = GeneratedColumn<int>(
    'challenges_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _personalRecordsCountMeta =
      const VerificationMeta('personalRecordsCount');
  @override
  late final GeneratedColumn<int> personalRecordsCount = GeneratedColumn<int>(
    'personal_records_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    photoUrl,
    createdAt,
    passwordHash,
    passwordSalt,
    lifetimeXp,
    level,
    currentStreak,
    longestStreak,
    lastWorkoutAt,
    totalWorkouts,
    totalVolumeKg,
    totalTrainingSeconds,
    spotifyWorkouts,
    spotifyTracksPlayed,
    playlistWorkouts,
    challengesCompleted,
    personalRecordsCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
        ),
      );
    }
    if (data.containsKey('lifetime_xp')) {
      context.handle(
        _lifetimeXpMeta,
        lifetimeXp.isAcceptableOrUnknown(data['lifetime_xp']!, _lifetimeXpMeta),
      );
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('last_workout_at')) {
      context.handle(
        _lastWorkoutAtMeta,
        lastWorkoutAt.isAcceptableOrUnknown(
          data['last_workout_at']!,
          _lastWorkoutAtMeta,
        ),
      );
    }
    if (data.containsKey('total_workouts')) {
      context.handle(
        _totalWorkoutsMeta,
        totalWorkouts.isAcceptableOrUnknown(
          data['total_workouts']!,
          _totalWorkoutsMeta,
        ),
      );
    }
    if (data.containsKey('total_volume_kg')) {
      context.handle(
        _totalVolumeKgMeta,
        totalVolumeKg.isAcceptableOrUnknown(
          data['total_volume_kg']!,
          _totalVolumeKgMeta,
        ),
      );
    }
    if (data.containsKey('total_training_seconds')) {
      context.handle(
        _totalTrainingSecondsMeta,
        totalTrainingSeconds.isAcceptableOrUnknown(
          data['total_training_seconds']!,
          _totalTrainingSecondsMeta,
        ),
      );
    }
    if (data.containsKey('spotify_workouts')) {
      context.handle(
        _spotifyWorkoutsMeta,
        spotifyWorkouts.isAcceptableOrUnknown(
          data['spotify_workouts']!,
          _spotifyWorkoutsMeta,
        ),
      );
    }
    if (data.containsKey('spotify_tracks_played')) {
      context.handle(
        _spotifyTracksPlayedMeta,
        spotifyTracksPlayed.isAcceptableOrUnknown(
          data['spotify_tracks_played']!,
          _spotifyTracksPlayedMeta,
        ),
      );
    }
    if (data.containsKey('playlist_workouts')) {
      context.handle(
        _playlistWorkoutsMeta,
        playlistWorkouts.isAcceptableOrUnknown(
          data['playlist_workouts']!,
          _playlistWorkoutsMeta,
        ),
      );
    }
    if (data.containsKey('challenges_completed')) {
      context.handle(
        _challengesCompletedMeta,
        challengesCompleted.isAcceptableOrUnknown(
          data['challenges_completed']!,
          _challengesCompletedMeta,
        ),
      );
    }
    if (data.containsKey('personal_records_count')) {
      context.handle(
        _personalRecordsCountMeta,
        personalRecordsCount.isAcceptableOrUnknown(
          data['personal_records_count']!,
          _personalRecordsCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      ),
      lifetimeXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lifetime_xp'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      lastWorkoutAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_workout_at'],
      ),
      totalWorkouts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_workouts'],
      )!,
      totalVolumeKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_volume_kg'],
      )!,
      totalTrainingSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_training_seconds'],
      )!,
      spotifyWorkouts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spotify_workouts'],
      )!,
      spotifyTracksPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spotify_tracks_played'],
      )!,
      playlistWorkouts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}playlist_workouts'],
      )!,
      challengesCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}challenges_completed'],
      )!,
      personalRecordsCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}personal_records_count'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UserRow extends DataClass implements Insertable<UserRow> {
  final String id;
  final String name;
  final String? email;
  final String? photoUrl;
  final DateTime createdAt;
  final String? passwordHash;
  final String? passwordSalt;
  final int lifetimeXp;
  final int level;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastWorkoutAt;
  final int totalWorkouts;
  final double totalVolumeKg;
  final int totalTrainingSeconds;
  final int spotifyWorkouts;
  final int spotifyTracksPlayed;
  final int playlistWorkouts;
  final int challengesCompleted;
  final int personalRecordsCount;
  const UserRow({
    required this.id,
    required this.name,
    this.email,
    this.photoUrl,
    required this.createdAt,
    this.passwordHash,
    this.passwordSalt,
    required this.lifetimeXp,
    required this.level,
    required this.currentStreak,
    required this.longestStreak,
    this.lastWorkoutAt,
    required this.totalWorkouts,
    required this.totalVolumeKg,
    required this.totalTrainingSeconds,
    required this.spotifyWorkouts,
    required this.spotifyTracksPlayed,
    required this.playlistWorkouts,
    required this.challengesCompleted,
    required this.personalRecordsCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    if (!nullToAbsent || passwordSalt != null) {
      map['password_salt'] = Variable<String>(passwordSalt);
    }
    map['lifetime_xp'] = Variable<int>(lifetimeXp);
    map['level'] = Variable<int>(level);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || lastWorkoutAt != null) {
      map['last_workout_at'] = Variable<DateTime>(lastWorkoutAt);
    }
    map['total_workouts'] = Variable<int>(totalWorkouts);
    map['total_volume_kg'] = Variable<double>(totalVolumeKg);
    map['total_training_seconds'] = Variable<int>(totalTrainingSeconds);
    map['spotify_workouts'] = Variable<int>(spotifyWorkouts);
    map['spotify_tracks_played'] = Variable<int>(spotifyTracksPlayed);
    map['playlist_workouts'] = Variable<int>(playlistWorkouts);
    map['challenges_completed'] = Variable<int>(challengesCompleted);
    map['personal_records_count'] = Variable<int>(personalRecordsCount);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      createdAt: Value(createdAt),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      passwordSalt: passwordSalt == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordSalt),
      lifetimeXp: Value(lifetimeXp),
      level: Value(level),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      lastWorkoutAt: lastWorkoutAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWorkoutAt),
      totalWorkouts: Value(totalWorkouts),
      totalVolumeKg: Value(totalVolumeKg),
      totalTrainingSeconds: Value(totalTrainingSeconds),
      spotifyWorkouts: Value(spotifyWorkouts),
      spotifyTracksPlayed: Value(spotifyTracksPlayed),
      playlistWorkouts: Value(playlistWorkouts),
      challengesCompleted: Value(challengesCompleted),
      personalRecordsCount: Value(personalRecordsCount),
    );
  }

  factory UserRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String?>(json['passwordSalt']),
      lifetimeXp: serializer.fromJson<int>(json['lifetimeXp']),
      level: serializer.fromJson<int>(json['level']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      lastWorkoutAt: serializer.fromJson<DateTime?>(json['lastWorkoutAt']),
      totalWorkouts: serializer.fromJson<int>(json['totalWorkouts']),
      totalVolumeKg: serializer.fromJson<double>(json['totalVolumeKg']),
      totalTrainingSeconds: serializer.fromJson<int>(
        json['totalTrainingSeconds'],
      ),
      spotifyWorkouts: serializer.fromJson<int>(json['spotifyWorkouts']),
      spotifyTracksPlayed: serializer.fromJson<int>(
        json['spotifyTracksPlayed'],
      ),
      playlistWorkouts: serializer.fromJson<int>(json['playlistWorkouts']),
      challengesCompleted: serializer.fromJson<int>(
        json['challengesCompleted'],
      ),
      personalRecordsCount: serializer.fromJson<int>(
        json['personalRecordsCount'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'passwordSalt': serializer.toJson<String?>(passwordSalt),
      'lifetimeXp': serializer.toJson<int>(lifetimeXp),
      'level': serializer.toJson<int>(level),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'lastWorkoutAt': serializer.toJson<DateTime?>(lastWorkoutAt),
      'totalWorkouts': serializer.toJson<int>(totalWorkouts),
      'totalVolumeKg': serializer.toJson<double>(totalVolumeKg),
      'totalTrainingSeconds': serializer.toJson<int>(totalTrainingSeconds),
      'spotifyWorkouts': serializer.toJson<int>(spotifyWorkouts),
      'spotifyTracksPlayed': serializer.toJson<int>(spotifyTracksPlayed),
      'playlistWorkouts': serializer.toJson<int>(playlistWorkouts),
      'challengesCompleted': serializer.toJson<int>(challengesCompleted),
      'personalRecordsCount': serializer.toJson<int>(personalRecordsCount),
    };
  }

  UserRow copyWith({
    String? id,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? createdAt,
    Value<String?> passwordHash = const Value.absent(),
    Value<String?> passwordSalt = const Value.absent(),
    int? lifetimeXp,
    int? level,
    int? currentStreak,
    int? longestStreak,
    Value<DateTime?> lastWorkoutAt = const Value.absent(),
    int? totalWorkouts,
    double? totalVolumeKg,
    int? totalTrainingSeconds,
    int? spotifyWorkouts,
    int? spotifyTracksPlayed,
    int? playlistWorkouts,
    int? challengesCompleted,
    int? personalRecordsCount,
  }) => UserRow(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    createdAt: createdAt ?? this.createdAt,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    passwordSalt: passwordSalt.present ? passwordSalt.value : this.passwordSalt,
    lifetimeXp: lifetimeXp ?? this.lifetimeXp,
    level: level ?? this.level,
    currentStreak: currentStreak ?? this.currentStreak,
    longestStreak: longestStreak ?? this.longestStreak,
    lastWorkoutAt: lastWorkoutAt.present
        ? lastWorkoutAt.value
        : this.lastWorkoutAt,
    totalWorkouts: totalWorkouts ?? this.totalWorkouts,
    totalVolumeKg: totalVolumeKg ?? this.totalVolumeKg,
    totalTrainingSeconds: totalTrainingSeconds ?? this.totalTrainingSeconds,
    spotifyWorkouts: spotifyWorkouts ?? this.spotifyWorkouts,
    spotifyTracksPlayed: spotifyTracksPlayed ?? this.spotifyTracksPlayed,
    playlistWorkouts: playlistWorkouts ?? this.playlistWorkouts,
    challengesCompleted: challengesCompleted ?? this.challengesCompleted,
    personalRecordsCount: personalRecordsCount ?? this.personalRecordsCount,
  );
  UserRow copyWithCompanion(UsersCompanion data) {
    return UserRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      lifetimeXp: data.lifetimeXp.present
          ? data.lifetimeXp.value
          : this.lifetimeXp,
      level: data.level.present ? data.level.value : this.level,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      lastWorkoutAt: data.lastWorkoutAt.present
          ? data.lastWorkoutAt.value
          : this.lastWorkoutAt,
      totalWorkouts: data.totalWorkouts.present
          ? data.totalWorkouts.value
          : this.totalWorkouts,
      totalVolumeKg: data.totalVolumeKg.present
          ? data.totalVolumeKg.value
          : this.totalVolumeKg,
      totalTrainingSeconds: data.totalTrainingSeconds.present
          ? data.totalTrainingSeconds.value
          : this.totalTrainingSeconds,
      spotifyWorkouts: data.spotifyWorkouts.present
          ? data.spotifyWorkouts.value
          : this.spotifyWorkouts,
      spotifyTracksPlayed: data.spotifyTracksPlayed.present
          ? data.spotifyTracksPlayed.value
          : this.spotifyTracksPlayed,
      playlistWorkouts: data.playlistWorkouts.present
          ? data.playlistWorkouts.value
          : this.playlistWorkouts,
      challengesCompleted: data.challengesCompleted.present
          ? data.challengesCompleted.value
          : this.challengesCompleted,
      personalRecordsCount: data.personalRecordsCount.present
          ? data.personalRecordsCount.value
          : this.personalRecordsCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('lifetimeXp: $lifetimeXp, ')
          ..write('level: $level, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastWorkoutAt: $lastWorkoutAt, ')
          ..write('totalWorkouts: $totalWorkouts, ')
          ..write('totalVolumeKg: $totalVolumeKg, ')
          ..write('totalTrainingSeconds: $totalTrainingSeconds, ')
          ..write('spotifyWorkouts: $spotifyWorkouts, ')
          ..write('spotifyTracksPlayed: $spotifyTracksPlayed, ')
          ..write('playlistWorkouts: $playlistWorkouts, ')
          ..write('challengesCompleted: $challengesCompleted, ')
          ..write('personalRecordsCount: $personalRecordsCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    photoUrl,
    createdAt,
    passwordHash,
    passwordSalt,
    lifetimeXp,
    level,
    currentStreak,
    longestStreak,
    lastWorkoutAt,
    totalWorkouts,
    totalVolumeKg,
    totalTrainingSeconds,
    spotifyWorkouts,
    spotifyTracksPlayed,
    playlistWorkouts,
    challengesCompleted,
    personalRecordsCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.photoUrl == this.photoUrl &&
          other.createdAt == this.createdAt &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.lifetimeXp == this.lifetimeXp &&
          other.level == this.level &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.lastWorkoutAt == this.lastWorkoutAt &&
          other.totalWorkouts == this.totalWorkouts &&
          other.totalVolumeKg == this.totalVolumeKg &&
          other.totalTrainingSeconds == this.totalTrainingSeconds &&
          other.spotifyWorkouts == this.spotifyWorkouts &&
          other.spotifyTracksPlayed == this.spotifyTracksPlayed &&
          other.playlistWorkouts == this.playlistWorkouts &&
          other.challengesCompleted == this.challengesCompleted &&
          other.personalRecordsCount == this.personalRecordsCount);
}

class UsersCompanion extends UpdateCompanion<UserRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> photoUrl;
  final Value<DateTime> createdAt;
  final Value<String?> passwordHash;
  final Value<String?> passwordSalt;
  final Value<int> lifetimeXp;
  final Value<int> level;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<DateTime?> lastWorkoutAt;
  final Value<int> totalWorkouts;
  final Value<double> totalVolumeKg;
  final Value<int> totalTrainingSeconds;
  final Value<int> spotifyWorkouts;
  final Value<int> spotifyTracksPlayed;
  final Value<int> playlistWorkouts;
  final Value<int> challengesCompleted;
  final Value<int> personalRecordsCount;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.lifetimeXp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastWorkoutAt = const Value.absent(),
    this.totalWorkouts = const Value.absent(),
    this.totalVolumeKg = const Value.absent(),
    this.totalTrainingSeconds = const Value.absent(),
    this.spotifyWorkouts = const Value.absent(),
    this.spotifyTracksPlayed = const Value.absent(),
    this.playlistWorkouts = const Value.absent(),
    this.challengesCompleted = const Value.absent(),
    this.personalRecordsCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    this.email = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required DateTime createdAt,
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.lifetimeXp = const Value.absent(),
    this.level = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.lastWorkoutAt = const Value.absent(),
    this.totalWorkouts = const Value.absent(),
    this.totalVolumeKg = const Value.absent(),
    this.totalTrainingSeconds = const Value.absent(),
    this.spotifyWorkouts = const Value.absent(),
    this.spotifyTracksPlayed = const Value.absent(),
    this.playlistWorkouts = const Value.absent(),
    this.challengesCompleted = const Value.absent(),
    this.personalRecordsCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<UserRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? photoUrl,
    Expression<DateTime>? createdAt,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<int>? lifetimeXp,
    Expression<int>? level,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<DateTime>? lastWorkoutAt,
    Expression<int>? totalWorkouts,
    Expression<double>? totalVolumeKg,
    Expression<int>? totalTrainingSeconds,
    Expression<int>? spotifyWorkouts,
    Expression<int>? spotifyTracksPlayed,
    Expression<int>? playlistWorkouts,
    Expression<int>? challengesCompleted,
    Expression<int>? personalRecordsCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (lifetimeXp != null) 'lifetime_xp': lifetimeXp,
      if (level != null) 'level': level,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (lastWorkoutAt != null) 'last_workout_at': lastWorkoutAt,
      if (totalWorkouts != null) 'total_workouts': totalWorkouts,
      if (totalVolumeKg != null) 'total_volume_kg': totalVolumeKg,
      if (totalTrainingSeconds != null)
        'total_training_seconds': totalTrainingSeconds,
      if (spotifyWorkouts != null) 'spotify_workouts': spotifyWorkouts,
      if (spotifyTracksPlayed != null)
        'spotify_tracks_played': spotifyTracksPlayed,
      if (playlistWorkouts != null) 'playlist_workouts': playlistWorkouts,
      if (challengesCompleted != null)
        'challenges_completed': challengesCompleted,
      if (personalRecordsCount != null)
        'personal_records_count': personalRecordsCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? photoUrl,
    Value<DateTime>? createdAt,
    Value<String?>? passwordHash,
    Value<String?>? passwordSalt,
    Value<int>? lifetimeXp,
    Value<int>? level,
    Value<int>? currentStreak,
    Value<int>? longestStreak,
    Value<DateTime?>? lastWorkoutAt,
    Value<int>? totalWorkouts,
    Value<double>? totalVolumeKg,
    Value<int>? totalTrainingSeconds,
    Value<int>? spotifyWorkouts,
    Value<int>? spotifyTracksPlayed,
    Value<int>? playlistWorkouts,
    Value<int>? challengesCompleted,
    Value<int>? personalRecordsCount,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      lifetimeXp: lifetimeXp ?? this.lifetimeXp,
      level: level ?? this.level,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastWorkoutAt: lastWorkoutAt ?? this.lastWorkoutAt,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
      totalVolumeKg: totalVolumeKg ?? this.totalVolumeKg,
      totalTrainingSeconds: totalTrainingSeconds ?? this.totalTrainingSeconds,
      spotifyWorkouts: spotifyWorkouts ?? this.spotifyWorkouts,
      spotifyTracksPlayed: spotifyTracksPlayed ?? this.spotifyTracksPlayed,
      playlistWorkouts: playlistWorkouts ?? this.playlistWorkouts,
      challengesCompleted: challengesCompleted ?? this.challengesCompleted,
      personalRecordsCount: personalRecordsCount ?? this.personalRecordsCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (lifetimeXp.present) {
      map['lifetime_xp'] = Variable<int>(lifetimeXp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (lastWorkoutAt.present) {
      map['last_workout_at'] = Variable<DateTime>(lastWorkoutAt.value);
    }
    if (totalWorkouts.present) {
      map['total_workouts'] = Variable<int>(totalWorkouts.value);
    }
    if (totalVolumeKg.present) {
      map['total_volume_kg'] = Variable<double>(totalVolumeKg.value);
    }
    if (totalTrainingSeconds.present) {
      map['total_training_seconds'] = Variable<int>(totalTrainingSeconds.value);
    }
    if (spotifyWorkouts.present) {
      map['spotify_workouts'] = Variable<int>(spotifyWorkouts.value);
    }
    if (spotifyTracksPlayed.present) {
      map['spotify_tracks_played'] = Variable<int>(spotifyTracksPlayed.value);
    }
    if (playlistWorkouts.present) {
      map['playlist_workouts'] = Variable<int>(playlistWorkouts.value);
    }
    if (challengesCompleted.present) {
      map['challenges_completed'] = Variable<int>(challengesCompleted.value);
    }
    if (personalRecordsCount.present) {
      map['personal_records_count'] = Variable<int>(personalRecordsCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('lifetimeXp: $lifetimeXp, ')
          ..write('level: $level, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('lastWorkoutAt: $lastWorkoutAt, ')
          ..write('totalWorkouts: $totalWorkouts, ')
          ..write('totalVolumeKg: $totalVolumeKg, ')
          ..write('totalTrainingSeconds: $totalTrainingSeconds, ')
          ..write('spotifyWorkouts: $spotifyWorkouts, ')
          ..write('spotifyTracksPlayed: $spotifyTracksPlayed, ')
          ..write('playlistWorkouts: $playlistWorkouts, ')
          ..write('challengesCompleted: $challengesCompleted, ')
          ..write('personalRecordsCount: $personalRecordsCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $XpTransactionsTable extends XpTransactions
    with TableInfo<$XpTransactionsTable, XpTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    amount,
    source,
    description,
    workoutId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<XpTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  XpTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $XpTransactionsTable createAlias(String alias) {
    return $XpTransactionsTable(attachedDatabase, alias);
  }
}

class XpTransactionRow extends DataClass
    implements Insertable<XpTransactionRow> {
  final String id;
  final String userId;
  final int amount;
  final String source;
  final String description;
  final String? workoutId;
  final DateTime createdAt;
  const XpTransactionRow({
    required this.id,
    required this.userId,
    required this.amount,
    required this.source,
    required this.description,
    this.workoutId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['amount'] = Variable<int>(amount);
    map['source'] = Variable<String>(source);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || workoutId != null) {
      map['workout_id'] = Variable<String>(workoutId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  XpTransactionsCompanion toCompanion(bool nullToAbsent) {
    return XpTransactionsCompanion(
      id: Value(id),
      userId: Value(userId),
      amount: Value(amount),
      source: Value(source),
      description: Value(description),
      workoutId: workoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutId),
      createdAt: Value(createdAt),
    );
  }

  factory XpTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpTransactionRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      amount: serializer.fromJson<int>(json['amount']),
      source: serializer.fromJson<String>(json['source']),
      description: serializer.fromJson<String>(json['description']),
      workoutId: serializer.fromJson<String?>(json['workoutId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'amount': serializer.toJson<int>(amount),
      'source': serializer.toJson<String>(source),
      'description': serializer.toJson<String>(description),
      'workoutId': serializer.toJson<String?>(workoutId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  XpTransactionRow copyWith({
    String? id,
    String? userId,
    int? amount,
    String? source,
    String? description,
    Value<String?> workoutId = const Value.absent(),
    DateTime? createdAt,
  }) => XpTransactionRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    amount: amount ?? this.amount,
    source: source ?? this.source,
    description: description ?? this.description,
    workoutId: workoutId.present ? workoutId.value : this.workoutId,
    createdAt: createdAt ?? this.createdAt,
  );
  XpTransactionRow copyWithCompanion(XpTransactionsCompanion data) {
    return XpTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      amount: data.amount.present ? data.amount.value : this.amount,
      source: data.source.present ? data.source.value : this.source,
      description: data.description.present
          ? data.description.value
          : this.description,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpTransactionRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('source: $source, ')
          ..write('description: $description, ')
          ..write('workoutId: $workoutId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    amount,
    source,
    description,
    workoutId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpTransactionRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.amount == this.amount &&
          other.source == this.source &&
          other.description == this.description &&
          other.workoutId == this.workoutId &&
          other.createdAt == this.createdAt);
}

class XpTransactionsCompanion extends UpdateCompanion<XpTransactionRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> amount;
  final Value<String> source;
  final Value<String> description;
  final Value<String?> workoutId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const XpTransactionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.amount = const Value.absent(),
    this.source = const Value.absent(),
    this.description = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  XpTransactionsCompanion.insert({
    required String id,
    required String userId,
    required int amount,
    required String source,
    required String description,
    this.workoutId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       amount = Value(amount),
       source = Value(source),
       description = Value(description),
       createdAt = Value(createdAt);
  static Insertable<XpTransactionRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? amount,
    Expression<String>? source,
    Expression<String>? description,
    Expression<String>? workoutId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (amount != null) 'amount': amount,
      if (source != null) 'source': source,
      if (description != null) 'description': description,
      if (workoutId != null) 'workout_id': workoutId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  XpTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<int>? amount,
    Value<String>? source,
    Value<String>? description,
    Value<String?>? workoutId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return XpTransactionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      source: source ?? this.source,
      description: description ?? this.description,
      workoutId: workoutId ?? this.workoutId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('source: $source, ')
          ..write('description: $description, ')
          ..write('workoutId: $workoutId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutRoutinesTable extends WorkoutRoutines
    with TableInfo<$WorkoutRoutinesTable, WorkoutRoutineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutRoutinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restDurationSecondsMeta =
      const VerificationMeta('restDurationSeconds');
  @override
  late final GeneratedColumn<int> restDurationSeconds = GeneratedColumn<int>(
    'rest_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(90),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    category,
    restDurationSeconds,
    createdAt,
    updatedAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_routines';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutRoutineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('rest_duration_seconds')) {
      context.handle(
        _restDurationSecondsMeta,
        restDurationSeconds.isAcceptableOrUnknown(
          data['rest_duration_seconds']!,
          _restDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutRoutineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutRoutineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      restDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_duration_seconds'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $WorkoutRoutinesTable createAlias(String alias) {
    return $WorkoutRoutinesTable(attachedDatabase, alias);
  }
}

class WorkoutRoutineRow extends DataClass
    implements Insertable<WorkoutRoutineRow> {
  final String id;
  final String name;
  final String? description;
  final String category;
  final int restDurationSeconds;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int sortOrder;
  const WorkoutRoutineRow({
    required this.id,
    required this.name,
    this.description,
    required this.category,
    required this.restDurationSeconds,
    this.createdAt,
    this.updatedAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    map['rest_duration_seconds'] = Variable<int>(restDurationSeconds);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  WorkoutRoutinesCompanion toCompanion(bool nullToAbsent) {
    return WorkoutRoutinesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      restDurationSeconds: Value(restDurationSeconds),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory WorkoutRoutineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutRoutineRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      restDurationSeconds: serializer.fromJson<int>(
        json['restDurationSeconds'],
      ),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'restDurationSeconds': serializer.toJson<int>(restDurationSeconds),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  WorkoutRoutineRow copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? category,
    int? restDurationSeconds,
    Value<DateTime?> createdAt = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    int? sortOrder,
  }) => WorkoutRoutineRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    category: category ?? this.category,
    restDurationSeconds: restDurationSeconds ?? this.restDurationSeconds,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  WorkoutRoutineRow copyWithCompanion(WorkoutRoutinesCompanion data) {
    return WorkoutRoutineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      restDurationSeconds: data.restDurationSeconds.present
          ? data.restDurationSeconds.value
          : this.restDurationSeconds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutRoutineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('restDurationSeconds: $restDurationSeconds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    category,
    restDurationSeconds,
    createdAt,
    updatedAt,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutRoutineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.restDurationSeconds == this.restDurationSeconds &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.sortOrder == this.sortOrder);
}

class WorkoutRoutinesCompanion extends UpdateCompanion<WorkoutRoutineRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> category;
  final Value<int> restDurationSeconds;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const WorkoutRoutinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.restDurationSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutRoutinesCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required String category,
    this.restDurationSeconds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       category = Value(category);
  static Insertable<WorkoutRoutineRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? restDurationSeconds,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (restDurationSeconds != null)
        'rest_duration_seconds': restDurationSeconds,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutRoutinesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? category,
    Value<int>? restDurationSeconds,
    Value<DateTime?>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return WorkoutRoutinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      restDurationSeconds: restDurationSeconds ?? this.restDurationSeconds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (restDurationSeconds.present) {
      map['rest_duration_seconds'] = Variable<int>(restDurationSeconds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutRoutinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('restDurationSeconds: $restDurationSeconds, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutineExercisesTable extends RoutineExercises
    with TableInfo<$RoutineExercisesTable, RoutineExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutineExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setCountMeta = const VerificationMeta(
    'setCount',
  );
  @override
  late final GeneratedColumn<int> setCount = GeneratedColumn<int>(
    'set_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _warmUpSetCountMeta = const VerificationMeta(
    'warmUpSetCount',
  );
  @override
  late final GeneratedColumn<int> warmUpSetCount = GeneratedColumn<int>(
    'warm_up_set_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _restDurationSecondsMeta =
      const VerificationMeta('restDurationSeconds');
  @override
  late final GeneratedColumn<int> restDurationSeconds = GeneratedColumn<int>(
    'rest_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    exerciseId,
    position,
    setCount,
    reps,
    weightKg,
    warmUpSetCount,
    restDurationSeconds,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routine_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoutineExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('set_count')) {
      context.handle(
        _setCountMeta,
        setCount.isAcceptableOrUnknown(data['set_count']!, _setCountMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('warm_up_set_count')) {
      context.handle(
        _warmUpSetCountMeta,
        warmUpSetCount.isAcceptableOrUnknown(
          data['warm_up_set_count']!,
          _warmUpSetCountMeta,
        ),
      );
    }
    if (data.containsKey('rest_duration_seconds')) {
      context.handle(
        _restDurationSecondsMeta,
        restDurationSeconds.isAcceptableOrUnknown(
          data['rest_duration_seconds']!,
          _restDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoutineExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoutineExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      setCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_count'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      warmUpSetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warm_up_set_count'],
      )!,
      restDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_duration_seconds'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $RoutineExercisesTable createAlias(String alias) {
    return $RoutineExercisesTable(attachedDatabase, alias);
  }
}

class RoutineExerciseRow extends DataClass
    implements Insertable<RoutineExerciseRow> {
  final String id;
  final String routineId;
  final String exerciseId;
  final int position;
  final int setCount;
  final int reps;
  final double weightKg;
  final int warmUpSetCount;
  final int? restDurationSeconds;
  final String? notes;
  const RoutineExerciseRow({
    required this.id,
    required this.routineId,
    required this.exerciseId,
    required this.position,
    required this.setCount,
    required this.reps,
    required this.weightKg,
    required this.warmUpSetCount,
    this.restDurationSeconds,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['position'] = Variable<int>(position);
    map['set_count'] = Variable<int>(setCount);
    map['reps'] = Variable<int>(reps);
    map['weight_kg'] = Variable<double>(weightKg);
    map['warm_up_set_count'] = Variable<int>(warmUpSetCount);
    if (!nullToAbsent || restDurationSeconds != null) {
      map['rest_duration_seconds'] = Variable<int>(restDurationSeconds);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  RoutineExercisesCompanion toCompanion(bool nullToAbsent) {
    return RoutineExercisesCompanion(
      id: Value(id),
      routineId: Value(routineId),
      exerciseId: Value(exerciseId),
      position: Value(position),
      setCount: Value(setCount),
      reps: Value(reps),
      weightKg: Value(weightKg),
      warmUpSetCount: Value(warmUpSetCount),
      restDurationSeconds: restDurationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restDurationSeconds),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory RoutineExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoutineExerciseRow(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      position: serializer.fromJson<int>(json['position']),
      setCount: serializer.fromJson<int>(json['setCount']),
      reps: serializer.fromJson<int>(json['reps']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      warmUpSetCount: serializer.fromJson<int>(json['warmUpSetCount']),
      restDurationSeconds: serializer.fromJson<int?>(
        json['restDurationSeconds'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'position': serializer.toJson<int>(position),
      'setCount': serializer.toJson<int>(setCount),
      'reps': serializer.toJson<int>(reps),
      'weightKg': serializer.toJson<double>(weightKg),
      'warmUpSetCount': serializer.toJson<int>(warmUpSetCount),
      'restDurationSeconds': serializer.toJson<int?>(restDurationSeconds),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  RoutineExerciseRow copyWith({
    String? id,
    String? routineId,
    String? exerciseId,
    int? position,
    int? setCount,
    int? reps,
    double? weightKg,
    int? warmUpSetCount,
    Value<int?> restDurationSeconds = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => RoutineExerciseRow(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    setCount: setCount ?? this.setCount,
    reps: reps ?? this.reps,
    weightKg: weightKg ?? this.weightKg,
    warmUpSetCount: warmUpSetCount ?? this.warmUpSetCount,
    restDurationSeconds: restDurationSeconds.present
        ? restDurationSeconds.value
        : this.restDurationSeconds,
    notes: notes.present ? notes.value : this.notes,
  );
  RoutineExerciseRow copyWithCompanion(RoutineExercisesCompanion data) {
    return RoutineExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      setCount: data.setCount.present ? data.setCount.value : this.setCount,
      reps: data.reps.present ? data.reps.value : this.reps,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      warmUpSetCount: data.warmUpSetCount.present
          ? data.warmUpSetCount.value
          : this.warmUpSetCount,
      restDurationSeconds: data.restDurationSeconds.present
          ? data.restDurationSeconds.value
          : this.restDurationSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExerciseRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('setCount: $setCount, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('warmUpSetCount: $warmUpSetCount, ')
          ..write('restDurationSeconds: $restDurationSeconds, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    exerciseId,
    position,
    setCount,
    reps,
    weightKg,
    warmUpSetCount,
    restDurationSeconds,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoutineExerciseRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.setCount == this.setCount &&
          other.reps == this.reps &&
          other.weightKg == this.weightKg &&
          other.warmUpSetCount == this.warmUpSetCount &&
          other.restDurationSeconds == this.restDurationSeconds &&
          other.notes == this.notes);
}

class RoutineExercisesCompanion extends UpdateCompanion<RoutineExerciseRow> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> exerciseId;
  final Value<int> position;
  final Value<int> setCount;
  final Value<int> reps;
  final Value<double> weightKg;
  final Value<int> warmUpSetCount;
  final Value<int?> restDurationSeconds;
  final Value<String?> notes;
  final Value<int> rowid;
  const RoutineExercisesCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.setCount = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.warmUpSetCount = const Value.absent(),
    this.restDurationSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoutineExercisesCompanion.insert({
    required String id,
    required String routineId,
    required String exerciseId,
    required int position,
    this.setCount = const Value.absent(),
    this.reps = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.warmUpSetCount = const Value.absent(),
    this.restDurationSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       exerciseId = Value(exerciseId),
       position = Value(position);
  static Insertable<RoutineExerciseRow> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? exerciseId,
    Expression<int>? position,
    Expression<int>? setCount,
    Expression<int>? reps,
    Expression<double>? weightKg,
    Expression<int>? warmUpSetCount,
    Expression<int>? restDurationSeconds,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (setCount != null) 'set_count': setCount,
      if (reps != null) 'reps': reps,
      if (weightKg != null) 'weight_kg': weightKg,
      if (warmUpSetCount != null) 'warm_up_set_count': warmUpSetCount,
      if (restDurationSeconds != null)
        'rest_duration_seconds': restDurationSeconds,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoutineExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<String>? exerciseId,
    Value<int>? position,
    Value<int>? setCount,
    Value<int>? reps,
    Value<double>? weightKg,
    Value<int>? warmUpSetCount,
    Value<int?>? restDurationSeconds,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return RoutineExercisesCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      setCount: setCount ?? this.setCount,
      reps: reps ?? this.reps,
      weightKg: weightKg ?? this.weightKg,
      warmUpSetCount: warmUpSetCount ?? this.warmUpSetCount,
      restDurationSeconds: restDurationSeconds ?? this.restDurationSeconds,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (setCount.present) {
      map['set_count'] = Variable<int>(setCount.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (warmUpSetCount.present) {
      map['warm_up_set_count'] = Variable<int>(warmUpSetCount.value);
    }
    if (restDurationSeconds.present) {
      map['rest_duration_seconds'] = Variable<int>(restDurationSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutineExercisesCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('setCount: $setCount, ')
          ..write('reps: $reps, ')
          ..write('weightKg: $weightKg, ')
          ..write('warmUpSetCount: $warmUpSetCount, ')
          ..write('restDurationSeconds: $restDurationSeconds, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryMuscleMeta = const VerificationMeta(
    'primaryMuscle',
  );
  @override
  late final GeneratedColumn<String> primaryMuscle = GeneratedColumn<String>(
    'primary_muscle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryMusclesMeta = const VerificationMeta(
    'secondaryMuscles',
  );
  @override
  late final GeneratedColumn<String> secondaryMuscles = GeneratedColumn<String>(
    'secondary_muscles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    primaryMuscle,
    secondaryMuscles,
    isCustom,
    isFavorite,
    equipment,
    lastUsedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('primary_muscle')) {
      context.handle(
        _primaryMuscleMeta,
        primaryMuscle.isAcceptableOrUnknown(
          data['primary_muscle']!,
          _primaryMuscleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryMuscleMeta);
    }
    if (data.containsKey('secondary_muscles')) {
      context.handle(
        _secondaryMusclesMeta,
        secondaryMuscles.isAcceptableOrUnknown(
          data['secondary_muscles']!,
          _secondaryMusclesMeta,
        ),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      primaryMuscle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscle'],
      )!,
      secondaryMuscles: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_muscles'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      ),
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class ExerciseRow extends DataClass implements Insertable<ExerciseRow> {
  final String id;
  final String name;
  final String primaryMuscle;
  final String secondaryMuscles;
  final bool isCustom;
  final bool isFavorite;
  final String? equipment;
  final DateTime? lastUsedAt;
  const ExerciseRow({
    required this.id,
    required this.name,
    required this.primaryMuscle,
    required this.secondaryMuscles,
    required this.isCustom,
    required this.isFavorite,
    this.equipment,
    this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['primary_muscle'] = Variable<String>(primaryMuscle);
    map['secondary_muscles'] = Variable<String>(secondaryMuscles);
    map['is_custom'] = Variable<bool>(isCustom);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || equipment != null) {
      map['equipment'] = Variable<String>(equipment);
    }
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      primaryMuscle: Value(primaryMuscle),
      secondaryMuscles: Value(secondaryMuscles),
      isCustom: Value(isCustom),
      isFavorite: Value(isFavorite),
      equipment: equipment == null && nullToAbsent
          ? const Value.absent()
          : Value(equipment),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
    );
  }

  factory ExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primaryMuscle: serializer.fromJson<String>(json['primaryMuscle']),
      secondaryMuscles: serializer.fromJson<String>(json['secondaryMuscles']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      equipment: serializer.fromJson<String?>(json['equipment']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'primaryMuscle': serializer.toJson<String>(primaryMuscle),
      'secondaryMuscles': serializer.toJson<String>(secondaryMuscles),
      'isCustom': serializer.toJson<bool>(isCustom),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'equipment': serializer.toJson<String?>(equipment),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
    };
  }

  ExerciseRow copyWith({
    String? id,
    String? name,
    String? primaryMuscle,
    String? secondaryMuscles,
    bool? isCustom,
    bool? isFavorite,
    Value<String?> equipment = const Value.absent(),
    Value<DateTime?> lastUsedAt = const Value.absent(),
  }) => ExerciseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    primaryMuscle: primaryMuscle ?? this.primaryMuscle,
    secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
    isCustom: isCustom ?? this.isCustom,
    isFavorite: isFavorite ?? this.isFavorite,
    equipment: equipment.present ? equipment.value : this.equipment,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
  );
  ExerciseRow copyWithCompanion(ExercisesCompanion data) {
    return ExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      primaryMuscle: data.primaryMuscle.present
          ? data.primaryMuscle.value
          : this.primaryMuscle,
      secondaryMuscles: data.secondaryMuscles.present
          ? data.secondaryMuscles.value
          : this.secondaryMuscles,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscles: $secondaryMuscles, ')
          ..write('isCustom: $isCustom, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('equipment: $equipment, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    primaryMuscle,
    secondaryMuscles,
    isCustom,
    isFavorite,
    equipment,
    lastUsedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.primaryMuscle == this.primaryMuscle &&
          other.secondaryMuscles == this.secondaryMuscles &&
          other.isCustom == this.isCustom &&
          other.isFavorite == this.isFavorite &&
          other.equipment == this.equipment &&
          other.lastUsedAt == this.lastUsedAt);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> primaryMuscle;
  final Value<String> secondaryMuscles;
  final Value<bool> isCustom;
  final Value<bool> isFavorite;
  final Value<String?> equipment;
  final Value<DateTime?> lastUsedAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryMuscle = const Value.absent(),
    this.secondaryMuscles = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.equipment = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String name,
    required String primaryMuscle,
    this.secondaryMuscles = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.equipment = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       primaryMuscle = Value(primaryMuscle);
  static Insertable<ExerciseRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? primaryMuscle,
    Expression<String>? secondaryMuscles,
    Expression<bool>? isCustom,
    Expression<bool>? isFavorite,
    Expression<String>? equipment,
    Expression<DateTime>? lastUsedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primaryMuscle != null) 'primary_muscle': primaryMuscle,
      if (secondaryMuscles != null) 'secondary_muscles': secondaryMuscles,
      if (isCustom != null) 'is_custom': isCustom,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (equipment != null) 'equipment': equipment,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? primaryMuscle,
    Value<String>? secondaryMuscles,
    Value<bool>? isCustom,
    Value<bool>? isFavorite,
    Value<String?>? equipment,
    Value<DateTime?>? lastUsedAt,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primaryMuscle: primaryMuscle ?? this.primaryMuscle,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      isCustom: isCustom ?? this.isCustom,
      isFavorite: isFavorite ?? this.isFavorite,
      equipment: equipment ?? this.equipment,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryMuscle.present) {
      map['primary_muscle'] = Variable<String>(primaryMuscle.value);
    }
    if (secondaryMuscles.present) {
      map['secondary_muscles'] = Variable<String>(secondaryMuscles.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryMuscle: $primaryMuscle, ')
          ..write('secondaryMuscles: $secondaryMuscles, ')
          ..write('isCustom: $isCustom, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('equipment: $equipment, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSessionsTable extends WorkoutSessions
    with TableInfo<$WorkoutSessionsTable, WorkoutSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _wasScheduledMeta = const VerificationMeta(
    'wasScheduled',
  );
  @override
  late final GeneratedColumn<bool> wasScheduled = GeneratedColumn<bool>(
    'was_scheduled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_scheduled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _personalRecordsMeta = const VerificationMeta(
    'personalRecords',
  );
  @override
  late final GeneratedColumn<int> personalRecords = GeneratedColumn<int>(
    'personal_records',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spotifyUsedMeta = const VerificationMeta(
    'spotifyUsed',
  );
  @override
  late final GeneratedColumn<bool> spotifyUsed = GeneratedColumn<bool>(
    'spotify_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("spotify_used" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _spotifyTracksPlayedMeta =
      const VerificationMeta('spotifyTracksPlayed');
  @override
  late final GeneratedColumn<int> spotifyTracksPlayed = GeneratedColumn<int>(
    'spotify_tracks_played',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _playlistUsedMeta = const VerificationMeta(
    'playlistUsed',
  );
  @override
  late final GeneratedColumn<bool> playlistUsed = GeneratedColumn<bool>(
    'playlist_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("playlist_used" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routineId,
    name,
    startedAt,
    completedAt,
    status,
    scheduledDate,
    wasScheduled,
    xpEarned,
    personalRecords,
    spotifyUsed,
    spotifyTracksPlayed,
    playlistUsed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routineIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    }
    if (data.containsKey('was_scheduled')) {
      context.handle(
        _wasScheduledMeta,
        wasScheduled.isAcceptableOrUnknown(
          data['was_scheduled']!,
          _wasScheduledMeta,
        ),
      );
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    }
    if (data.containsKey('personal_records')) {
      context.handle(
        _personalRecordsMeta,
        personalRecords.isAcceptableOrUnknown(
          data['personal_records']!,
          _personalRecordsMeta,
        ),
      );
    }
    if (data.containsKey('spotify_used')) {
      context.handle(
        _spotifyUsedMeta,
        spotifyUsed.isAcceptableOrUnknown(
          data['spotify_used']!,
          _spotifyUsedMeta,
        ),
      );
    }
    if (data.containsKey('spotify_tracks_played')) {
      context.handle(
        _spotifyTracksPlayedMeta,
        spotifyTracksPlayed.isAcceptableOrUnknown(
          data['spotify_tracks_played']!,
          _spotifyTracksPlayedMeta,
        ),
      );
    }
    if (data.containsKey('playlist_used')) {
      context.handle(
        _playlistUsedMeta,
        playlistUsed.isAcceptableOrUnknown(
          data['playlist_used']!,
          _playlistUsedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      ),
      wasScheduled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_scheduled'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      ),
      personalRecords: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}personal_records'],
      ),
      spotifyUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}spotify_used'],
      )!,
      spotifyTracksPlayed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spotify_tracks_played'],
      )!,
      playlistUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}playlist_used'],
      )!,
    );
  }

  @override
  $WorkoutSessionsTable createAlias(String alias) {
    return $WorkoutSessionsTable(attachedDatabase, alias);
  }
}

class WorkoutSessionRow extends DataClass
    implements Insertable<WorkoutSessionRow> {
  final String id;
  final String routineId;
  final String name;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String status;
  final DateTime? scheduledDate;
  final bool wasScheduled;
  final int? xpEarned;
  final int? personalRecords;
  final bool spotifyUsed;
  final int spotifyTracksPlayed;
  final bool playlistUsed;
  const WorkoutSessionRow({
    required this.id,
    required this.routineId,
    required this.name,
    required this.startedAt,
    this.completedAt,
    required this.status,
    this.scheduledDate,
    required this.wasScheduled,
    this.xpEarned,
    this.personalRecords,
    required this.spotifyUsed,
    required this.spotifyTracksPlayed,
    required this.playlistUsed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['routine_id'] = Variable<String>(routineId);
    map['name'] = Variable<String>(name);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || scheduledDate != null) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    }
    map['was_scheduled'] = Variable<bool>(wasScheduled);
    if (!nullToAbsent || xpEarned != null) {
      map['xp_earned'] = Variable<int>(xpEarned);
    }
    if (!nullToAbsent || personalRecords != null) {
      map['personal_records'] = Variable<int>(personalRecords);
    }
    map['spotify_used'] = Variable<bool>(spotifyUsed);
    map['spotify_tracks_played'] = Variable<int>(spotifyTracksPlayed);
    map['playlist_used'] = Variable<bool>(playlistUsed);
    return map;
  }

  WorkoutSessionsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSessionsCompanion(
      id: Value(id),
      routineId: Value(routineId),
      name: Value(name),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      status: Value(status),
      scheduledDate: scheduledDate == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledDate),
      wasScheduled: Value(wasScheduled),
      xpEarned: xpEarned == null && nullToAbsent
          ? const Value.absent()
          : Value(xpEarned),
      personalRecords: personalRecords == null && nullToAbsent
          ? const Value.absent()
          : Value(personalRecords),
      spotifyUsed: Value(spotifyUsed),
      spotifyTracksPlayed: Value(spotifyTracksPlayed),
      playlistUsed: Value(playlistUsed),
    );
  }

  factory WorkoutSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSessionRow(
      id: serializer.fromJson<String>(json['id']),
      routineId: serializer.fromJson<String>(json['routineId']),
      name: serializer.fromJson<String>(json['name']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      status: serializer.fromJson<String>(json['status']),
      scheduledDate: serializer.fromJson<DateTime?>(json['scheduledDate']),
      wasScheduled: serializer.fromJson<bool>(json['wasScheduled']),
      xpEarned: serializer.fromJson<int?>(json['xpEarned']),
      personalRecords: serializer.fromJson<int?>(json['personalRecords']),
      spotifyUsed: serializer.fromJson<bool>(json['spotifyUsed']),
      spotifyTracksPlayed: serializer.fromJson<int>(
        json['spotifyTracksPlayed'],
      ),
      playlistUsed: serializer.fromJson<bool>(json['playlistUsed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'routineId': serializer.toJson<String>(routineId),
      'name': serializer.toJson<String>(name),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'status': serializer.toJson<String>(status),
      'scheduledDate': serializer.toJson<DateTime?>(scheduledDate),
      'wasScheduled': serializer.toJson<bool>(wasScheduled),
      'xpEarned': serializer.toJson<int?>(xpEarned),
      'personalRecords': serializer.toJson<int?>(personalRecords),
      'spotifyUsed': serializer.toJson<bool>(spotifyUsed),
      'spotifyTracksPlayed': serializer.toJson<int>(spotifyTracksPlayed),
      'playlistUsed': serializer.toJson<bool>(playlistUsed),
    };
  }

  WorkoutSessionRow copyWith({
    String? id,
    String? routineId,
    String? name,
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    String? status,
    Value<DateTime?> scheduledDate = const Value.absent(),
    bool? wasScheduled,
    Value<int?> xpEarned = const Value.absent(),
    Value<int?> personalRecords = const Value.absent(),
    bool? spotifyUsed,
    int? spotifyTracksPlayed,
    bool? playlistUsed,
  }) => WorkoutSessionRow(
    id: id ?? this.id,
    routineId: routineId ?? this.routineId,
    name: name ?? this.name,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    status: status ?? this.status,
    scheduledDate: scheduledDate.present
        ? scheduledDate.value
        : this.scheduledDate,
    wasScheduled: wasScheduled ?? this.wasScheduled,
    xpEarned: xpEarned.present ? xpEarned.value : this.xpEarned,
    personalRecords: personalRecords.present
        ? personalRecords.value
        : this.personalRecords,
    spotifyUsed: spotifyUsed ?? this.spotifyUsed,
    spotifyTracksPlayed: spotifyTracksPlayed ?? this.spotifyTracksPlayed,
    playlistUsed: playlistUsed ?? this.playlistUsed,
  );
  WorkoutSessionRow copyWithCompanion(WorkoutSessionsCompanion data) {
    return WorkoutSessionRow(
      id: data.id.present ? data.id.value : this.id,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      name: data.name.present ? data.name.value : this.name,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      status: data.status.present ? data.status.value : this.status,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      wasScheduled: data.wasScheduled.present
          ? data.wasScheduled.value
          : this.wasScheduled,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      personalRecords: data.personalRecords.present
          ? data.personalRecords.value
          : this.personalRecords,
      spotifyUsed: data.spotifyUsed.present
          ? data.spotifyUsed.value
          : this.spotifyUsed,
      spotifyTracksPlayed: data.spotifyTracksPlayed.present
          ? data.spotifyTracksPlayed.value
          : this.spotifyTracksPlayed,
      playlistUsed: data.playlistUsed.present
          ? data.playlistUsed.value
          : this.playlistUsed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionRow(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('wasScheduled: $wasScheduled, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('personalRecords: $personalRecords, ')
          ..write('spotifyUsed: $spotifyUsed, ')
          ..write('spotifyTracksPlayed: $spotifyTracksPlayed, ')
          ..write('playlistUsed: $playlistUsed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    routineId,
    name,
    startedAt,
    completedAt,
    status,
    scheduledDate,
    wasScheduled,
    xpEarned,
    personalRecords,
    spotifyUsed,
    spotifyTracksPlayed,
    playlistUsed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSessionRow &&
          other.id == this.id &&
          other.routineId == this.routineId &&
          other.name == this.name &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.status == this.status &&
          other.scheduledDate == this.scheduledDate &&
          other.wasScheduled == this.wasScheduled &&
          other.xpEarned == this.xpEarned &&
          other.personalRecords == this.personalRecords &&
          other.spotifyUsed == this.spotifyUsed &&
          other.spotifyTracksPlayed == this.spotifyTracksPlayed &&
          other.playlistUsed == this.playlistUsed);
}

class WorkoutSessionsCompanion extends UpdateCompanion<WorkoutSessionRow> {
  final Value<String> id;
  final Value<String> routineId;
  final Value<String> name;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<String> status;
  final Value<DateTime?> scheduledDate;
  final Value<bool> wasScheduled;
  final Value<int?> xpEarned;
  final Value<int?> personalRecords;
  final Value<bool> spotifyUsed;
  final Value<int> spotifyTracksPlayed;
  final Value<bool> playlistUsed;
  final Value<int> rowid;
  const WorkoutSessionsCompanion({
    this.id = const Value.absent(),
    this.routineId = const Value.absent(),
    this.name = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.wasScheduled = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.personalRecords = const Value.absent(),
    this.spotifyUsed = const Value.absent(),
    this.spotifyTracksPlayed = const Value.absent(),
    this.playlistUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSessionsCompanion.insert({
    required String id,
    required String routineId,
    required String name,
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    required String status,
    this.scheduledDate = const Value.absent(),
    this.wasScheduled = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.personalRecords = const Value.absent(),
    this.spotifyUsed = const Value.absent(),
    this.spotifyTracksPlayed = const Value.absent(),
    this.playlistUsed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       routineId = Value(routineId),
       name = Value(name),
       startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<WorkoutSessionRow> custom({
    Expression<String>? id,
    Expression<String>? routineId,
    Expression<String>? name,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<String>? status,
    Expression<DateTime>? scheduledDate,
    Expression<bool>? wasScheduled,
    Expression<int>? xpEarned,
    Expression<int>? personalRecords,
    Expression<bool>? spotifyUsed,
    Expression<int>? spotifyTracksPlayed,
    Expression<bool>? playlistUsed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routineId != null) 'routine_id': routineId,
      if (name != null) 'name': name,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (status != null) 'status': status,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (wasScheduled != null) 'was_scheduled': wasScheduled,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (personalRecords != null) 'personal_records': personalRecords,
      if (spotifyUsed != null) 'spotify_used': spotifyUsed,
      if (spotifyTracksPlayed != null)
        'spotify_tracks_played': spotifyTracksPlayed,
      if (playlistUsed != null) 'playlist_used': playlistUsed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? routineId,
    Value<String>? name,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<String>? status,
    Value<DateTime?>? scheduledDate,
    Value<bool>? wasScheduled,
    Value<int?>? xpEarned,
    Value<int?>? personalRecords,
    Value<bool>? spotifyUsed,
    Value<int>? spotifyTracksPlayed,
    Value<bool>? playlistUsed,
    Value<int>? rowid,
  }) {
    return WorkoutSessionsCompanion(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      name: name ?? this.name,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      wasScheduled: wasScheduled ?? this.wasScheduled,
      xpEarned: xpEarned ?? this.xpEarned,
      personalRecords: personalRecords ?? this.personalRecords,
      spotifyUsed: spotifyUsed ?? this.spotifyUsed,
      spotifyTracksPlayed: spotifyTracksPlayed ?? this.spotifyTracksPlayed,
      playlistUsed: playlistUsed ?? this.playlistUsed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (wasScheduled.present) {
      map['was_scheduled'] = Variable<bool>(wasScheduled.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (personalRecords.present) {
      map['personal_records'] = Variable<int>(personalRecords.value);
    }
    if (spotifyUsed.present) {
      map['spotify_used'] = Variable<bool>(spotifyUsed.value);
    }
    if (spotifyTracksPlayed.present) {
      map['spotify_tracks_played'] = Variable<int>(spotifyTracksPlayed.value);
    }
    if (playlistUsed.present) {
      map['playlist_used'] = Variable<bool>(playlistUsed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSessionsCompanion(')
          ..write('id: $id, ')
          ..write('routineId: $routineId, ')
          ..write('name: $name, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('status: $status, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('wasScheduled: $wasScheduled, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('personalRecords: $personalRecords, ')
          ..write('spotifyUsed: $spotifyUsed, ')
          ..write('spotifyTracksPlayed: $spotifyTracksPlayed, ')
          ..write('playlistUsed: $playlistUsed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionExercisesTable extends SessionExercises
    with TableInfo<$SessionExercisesTable, SessionExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReplacedMeta = const VerificationMeta(
    'isReplaced',
  );
  @override
  late final GeneratedColumn<bool> isReplaced = GeneratedColumn<bool>(
    'is_replaced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_replaced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    exerciseId,
    position,
    notes,
    isReplaced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_replaced')) {
      context.handle(
        _isReplacedMeta,
        isReplaced.isAcceptableOrUnknown(data['is_replaced']!, _isReplacedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isReplaced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_replaced'],
      )!,
    );
  }

  @override
  $SessionExercisesTable createAlias(String alias) {
    return $SessionExercisesTable(attachedDatabase, alias);
  }
}

class SessionExerciseRow extends DataClass
    implements Insertable<SessionExerciseRow> {
  final String id;
  final String sessionId;
  final String exerciseId;
  final int position;
  final String? notes;
  final bool isReplaced;
  const SessionExerciseRow({
    required this.id,
    required this.sessionId,
    required this.exerciseId,
    required this.position,
    this.notes,
    required this.isReplaced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_replaced'] = Variable<bool>(isReplaced);
    return map;
  }

  SessionExercisesCompanion toCompanion(bool nullToAbsent) {
    return SessionExercisesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      exerciseId: Value(exerciseId),
      position: Value(position),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isReplaced: Value(isReplaced),
    );
  }

  factory SessionExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionExerciseRow(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      position: serializer.fromJson<int>(json['position']),
      notes: serializer.fromJson<String?>(json['notes']),
      isReplaced: serializer.fromJson<bool>(json['isReplaced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'position': serializer.toJson<int>(position),
      'notes': serializer.toJson<String?>(notes),
      'isReplaced': serializer.toJson<bool>(isReplaced),
    };
  }

  SessionExerciseRow copyWith({
    String? id,
    String? sessionId,
    String? exerciseId,
    int? position,
    Value<String?> notes = const Value.absent(),
    bool? isReplaced,
  }) => SessionExerciseRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    notes: notes.present ? notes.value : this.notes,
    isReplaced: isReplaced ?? this.isReplaced,
  );
  SessionExerciseRow copyWithCompanion(SessionExercisesCompanion data) {
    return SessionExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      notes: data.notes.present ? data.notes.value : this.notes,
      isReplaced: data.isReplaced.present
          ? data.isReplaced.value
          : this.isReplaced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionExerciseRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('notes: $notes, ')
          ..write('isReplaced: $isReplaced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sessionId, exerciseId, position, notes, isReplaced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionExerciseRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.notes == this.notes &&
          other.isReplaced == this.isReplaced);
}

class SessionExercisesCompanion extends UpdateCompanion<SessionExerciseRow> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> exerciseId;
  final Value<int> position;
  final Value<String?> notes;
  final Value<bool> isReplaced;
  final Value<int> rowid;
  const SessionExercisesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.notes = const Value.absent(),
    this.isReplaced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionExercisesCompanion.insert({
    required String id,
    required String sessionId,
    required String exerciseId,
    required int position,
    this.notes = const Value.absent(),
    this.isReplaced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       exerciseId = Value(exerciseId),
       position = Value(position);
  static Insertable<SessionExerciseRow> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? exerciseId,
    Expression<int>? position,
    Expression<String>? notes,
    Expression<bool>? isReplaced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (notes != null) 'notes': notes,
      if (isReplaced != null) 'is_replaced': isReplaced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? exerciseId,
    Value<int>? position,
    Value<String?>? notes,
    Value<bool>? isReplaced,
    Value<int>? rowid,
  }) {
    return SessionExercisesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      notes: notes ?? this.notes,
      isReplaced: isReplaced ?? this.isReplaced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isReplaced.present) {
      map['is_replaced'] = Variable<bool>(isReplaced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionExercisesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('notes: $notes, ')
          ..write('isReplaced: $isReplaced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionSetsTable extends SessionSets
    with TableInfo<$SessionSetsTable, SessionSetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionExerciseIdMeta = const VerificationMeta(
    'sessionExerciseId',
  );
  @override
  late final GeneratedColumn<String> sessionExerciseId =
      GeneratedColumn<String>(
        'session_exercise_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setIndexMeta = const VerificationMeta(
    'setIndex',
  );
  @override
  late final GeneratedColumn<int> setIndex = GeneratedColumn<int>(
    'set_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isWarmUpMeta = const VerificationMeta(
    'isWarmUp',
  );
  @override
  late final GeneratedColumn<bool> isWarmUp = GeneratedColumn<bool>(
    'is_warm_up',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_warm_up" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionExerciseId,
    exerciseId,
    setIndex,
    weightKg,
    reps,
    durationSeconds,
    completed,
    completedAt,
    isWarmUp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionSetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_exercise_id')) {
      context.handle(
        _sessionExerciseIdMeta,
        sessionExerciseId.isAcceptableOrUnknown(
          data['session_exercise_id']!,
          _sessionExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionExerciseIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('set_index')) {
      context.handle(
        _setIndexMeta,
        setIndex.isAcceptableOrUnknown(data['set_index']!, _setIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_setIndexMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('is_warm_up')) {
      context.handle(
        _isWarmUpMeta,
        isWarmUp.isAcceptableOrUnknown(data['is_warm_up']!, _isWarmUpMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionSetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionSetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_exercise_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      setIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_index'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      isWarmUp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_warm_up'],
      )!,
    );
  }

  @override
  $SessionSetsTable createAlias(String alias) {
    return $SessionSetsTable(attachedDatabase, alias);
  }
}

class SessionSetRow extends DataClass implements Insertable<SessionSetRow> {
  final String id;
  final String sessionExerciseId;
  final String exerciseId;
  final int setIndex;
  final double weightKg;
  final int reps;
  final int? durationSeconds;
  final bool completed;
  final DateTime? completedAt;
  final bool isWarmUp;
  const SessionSetRow({
    required this.id,
    required this.sessionExerciseId,
    required this.exerciseId,
    required this.setIndex,
    required this.weightKg,
    required this.reps,
    this.durationSeconds,
    required this.completed,
    this.completedAt,
    required this.isWarmUp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_exercise_id'] = Variable<String>(sessionExerciseId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['set_index'] = Variable<int>(setIndex);
    map['weight_kg'] = Variable<double>(weightKg);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['is_warm_up'] = Variable<bool>(isWarmUp);
    return map;
  }

  SessionSetsCompanion toCompanion(bool nullToAbsent) {
    return SessionSetsCompanion(
      id: Value(id),
      sessionExerciseId: Value(sessionExerciseId),
      exerciseId: Value(exerciseId),
      setIndex: Value(setIndex),
      weightKg: Value(weightKg),
      reps: Value(reps),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      isWarmUp: Value(isWarmUp),
    );
  }

  factory SessionSetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionSetRow(
      id: serializer.fromJson<String>(json['id']),
      sessionExerciseId: serializer.fromJson<String>(json['sessionExerciseId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      setIndex: serializer.fromJson<int>(json['setIndex']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      reps: serializer.fromJson<int>(json['reps']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      isWarmUp: serializer.fromJson<bool>(json['isWarmUp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionExerciseId': serializer.toJson<String>(sessionExerciseId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'setIndex': serializer.toJson<int>(setIndex),
      'weightKg': serializer.toJson<double>(weightKg),
      'reps': serializer.toJson<int>(reps),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'isWarmUp': serializer.toJson<bool>(isWarmUp),
    };
  }

  SessionSetRow copyWith({
    String? id,
    String? sessionExerciseId,
    String? exerciseId,
    int? setIndex,
    double? weightKg,
    int? reps,
    Value<int?> durationSeconds = const Value.absent(),
    bool? completed,
    Value<DateTime?> completedAt = const Value.absent(),
    bool? isWarmUp,
  }) => SessionSetRow(
    id: id ?? this.id,
    sessionExerciseId: sessionExerciseId ?? this.sessionExerciseId,
    exerciseId: exerciseId ?? this.exerciseId,
    setIndex: setIndex ?? this.setIndex,
    weightKg: weightKg ?? this.weightKg,
    reps: reps ?? this.reps,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    completed: completed ?? this.completed,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    isWarmUp: isWarmUp ?? this.isWarmUp,
  );
  SessionSetRow copyWithCompanion(SessionSetsCompanion data) {
    return SessionSetRow(
      id: data.id.present ? data.id.value : this.id,
      sessionExerciseId: data.sessionExerciseId.present
          ? data.sessionExerciseId.value
          : this.sessionExerciseId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      setIndex: data.setIndex.present ? data.setIndex.value : this.setIndex,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      isWarmUp: data.isWarmUp.present ? data.isWarmUp.value : this.isWarmUp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionSetRow(')
          ..write('id: $id, ')
          ..write('sessionExerciseId: $sessionExerciseId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setIndex: $setIndex, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('isWarmUp: $isWarmUp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionExerciseId,
    exerciseId,
    setIndex,
    weightKg,
    reps,
    durationSeconds,
    completed,
    completedAt,
    isWarmUp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionSetRow &&
          other.id == this.id &&
          other.sessionExerciseId == this.sessionExerciseId &&
          other.exerciseId == this.exerciseId &&
          other.setIndex == this.setIndex &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.durationSeconds == this.durationSeconds &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.isWarmUp == this.isWarmUp);
}

class SessionSetsCompanion extends UpdateCompanion<SessionSetRow> {
  final Value<String> id;
  final Value<String> sessionExerciseId;
  final Value<String> exerciseId;
  final Value<int> setIndex;
  final Value<double> weightKg;
  final Value<int> reps;
  final Value<int?> durationSeconds;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<bool> isWarmUp;
  final Value<int> rowid;
  const SessionSetsCompanion({
    this.id = const Value.absent(),
    this.sessionExerciseId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setIndex = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isWarmUp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionSetsCompanion.insert({
    required String id,
    required String sessionExerciseId,
    required String exerciseId,
    required int setIndex,
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.isWarmUp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionExerciseId = Value(sessionExerciseId),
       exerciseId = Value(exerciseId),
       setIndex = Value(setIndex);
  static Insertable<SessionSetRow> custom({
    Expression<String>? id,
    Expression<String>? sessionExerciseId,
    Expression<String>? exerciseId,
    Expression<int>? setIndex,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<int>? durationSeconds,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<bool>? isWarmUp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionExerciseId != null) 'session_exercise_id': sessionExerciseId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (setIndex != null) 'set_index': setIndex,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (isWarmUp != null) 'is_warm_up': isWarmUp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionSetsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionExerciseId,
    Value<String>? exerciseId,
    Value<int>? setIndex,
    Value<double>? weightKg,
    Value<int>? reps,
    Value<int?>? durationSeconds,
    Value<bool>? completed,
    Value<DateTime?>? completedAt,
    Value<bool>? isWarmUp,
    Value<int>? rowid,
  }) {
    return SessionSetsCompanion(
      id: id ?? this.id,
      sessionExerciseId: sessionExerciseId ?? this.sessionExerciseId,
      exerciseId: exerciseId ?? this.exerciseId,
      setIndex: setIndex ?? this.setIndex,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      isWarmUp: isWarmUp ?? this.isWarmUp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionExerciseId.present) {
      map['session_exercise_id'] = Variable<String>(sessionExerciseId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (setIndex.present) {
      map['set_index'] = Variable<int>(setIndex.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (isWarmUp.present) {
      map['is_warm_up'] = Variable<bool>(isWarmUp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionSetsCompanion(')
          ..write('id: $id, ')
          ..write('sessionExerciseId: $sessionExerciseId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setIndex: $setIndex, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('isWarmUp: $isWarmUp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScheduleEntriesTable extends ScheduleEntries
    with TableInfo<$ScheduleEntriesTable, ScheduleEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScheduleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _routineIdMeta = const VerificationMeta(
    'routineId',
  );
  @override
  late final GeneratedColumn<String> routineId = GeneratedColumn<String>(
    'routine_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, routineId, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schedule_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScheduleEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('routine_id')) {
      context.handle(
        _routineIdMeta,
        routineId.isAcceptableOrUnknown(data['routine_id']!, _routineIdMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScheduleEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScheduleEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      routineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_id'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
    );
  }

  @override
  $ScheduleEntriesTable createAlias(String alias) {
    return $ScheduleEntriesTable(attachedDatabase, alias);
  }
}

class ScheduleEntryRow extends DataClass
    implements Insertable<ScheduleEntryRow> {
  final String id;
  final DateTime date;
  final String? routineId;
  final String? label;
  const ScheduleEntryRow({
    required this.id,
    required this.date,
    this.routineId,
    this.label,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || routineId != null) {
      map['routine_id'] = Variable<String>(routineId);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  ScheduleEntriesCompanion toCompanion(bool nullToAbsent) {
    return ScheduleEntriesCompanion(
      id: Value(id),
      date: Value(date),
      routineId: routineId == null && nullToAbsent
          ? const Value.absent()
          : Value(routineId),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
    );
  }

  factory ScheduleEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScheduleEntryRow(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      routineId: serializer.fromJson<String?>(json['routineId']),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'routineId': serializer.toJson<String?>(routineId),
      'label': serializer.toJson<String?>(label),
    };
  }

  ScheduleEntryRow copyWith({
    String? id,
    DateTime? date,
    Value<String?> routineId = const Value.absent(),
    Value<String?> label = const Value.absent(),
  }) => ScheduleEntryRow(
    id: id ?? this.id,
    date: date ?? this.date,
    routineId: routineId.present ? routineId.value : this.routineId,
    label: label.present ? label.value : this.label,
  );
  ScheduleEntryRow copyWithCompanion(ScheduleEntriesCompanion data) {
    return ScheduleEntryRow(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      routineId: data.routineId.present ? data.routineId.value : this.routineId,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleEntryRow(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('routineId: $routineId, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, routineId, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScheduleEntryRow &&
          other.id == this.id &&
          other.date == this.date &&
          other.routineId == this.routineId &&
          other.label == this.label);
}

class ScheduleEntriesCompanion extends UpdateCompanion<ScheduleEntryRow> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String?> routineId;
  final Value<String?> label;
  final Value<int> rowid;
  const ScheduleEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.routineId = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScheduleEntriesCompanion.insert({
    required String id,
    required DateTime date,
    this.routineId = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date);
  static Insertable<ScheduleEntryRow> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? routineId,
    Expression<String>? label,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (routineId != null) 'routine_id': routineId,
      if (label != null) 'label': label,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScheduleEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<String?>? routineId,
    Value<String?>? label,
    Value<int>? rowid,
  }) {
    return ScheduleEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      routineId: routineId ?? this.routineId,
      label: label ?? this.label,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (routineId.present) {
      map['routine_id'] = Variable<String>(routineId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScheduleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('routineId: $routineId, ')
          ..write('label: $label, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousValueMeta = const VerificationMeta(
    'previousValue',
  );
  @override
  late final GeneratedColumn<double> previousValue = GeneratedColumn<double>(
    'previous_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutSessionIdMeta = const VerificationMeta(
    'workoutSessionId',
  );
  @override
  late final GeneratedColumn<String> workoutSessionId = GeneratedColumn<String>(
    'workout_session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    exerciseId,
    exerciseName,
    type,
    value,
    weightKg,
    reps,
    previousValue,
    achievedAt,
    workoutSessionId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('previous_value')) {
      context.handle(
        _previousValueMeta,
        previousValue.isAcceptableOrUnknown(
          data['previous_value']!,
          _previousValueMeta,
        ),
      );
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    if (data.containsKey('workout_session_id')) {
      context.handle(
        _workoutSessionIdMeta,
        workoutSessionId.isAcceptableOrUnknown(
          data['workout_session_id']!,
          _workoutSessionIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      previousValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}previous_value'],
      ),
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      )!,
      workoutSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_session_id'],
      ),
    );
  }

  @override
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecordRow extends DataClass
    implements Insertable<PersonalRecordRow> {
  final String id;
  final String userId;
  final String exerciseId;
  final String exerciseName;
  final String type;
  final double value;
  final double? weightKg;
  final int? reps;
  final double? previousValue;
  final DateTime achievedAt;
  final String? workoutSessionId;
  const PersonalRecordRow({
    required this.id,
    required this.userId,
    required this.exerciseId,
    required this.exerciseName,
    required this.type,
    required this.value,
    this.weightKg,
    this.reps,
    this.previousValue,
    required this.achievedAt,
    this.workoutSessionId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['type'] = Variable<String>(type);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || previousValue != null) {
      map['previous_value'] = Variable<double>(previousValue);
    }
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    if (!nullToAbsent || workoutSessionId != null) {
      map['workout_session_id'] = Variable<String>(workoutSessionId);
    }
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      id: Value(id),
      userId: Value(userId),
      exerciseId: Value(exerciseId),
      exerciseName: Value(exerciseName),
      type: Value(type),
      value: Value(value),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      previousValue: previousValue == null && nullToAbsent
          ? const Value.absent()
          : Value(previousValue),
      achievedAt: Value(achievedAt),
      workoutSessionId: workoutSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutSessionId),
    );
  }

  factory PersonalRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecordRow(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      type: serializer.fromJson<String>(json['type']),
      value: serializer.fromJson<double>(json['value']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      reps: serializer.fromJson<int?>(json['reps']),
      previousValue: serializer.fromJson<double?>(json['previousValue']),
      achievedAt: serializer.fromJson<DateTime>(json['achievedAt']),
      workoutSessionId: serializer.fromJson<String?>(json['workoutSessionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'type': serializer.toJson<String>(type),
      'value': serializer.toJson<double>(value),
      'weightKg': serializer.toJson<double?>(weightKg),
      'reps': serializer.toJson<int?>(reps),
      'previousValue': serializer.toJson<double?>(previousValue),
      'achievedAt': serializer.toJson<DateTime>(achievedAt),
      'workoutSessionId': serializer.toJson<String?>(workoutSessionId),
    };
  }

  PersonalRecordRow copyWith({
    String? id,
    String? userId,
    String? exerciseId,
    String? exerciseName,
    String? type,
    double? value,
    Value<double?> weightKg = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    Value<double?> previousValue = const Value.absent(),
    DateTime? achievedAt,
    Value<String?> workoutSessionId = const Value.absent(),
  }) => PersonalRecordRow(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    exerciseId: exerciseId ?? this.exerciseId,
    exerciseName: exerciseName ?? this.exerciseName,
    type: type ?? this.type,
    value: value ?? this.value,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    reps: reps.present ? reps.value : this.reps,
    previousValue: previousValue.present
        ? previousValue.value
        : this.previousValue,
    achievedAt: achievedAt ?? this.achievedAt,
    workoutSessionId: workoutSessionId.present
        ? workoutSessionId.value
        : this.workoutSessionId,
  );
  PersonalRecordRow copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecordRow(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      reps: data.reps.present ? data.reps.value : this.reps,
      previousValue: data.previousValue.present
          ? data.previousValue.value
          : this.previousValue,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
      workoutSessionId: data.workoutSessionId.present
          ? data.workoutSessionId.value
          : this.workoutSessionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordRow(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('previousValue: $previousValue, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('workoutSessionId: $workoutSessionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    exerciseId,
    exerciseName,
    type,
    value,
    weightKg,
    reps,
    previousValue,
    achievedAt,
    workoutSessionId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecordRow &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.exerciseId == this.exerciseId &&
          other.exerciseName == this.exerciseName &&
          other.type == this.type &&
          other.value == this.value &&
          other.weightKg == this.weightKg &&
          other.reps == this.reps &&
          other.previousValue == this.previousValue &&
          other.achievedAt == this.achievedAt &&
          other.workoutSessionId == this.workoutSessionId);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecordRow> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> exerciseId;
  final Value<String> exerciseName;
  final Value<String> type;
  final Value<double> value;
  final Value<double?> weightKg;
  final Value<int?> reps;
  final Value<double?> previousValue;
  final Value<DateTime> achievedAt;
  final Value<String?> workoutSessionId;
  final Value<int> rowid;
  const PersonalRecordsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.previousValue = const Value.absent(),
    this.achievedAt = const Value.absent(),
    this.workoutSessionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    required String id,
    required String userId,
    required String exerciseId,
    required String exerciseName,
    required String type,
    required double value,
    this.weightKg = const Value.absent(),
    this.reps = const Value.absent(),
    this.previousValue = const Value.absent(),
    required DateTime achievedAt,
    this.workoutSessionId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       exerciseId = Value(exerciseId),
       exerciseName = Value(exerciseName),
       type = Value(type),
       value = Value(value),
       achievedAt = Value(achievedAt);
  static Insertable<PersonalRecordRow> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? exerciseId,
    Expression<String>? exerciseName,
    Expression<String>? type,
    Expression<double>? value,
    Expression<double>? weightKg,
    Expression<int>? reps,
    Expression<double>? previousValue,
    Expression<DateTime>? achievedAt,
    Expression<String>? workoutSessionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (weightKg != null) 'weight_kg': weightKg,
      if (reps != null) 'reps': reps,
      if (previousValue != null) 'previous_value': previousValue,
      if (achievedAt != null) 'achieved_at': achievedAt,
      if (workoutSessionId != null) 'workout_session_id': workoutSessionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonalRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? exerciseId,
    Value<String>? exerciseName,
    Value<String>? type,
    Value<double>? value,
    Value<double?>? weightKg,
    Value<int?>? reps,
    Value<double?>? previousValue,
    Value<DateTime>? achievedAt,
    Value<String?>? workoutSessionId,
    Value<int>? rowid,
  }) {
    return PersonalRecordsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      type: type ?? this.type,
      value: value ?? this.value,
      weightKg: weightKg ?? this.weightKg,
      reps: reps ?? this.reps,
      previousValue: previousValue ?? this.previousValue,
      achievedAt: achievedAt ?? this.achievedAt,
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (previousValue.present) {
      map['previous_value'] = Variable<double>(previousValue.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    if (workoutSessionId.present) {
      map['workout_session_id'] = Variable<String>(workoutSessionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('weightKg: $weightKg, ')
          ..write('reps: $reps, ')
          ..write('previousValue: $previousValue, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('workoutSessionId: $workoutSessionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, AchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _familyMeta = const VerificationMeta('family');
  @override
  late final GeneratedColumn<String> family = GeneratedColumn<String>(
    'family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricMeta = const VerificationMeta('metric');
  @override
  late final GeneratedColumn<String> metric = GeneratedColumn<String>(
    'metric',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thresholdMeta = const VerificationMeta(
    'threshold',
  );
  @override
  late final GeneratedColumn<int> threshold = GeneratedColumn<int>(
    'threshold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _badgeIdMeta = const VerificationMeta(
    'badgeId',
  );
  @override
  late final GeneratedColumn<String> badgeId = GeneratedColumn<String>(
    'badge_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    family,
    metric,
    threshold,
    xpReward,
    icon,
    badgeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('family')) {
      context.handle(
        _familyMeta,
        family.isAcceptableOrUnknown(data['family']!, _familyMeta),
      );
    } else if (isInserting) {
      context.missing(_familyMeta);
    }
    if (data.containsKey('metric')) {
      context.handle(
        _metricMeta,
        metric.isAcceptableOrUnknown(data['metric']!, _metricMeta),
      );
    } else if (isInserting) {
      context.missing(_metricMeta);
    }
    if (data.containsKey('threshold')) {
      context.handle(
        _thresholdMeta,
        threshold.isAcceptableOrUnknown(data['threshold']!, _thresholdMeta),
      );
    } else if (isInserting) {
      context.missing(_thresholdMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('badge_id')) {
      context.handle(
        _badgeIdMeta,
        badgeId.isAcceptableOrUnknown(data['badge_id']!, _badgeIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      family: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}family'],
      )!,
      metric: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric'],
      )!,
      threshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}threshold'],
      )!,
      xpReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_reward'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      badgeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge_id'],
      ),
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class AchievementRow extends DataClass implements Insertable<AchievementRow> {
  final String id;
  final String name;
  final String description;
  final String family;
  final String metric;
  final int threshold;
  final int xpReward;
  final String? icon;
  final String? badgeId;
  const AchievementRow({
    required this.id,
    required this.name,
    required this.description,
    required this.family,
    required this.metric,
    required this.threshold,
    required this.xpReward,
    this.icon,
    this.badgeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['family'] = Variable<String>(family);
    map['metric'] = Variable<String>(metric);
    map['threshold'] = Variable<int>(threshold);
    map['xp_reward'] = Variable<int>(xpReward);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || badgeId != null) {
      map['badge_id'] = Variable<String>(badgeId);
    }
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      family: Value(family),
      metric: Value(metric),
      threshold: Value(threshold),
      xpReward: Value(xpReward),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      badgeId: badgeId == null && nullToAbsent
          ? const Value.absent()
          : Value(badgeId),
    );
  }

  factory AchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      family: serializer.fromJson<String>(json['family']),
      metric: serializer.fromJson<String>(json['metric']),
      threshold: serializer.fromJson<int>(json['threshold']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      icon: serializer.fromJson<String?>(json['icon']),
      badgeId: serializer.fromJson<String?>(json['badgeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'family': serializer.toJson<String>(family),
      'metric': serializer.toJson<String>(metric),
      'threshold': serializer.toJson<int>(threshold),
      'xpReward': serializer.toJson<int>(xpReward),
      'icon': serializer.toJson<String?>(icon),
      'badgeId': serializer.toJson<String?>(badgeId),
    };
  }

  AchievementRow copyWith({
    String? id,
    String? name,
    String? description,
    String? family,
    String? metric,
    int? threshold,
    int? xpReward,
    Value<String?> icon = const Value.absent(),
    Value<String?> badgeId = const Value.absent(),
  }) => AchievementRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    family: family ?? this.family,
    metric: metric ?? this.metric,
    threshold: threshold ?? this.threshold,
    xpReward: xpReward ?? this.xpReward,
    icon: icon.present ? icon.value : this.icon,
    badgeId: badgeId.present ? badgeId.value : this.badgeId,
  );
  AchievementRow copyWithCompanion(AchievementsCompanion data) {
    return AchievementRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      family: data.family.present ? data.family.value : this.family,
      metric: data.metric.present ? data.metric.value : this.metric,
      threshold: data.threshold.present ? data.threshold.value : this.threshold,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      icon: data.icon.present ? data.icon.value : this.icon,
      badgeId: data.badgeId.present ? data.badgeId.value : this.badgeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('family: $family, ')
          ..write('metric: $metric, ')
          ..write('threshold: $threshold, ')
          ..write('xpReward: $xpReward, ')
          ..write('icon: $icon, ')
          ..write('badgeId: $badgeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    family,
    metric,
    threshold,
    xpReward,
    icon,
    badgeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.family == this.family &&
          other.metric == this.metric &&
          other.threshold == this.threshold &&
          other.xpReward == this.xpReward &&
          other.icon == this.icon &&
          other.badgeId == this.badgeId);
}

class AchievementsCompanion extends UpdateCompanion<AchievementRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> family;
  final Value<String> metric;
  final Value<int> threshold;
  final Value<int> xpReward;
  final Value<String?> icon;
  final Value<String?> badgeId;
  final Value<int> rowid;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.family = const Value.absent(),
    this.metric = const Value.absent(),
    this.threshold = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.icon = const Value.absent(),
    this.badgeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsCompanion.insert({
    required String id,
    required String name,
    required String description,
    required String family,
    required String metric,
    required int threshold,
    required int xpReward,
    this.icon = const Value.absent(),
    this.badgeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description),
       family = Value(family),
       metric = Value(metric),
       threshold = Value(threshold),
       xpReward = Value(xpReward);
  static Insertable<AchievementRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? family,
    Expression<String>? metric,
    Expression<int>? threshold,
    Expression<int>? xpReward,
    Expression<String>? icon,
    Expression<String>? badgeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (family != null) 'family': family,
      if (metric != null) 'metric': metric,
      if (threshold != null) 'threshold': threshold,
      if (xpReward != null) 'xp_reward': xpReward,
      if (icon != null) 'icon': icon,
      if (badgeId != null) 'badge_id': badgeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? family,
    Value<String>? metric,
    Value<int>? threshold,
    Value<int>? xpReward,
    Value<String?>? icon,
    Value<String?>? badgeId,
    Value<int>? rowid,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      family: family ?? this.family,
      metric: metric ?? this.metric,
      threshold: threshold ?? this.threshold,
      xpReward: xpReward ?? this.xpReward,
      icon: icon ?? this.icon,
      badgeId: badgeId ?? this.badgeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (family.present) {
      map['family'] = Variable<String>(family.value);
    }
    if (metric.present) {
      map['metric'] = Variable<String>(metric.value);
    }
    if (threshold.present) {
      map['threshold'] = Variable<int>(threshold.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (badgeId.present) {
      map['badge_id'] = Variable<String>(badgeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('family: $family, ')
          ..write('metric: $metric, ')
          ..write('threshold: $threshold, ')
          ..write('xpReward: $xpReward, ')
          ..write('icon: $icon, ')
          ..write('badgeId: $badgeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAchievementsTable extends UserAchievements
    with TableInfo<$UserAchievementsTable, UserAchievementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _achievementIdMeta = const VerificationMeta(
    'achievementId',
  );
  @override
  late final GeneratedColumn<String> achievementId = GeneratedColumn<String>(
    'achievement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<int> progress = GeneratedColumn<int>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unlockedMeta = const VerificationMeta(
    'unlocked',
  );
  @override
  late final GeneratedColumn<bool> unlocked = GeneratedColumn<bool>(
    'unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    achievementId,
    userId,
    progress,
    unlocked,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAchievementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('achievement_id')) {
      context.handle(
        _achievementIdMeta,
        achievementId.isAcceptableOrUnknown(
          data['achievement_id']!,
          _achievementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('unlocked')) {
      context.handle(
        _unlockedMeta,
        unlocked.isAcceptableOrUnknown(data['unlocked']!, _unlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {achievementId, userId};
  @override
  UserAchievementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAchievementRow(
      achievementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress'],
      )!,
      unlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $UserAchievementsTable createAlias(String alias) {
    return $UserAchievementsTable(attachedDatabase, alias);
  }
}

class UserAchievementRow extends DataClass
    implements Insertable<UserAchievementRow> {
  final String achievementId;
  final String userId;
  final int progress;
  final bool unlocked;
  final DateTime? unlockedAt;
  const UserAchievementRow({
    required this.achievementId,
    required this.userId,
    required this.progress,
    required this.unlocked,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['achievement_id'] = Variable<String>(achievementId);
    map['user_id'] = Variable<String>(userId);
    map['progress'] = Variable<int>(progress);
    map['unlocked'] = Variable<bool>(unlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  UserAchievementsCompanion toCompanion(bool nullToAbsent) {
    return UserAchievementsCompanion(
      achievementId: Value(achievementId),
      userId: Value(userId),
      progress: Value(progress),
      unlocked: Value(unlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory UserAchievementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAchievementRow(
      achievementId: serializer.fromJson<String>(json['achievementId']),
      userId: serializer.fromJson<String>(json['userId']),
      progress: serializer.fromJson<int>(json['progress']),
      unlocked: serializer.fromJson<bool>(json['unlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'achievementId': serializer.toJson<String>(achievementId),
      'userId': serializer.toJson<String>(userId),
      'progress': serializer.toJson<int>(progress),
      'unlocked': serializer.toJson<bool>(unlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  UserAchievementRow copyWith({
    String? achievementId,
    String? userId,
    int? progress,
    bool? unlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
  }) => UserAchievementRow(
    achievementId: achievementId ?? this.achievementId,
    userId: userId ?? this.userId,
    progress: progress ?? this.progress,
    unlocked: unlocked ?? this.unlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  UserAchievementRow copyWithCompanion(UserAchievementsCompanion data) {
    return UserAchievementRow(
      achievementId: data.achievementId.present
          ? data.achievementId.value
          : this.achievementId,
      userId: data.userId.present ? data.userId.value : this.userId,
      progress: data.progress.present ? data.progress.value : this.progress,
      unlocked: data.unlocked.present ? data.unlocked.value : this.unlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievementRow(')
          ..write('achievementId: $achievementId, ')
          ..write('userId: $userId, ')
          ..write('progress: $progress, ')
          ..write('unlocked: $unlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(achievementId, userId, progress, unlocked, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAchievementRow &&
          other.achievementId == this.achievementId &&
          other.userId == this.userId &&
          other.progress == this.progress &&
          other.unlocked == this.unlocked &&
          other.unlockedAt == this.unlockedAt);
}

class UserAchievementsCompanion extends UpdateCompanion<UserAchievementRow> {
  final Value<String> achievementId;
  final Value<String> userId;
  final Value<int> progress;
  final Value<bool> unlocked;
  final Value<DateTime?> unlockedAt;
  final Value<int> rowid;
  const UserAchievementsCompanion({
    this.achievementId = const Value.absent(),
    this.userId = const Value.absent(),
    this.progress = const Value.absent(),
    this.unlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAchievementsCompanion.insert({
    required String achievementId,
    required String userId,
    this.progress = const Value.absent(),
    this.unlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : achievementId = Value(achievementId),
       userId = Value(userId);
  static Insertable<UserAchievementRow> custom({
    Expression<String>? achievementId,
    Expression<String>? userId,
    Expression<int>? progress,
    Expression<bool>? unlocked,
    Expression<DateTime>? unlockedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (achievementId != null) 'achievement_id': achievementId,
      if (userId != null) 'user_id': userId,
      if (progress != null) 'progress': progress,
      if (unlocked != null) 'unlocked': unlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAchievementsCompanion copyWith({
    Value<String>? achievementId,
    Value<String>? userId,
    Value<int>? progress,
    Value<bool>? unlocked,
    Value<DateTime?>? unlockedAt,
    Value<int>? rowid,
  }) {
    return UserAchievementsCompanion(
      achievementId: achievementId ?? this.achievementId,
      userId: userId ?? this.userId,
      progress: progress ?? this.progress,
      unlocked: unlocked ?? this.unlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (achievementId.present) {
      map['achievement_id'] = Variable<String>(achievementId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (progress.present) {
      map['progress'] = Variable<int>(progress.value);
    }
    if (unlocked.present) {
      map['unlocked'] = Variable<bool>(unlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAchievementsCompanion(')
          ..write('achievementId: $achievementId, ')
          ..write('userId: $userId, ')
          ..write('progress: $progress, ')
          ..write('unlocked: $unlocked, ')
          ..write('unlockedAt: $unlockedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BadgesTable extends Badges with TableInfo<$BadgesTable, BadgeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BadgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
    'emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, emoji, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'badges';
  @override
  VerificationContext validateIntegrity(
    Insertable<BadgeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
        _emojiMeta,
        emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta),
      );
    } else if (isInserting) {
      context.missing(_emojiMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BadgeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BadgeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      emoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emoji'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
    );
  }

  @override
  $BadgesTable createAlias(String alias) {
    return $BadgesTable(attachedDatabase, alias);
  }
}

class BadgeRow extends DataClass implements Insertable<BadgeRow> {
  final String id;
  final String name;
  final String emoji;
  final String description;
  const BadgeRow({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['emoji'] = Variable<String>(emoji);
    map['description'] = Variable<String>(description);
    return map;
  }

  BadgesCompanion toCompanion(bool nullToAbsent) {
    return BadgesCompanion(
      id: Value(id),
      name: Value(name),
      emoji: Value(emoji),
      description: Value(description),
    );
  }

  factory BadgeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BadgeRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      emoji: serializer.fromJson<String>(json['emoji']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'emoji': serializer.toJson<String>(emoji),
      'description': serializer.toJson<String>(description),
    };
  }

  BadgeRow copyWith({
    String? id,
    String? name,
    String? emoji,
    String? description,
  }) => BadgeRow(
    id: id ?? this.id,
    name: name ?? this.name,
    emoji: emoji ?? this.emoji,
    description: description ?? this.description,
  );
  BadgeRow copyWithCompanion(BadgesCompanion data) {
    return BadgeRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BadgeRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, emoji, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BadgeRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.emoji == this.emoji &&
          other.description == this.description);
}

class BadgesCompanion extends UpdateCompanion<BadgeRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> emoji;
  final Value<String> description;
  final Value<int> rowid;
  const BadgesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.emoji = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BadgesCompanion.insert({
    required String id,
    required String name,
    required String emoji,
    required String description,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       emoji = Value(emoji),
       description = Value(description);
  static Insertable<BadgeRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? emoji,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (emoji != null) 'emoji': emoji,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BadgesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? emoji,
    Value<String>? description,
    Value<int>? rowid,
  }) {
    return BadgesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BadgesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('emoji: $emoji, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserBadgesTable extends UserBadges
    with TableInfo<$UserBadgesTable, UserBadgeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserBadgesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _badgeIdMeta = const VerificationMeta(
    'badgeId',
  );
  @override
  late final GeneratedColumn<String> badgeId = GeneratedColumn<String>(
    'badge_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _earnedAtMeta = const VerificationMeta(
    'earnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> earnedAt = GeneratedColumn<DateTime>(
    'earned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isShowcasedMeta = const VerificationMeta(
    'isShowcased',
  );
  @override
  late final GeneratedColumn<bool> isShowcased = GeneratedColumn<bool>(
    'is_showcased',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_showcased" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    badgeId,
    userId,
    earnedAt,
    isShowcased,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_badges';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserBadgeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('badge_id')) {
      context.handle(
        _badgeIdMeta,
        badgeId.isAcceptableOrUnknown(data['badge_id']!, _badgeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_badgeIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('earned_at')) {
      context.handle(
        _earnedAtMeta,
        earnedAt.isAcceptableOrUnknown(data['earned_at']!, _earnedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_earnedAtMeta);
    }
    if (data.containsKey('is_showcased')) {
      context.handle(
        _isShowcasedMeta,
        isShowcased.isAcceptableOrUnknown(
          data['is_showcased']!,
          _isShowcasedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {badgeId, userId};
  @override
  UserBadgeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserBadgeRow(
      badgeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      earnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}earned_at'],
      )!,
      isShowcased: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_showcased'],
      )!,
    );
  }

  @override
  $UserBadgesTable createAlias(String alias) {
    return $UserBadgesTable(attachedDatabase, alias);
  }
}

class UserBadgeRow extends DataClass implements Insertable<UserBadgeRow> {
  final String badgeId;
  final String userId;
  final DateTime earnedAt;
  final bool isShowcased;
  const UserBadgeRow({
    required this.badgeId,
    required this.userId,
    required this.earnedAt,
    required this.isShowcased,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['badge_id'] = Variable<String>(badgeId);
    map['user_id'] = Variable<String>(userId);
    map['earned_at'] = Variable<DateTime>(earnedAt);
    map['is_showcased'] = Variable<bool>(isShowcased);
    return map;
  }

  UserBadgesCompanion toCompanion(bool nullToAbsent) {
    return UserBadgesCompanion(
      badgeId: Value(badgeId),
      userId: Value(userId),
      earnedAt: Value(earnedAt),
      isShowcased: Value(isShowcased),
    );
  }

  factory UserBadgeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserBadgeRow(
      badgeId: serializer.fromJson<String>(json['badgeId']),
      userId: serializer.fromJson<String>(json['userId']),
      earnedAt: serializer.fromJson<DateTime>(json['earnedAt']),
      isShowcased: serializer.fromJson<bool>(json['isShowcased']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'badgeId': serializer.toJson<String>(badgeId),
      'userId': serializer.toJson<String>(userId),
      'earnedAt': serializer.toJson<DateTime>(earnedAt),
      'isShowcased': serializer.toJson<bool>(isShowcased),
    };
  }

  UserBadgeRow copyWith({
    String? badgeId,
    String? userId,
    DateTime? earnedAt,
    bool? isShowcased,
  }) => UserBadgeRow(
    badgeId: badgeId ?? this.badgeId,
    userId: userId ?? this.userId,
    earnedAt: earnedAt ?? this.earnedAt,
    isShowcased: isShowcased ?? this.isShowcased,
  );
  UserBadgeRow copyWithCompanion(UserBadgesCompanion data) {
    return UserBadgeRow(
      badgeId: data.badgeId.present ? data.badgeId.value : this.badgeId,
      userId: data.userId.present ? data.userId.value : this.userId,
      earnedAt: data.earnedAt.present ? data.earnedAt.value : this.earnedAt,
      isShowcased: data.isShowcased.present
          ? data.isShowcased.value
          : this.isShowcased,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserBadgeRow(')
          ..write('badgeId: $badgeId, ')
          ..write('userId: $userId, ')
          ..write('earnedAt: $earnedAt, ')
          ..write('isShowcased: $isShowcased')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(badgeId, userId, earnedAt, isShowcased);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserBadgeRow &&
          other.badgeId == this.badgeId &&
          other.userId == this.userId &&
          other.earnedAt == this.earnedAt &&
          other.isShowcased == this.isShowcased);
}

class UserBadgesCompanion extends UpdateCompanion<UserBadgeRow> {
  final Value<String> badgeId;
  final Value<String> userId;
  final Value<DateTime> earnedAt;
  final Value<bool> isShowcased;
  final Value<int> rowid;
  const UserBadgesCompanion({
    this.badgeId = const Value.absent(),
    this.userId = const Value.absent(),
    this.earnedAt = const Value.absent(),
    this.isShowcased = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserBadgesCompanion.insert({
    required String badgeId,
    required String userId,
    required DateTime earnedAt,
    this.isShowcased = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : badgeId = Value(badgeId),
       userId = Value(userId),
       earnedAt = Value(earnedAt);
  static Insertable<UserBadgeRow> custom({
    Expression<String>? badgeId,
    Expression<String>? userId,
    Expression<DateTime>? earnedAt,
    Expression<bool>? isShowcased,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (badgeId != null) 'badge_id': badgeId,
      if (userId != null) 'user_id': userId,
      if (earnedAt != null) 'earned_at': earnedAt,
      if (isShowcased != null) 'is_showcased': isShowcased,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserBadgesCompanion copyWith({
    Value<String>? badgeId,
    Value<String>? userId,
    Value<DateTime>? earnedAt,
    Value<bool>? isShowcased,
    Value<int>? rowid,
  }) {
    return UserBadgesCompanion(
      badgeId: badgeId ?? this.badgeId,
      userId: userId ?? this.userId,
      earnedAt: earnedAt ?? this.earnedAt,
      isShowcased: isShowcased ?? this.isShowcased,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (badgeId.present) {
      map['badge_id'] = Variable<String>(badgeId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (earnedAt.present) {
      map['earned_at'] = Variable<DateTime>(earnedAt.value);
    }
    if (isShowcased.present) {
      map['is_showcased'] = Variable<bool>(isShowcased.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserBadgesCompanion(')
          ..write('badgeId: $badgeId, ')
          ..write('userId: $userId, ')
          ..write('earnedAt: $earnedAt, ')
          ..write('isShowcased: $isShowcased, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengesTable extends Challenges
    with TableInfo<$ChallengesTable, ChallengeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricMeta = const VerificationMeta('metric');
  @override
  late final GeneratedColumn<String> metric = GeneratedColumn<String>(
    'metric',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<int> target = GeneratedColumn<int>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpRewardMeta = const VerificationMeta(
    'xpReward',
  );
  @override
  late final GeneratedColumn<int> xpReward = GeneratedColumn<int>(
    'xp_reward',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    period,
    title,
    description,
    metric,
    target,
    xpReward,
    icon,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenges';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChallengeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('metric')) {
      context.handle(
        _metricMeta,
        metric.isAcceptableOrUnknown(data['metric']!, _metricMeta),
      );
    } else if (isInserting) {
      context.missing(_metricMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    if (data.containsKey('xp_reward')) {
      context.handle(
        _xpRewardMeta,
        xpReward.isAcceptableOrUnknown(data['xp_reward']!, _xpRewardMeta),
      );
    } else if (isInserting) {
      context.missing(_xpRewardMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChallengeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      metric: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metric'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target'],
      )!,
      xpReward: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_reward'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
    );
  }

  @override
  $ChallengesTable createAlias(String alias) {
    return $ChallengesTable(attachedDatabase, alias);
  }
}

class ChallengeRow extends DataClass implements Insertable<ChallengeRow> {
  final String id;
  final String period;
  final String title;
  final String description;
  final String metric;
  final int target;
  final int xpReward;
  final String? icon;
  const ChallengeRow({
    required this.id,
    required this.period,
    required this.title,
    required this.description,
    required this.metric,
    required this.target,
    required this.xpReward,
    this.icon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['period'] = Variable<String>(period);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['metric'] = Variable<String>(metric);
    map['target'] = Variable<int>(target);
    map['xp_reward'] = Variable<int>(xpReward);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    return map;
  }

  ChallengesCompanion toCompanion(bool nullToAbsent) {
    return ChallengesCompanion(
      id: Value(id),
      period: Value(period),
      title: Value(title),
      description: Value(description),
      metric: Value(metric),
      target: Value(target),
      xpReward: Value(xpReward),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
    );
  }

  factory ChallengeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeRow(
      id: serializer.fromJson<String>(json['id']),
      period: serializer.fromJson<String>(json['period']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      metric: serializer.fromJson<String>(json['metric']),
      target: serializer.fromJson<int>(json['target']),
      xpReward: serializer.fromJson<int>(json['xpReward']),
      icon: serializer.fromJson<String?>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'period': serializer.toJson<String>(period),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'metric': serializer.toJson<String>(metric),
      'target': serializer.toJson<int>(target),
      'xpReward': serializer.toJson<int>(xpReward),
      'icon': serializer.toJson<String?>(icon),
    };
  }

  ChallengeRow copyWith({
    String? id,
    String? period,
    String? title,
    String? description,
    String? metric,
    int? target,
    int? xpReward,
    Value<String?> icon = const Value.absent(),
  }) => ChallengeRow(
    id: id ?? this.id,
    period: period ?? this.period,
    title: title ?? this.title,
    description: description ?? this.description,
    metric: metric ?? this.metric,
    target: target ?? this.target,
    xpReward: xpReward ?? this.xpReward,
    icon: icon.present ? icon.value : this.icon,
  );
  ChallengeRow copyWithCompanion(ChallengesCompanion data) {
    return ChallengeRow(
      id: data.id.present ? data.id.value : this.id,
      period: data.period.present ? data.period.value : this.period,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      metric: data.metric.present ? data.metric.value : this.metric,
      target: data.target.present ? data.target.value : this.target,
      xpReward: data.xpReward.present ? data.xpReward.value : this.xpReward,
      icon: data.icon.present ? data.icon.value : this.icon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeRow(')
          ..write('id: $id, ')
          ..write('period: $period, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('metric: $metric, ')
          ..write('target: $target, ')
          ..write('xpReward: $xpReward, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    period,
    title,
    description,
    metric,
    target,
    xpReward,
    icon,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeRow &&
          other.id == this.id &&
          other.period == this.period &&
          other.title == this.title &&
          other.description == this.description &&
          other.metric == this.metric &&
          other.target == this.target &&
          other.xpReward == this.xpReward &&
          other.icon == this.icon);
}

class ChallengesCompanion extends UpdateCompanion<ChallengeRow> {
  final Value<String> id;
  final Value<String> period;
  final Value<String> title;
  final Value<String> description;
  final Value<String> metric;
  final Value<int> target;
  final Value<int> xpReward;
  final Value<String?> icon;
  final Value<int> rowid;
  const ChallengesCompanion({
    this.id = const Value.absent(),
    this.period = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.metric = const Value.absent(),
    this.target = const Value.absent(),
    this.xpReward = const Value.absent(),
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengesCompanion.insert({
    required String id,
    required String period,
    required String title,
    required String description,
    required String metric,
    required int target,
    required int xpReward,
    this.icon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       period = Value(period),
       title = Value(title),
       description = Value(description),
       metric = Value(metric),
       target = Value(target),
       xpReward = Value(xpReward);
  static Insertable<ChallengeRow> custom({
    Expression<String>? id,
    Expression<String>? period,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? metric,
    Expression<int>? target,
    Expression<int>? xpReward,
    Expression<String>? icon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (period != null) 'period': period,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (metric != null) 'metric': metric,
      if (target != null) 'target': target,
      if (xpReward != null) 'xp_reward': xpReward,
      if (icon != null) 'icon': icon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengesCompanion copyWith({
    Value<String>? id,
    Value<String>? period,
    Value<String>? title,
    Value<String>? description,
    Value<String>? metric,
    Value<int>? target,
    Value<int>? xpReward,
    Value<String?>? icon,
    Value<int>? rowid,
  }) {
    return ChallengesCompanion(
      id: id ?? this.id,
      period: period ?? this.period,
      title: title ?? this.title,
      description: description ?? this.description,
      metric: metric ?? this.metric,
      target: target ?? this.target,
      xpReward: xpReward ?? this.xpReward,
      icon: icon ?? this.icon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (metric.present) {
      map['metric'] = Variable<String>(metric.value);
    }
    if (target.present) {
      map['target'] = Variable<int>(target.value);
    }
    if (xpReward.present) {
      map['xp_reward'] = Variable<int>(xpReward.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengesCompanion(')
          ..write('id: $id, ')
          ..write('period: $period, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('metric: $metric, ')
          ..write('target: $target, ')
          ..write('xpReward: $xpReward, ')
          ..write('icon: $icon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChallengeProgressTable extends ChallengeProgress
    with TableInfo<$ChallengeProgressTable, ChallengeProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChallengeProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _challengeIdMeta = const VerificationMeta(
    'challengeId',
  );
  @override
  late final GeneratedColumn<String> challengeId = GeneratedColumn<String>(
    'challenge_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodKeyMeta = const VerificationMeta(
    'periodKey',
  );
  @override
  late final GeneratedColumn<String> periodKey = GeneratedColumn<String>(
    'period_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentMeta = const VerificationMeta(
    'current',
  );
  @override
  late final GeneratedColumn<int> current = GeneratedColumn<int>(
    'current',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _claimedMeta = const VerificationMeta(
    'claimed',
  );
  @override
  late final GeneratedColumn<bool> claimed = GeneratedColumn<bool>(
    'claimed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("claimed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    challengeId,
    userId,
    periodKey,
    current,
    claimed,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'challenge_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChallengeProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('challenge_id')) {
      context.handle(
        _challengeIdMeta,
        challengeId.isAcceptableOrUnknown(
          data['challenge_id']!,
          _challengeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_challengeIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('period_key')) {
      context.handle(
        _periodKeyMeta,
        periodKey.isAcceptableOrUnknown(data['period_key']!, _periodKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_periodKeyMeta);
    }
    if (data.containsKey('current')) {
      context.handle(
        _currentMeta,
        current.isAcceptableOrUnknown(data['current']!, _currentMeta),
      );
    }
    if (data.containsKey('claimed')) {
      context.handle(
        _claimedMeta,
        claimed.isAcceptableOrUnknown(data['claimed']!, _claimedMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {challengeId, userId, periodKey};
  @override
  ChallengeProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChallengeProgressRow(
      challengeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      periodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period_key'],
      )!,
      current: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current'],
      )!,
      claimed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}claimed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ChallengeProgressTable createAlias(String alias) {
    return $ChallengeProgressTable(attachedDatabase, alias);
  }
}

class ChallengeProgressRow extends DataClass
    implements Insertable<ChallengeProgressRow> {
  final String challengeId;
  final String userId;
  final String periodKey;
  final int current;
  final bool claimed;
  final DateTime? completedAt;
  const ChallengeProgressRow({
    required this.challengeId,
    required this.userId,
    required this.periodKey,
    required this.current,
    required this.claimed,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['challenge_id'] = Variable<String>(challengeId);
    map['user_id'] = Variable<String>(userId);
    map['period_key'] = Variable<String>(periodKey);
    map['current'] = Variable<int>(current);
    map['claimed'] = Variable<bool>(claimed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ChallengeProgressCompanion toCompanion(bool nullToAbsent) {
    return ChallengeProgressCompanion(
      challengeId: Value(challengeId),
      userId: Value(userId),
      periodKey: Value(periodKey),
      current: Value(current),
      claimed: Value(claimed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ChallengeProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChallengeProgressRow(
      challengeId: serializer.fromJson<String>(json['challengeId']),
      userId: serializer.fromJson<String>(json['userId']),
      periodKey: serializer.fromJson<String>(json['periodKey']),
      current: serializer.fromJson<int>(json['current']),
      claimed: serializer.fromJson<bool>(json['claimed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'challengeId': serializer.toJson<String>(challengeId),
      'userId': serializer.toJson<String>(userId),
      'periodKey': serializer.toJson<String>(periodKey),
      'current': serializer.toJson<int>(current),
      'claimed': serializer.toJson<bool>(claimed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ChallengeProgressRow copyWith({
    String? challengeId,
    String? userId,
    String? periodKey,
    int? current,
    bool? claimed,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ChallengeProgressRow(
    challengeId: challengeId ?? this.challengeId,
    userId: userId ?? this.userId,
    periodKey: periodKey ?? this.periodKey,
    current: current ?? this.current,
    claimed: claimed ?? this.claimed,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ChallengeProgressRow copyWithCompanion(ChallengeProgressCompanion data) {
    return ChallengeProgressRow(
      challengeId: data.challengeId.present
          ? data.challengeId.value
          : this.challengeId,
      userId: data.userId.present ? data.userId.value : this.userId,
      periodKey: data.periodKey.present ? data.periodKey.value : this.periodKey,
      current: data.current.present ? data.current.value : this.current,
      claimed: data.claimed.present ? data.claimed.value : this.claimed,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeProgressRow(')
          ..write('challengeId: $challengeId, ')
          ..write('userId: $userId, ')
          ..write('periodKey: $periodKey, ')
          ..write('current: $current, ')
          ..write('claimed: $claimed, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    challengeId,
    userId,
    periodKey,
    current,
    claimed,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChallengeProgressRow &&
          other.challengeId == this.challengeId &&
          other.userId == this.userId &&
          other.periodKey == this.periodKey &&
          other.current == this.current &&
          other.claimed == this.claimed &&
          other.completedAt == this.completedAt);
}

class ChallengeProgressCompanion extends UpdateCompanion<ChallengeProgressRow> {
  final Value<String> challengeId;
  final Value<String> userId;
  final Value<String> periodKey;
  final Value<int> current;
  final Value<bool> claimed;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const ChallengeProgressCompanion({
    this.challengeId = const Value.absent(),
    this.userId = const Value.absent(),
    this.periodKey = const Value.absent(),
    this.current = const Value.absent(),
    this.claimed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChallengeProgressCompanion.insert({
    required String challengeId,
    required String userId,
    required String periodKey,
    this.current = const Value.absent(),
    this.claimed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : challengeId = Value(challengeId),
       userId = Value(userId),
       periodKey = Value(periodKey);
  static Insertable<ChallengeProgressRow> custom({
    Expression<String>? challengeId,
    Expression<String>? userId,
    Expression<String>? periodKey,
    Expression<int>? current,
    Expression<bool>? claimed,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (challengeId != null) 'challenge_id': challengeId,
      if (userId != null) 'user_id': userId,
      if (periodKey != null) 'period_key': periodKey,
      if (current != null) 'current': current,
      if (claimed != null) 'claimed': claimed,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChallengeProgressCompanion copyWith({
    Value<String>? challengeId,
    Value<String>? userId,
    Value<String>? periodKey,
    Value<int>? current,
    Value<bool>? claimed,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return ChallengeProgressCompanion(
      challengeId: challengeId ?? this.challengeId,
      userId: userId ?? this.userId,
      periodKey: periodKey ?? this.periodKey,
      current: current ?? this.current,
      claimed: claimed ?? this.claimed,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (challengeId.present) {
      map['challenge_id'] = Variable<String>(challengeId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (periodKey.present) {
      map['period_key'] = Variable<String>(periodKey.value);
    }
    if (current.present) {
      map['current'] = Variable<int>(current.value);
    }
    if (claimed.present) {
      map['claimed'] = Variable<bool>(claimed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChallengeProgressCompanion(')
          ..write('challengeId: $challengeId, ')
          ..write('userId: $userId, ')
          ..write('periodKey: $periodKey, ')
          ..write('current: $current, ')
          ..write('claimed: $claimed, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpotifyAccountsTable extends SpotifyAccounts
    with TableInfo<$SpotifyAccountsTable, SpotifyAccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpotifyAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spotifyUserIdMeta = const VerificationMeta(
    'spotifyUserId',
  );
  @override
  late final GeneratedColumn<String> spotifyUserId = GeneratedColumn<String>(
    'spotify_user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _connectedAtMeta = const VerificationMeta(
    'connectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> connectedAt = GeneratedColumn<DateTime>(
    'connected_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    spotifyUserId,
    displayName,
    imageUrl,
    email,
    connectedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spotify_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpotifyAccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('spotify_user_id')) {
      context.handle(
        _spotifyUserIdMeta,
        spotifyUserId.isAcceptableOrUnknown(
          data['spotify_user_id']!,
          _spotifyUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_spotifyUserIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('connected_at')) {
      context.handle(
        _connectedAtMeta,
        connectedAt.isAcceptableOrUnknown(
          data['connected_at']!,
          _connectedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_connectedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  SpotifyAccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpotifyAccountRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      spotifyUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spotify_user_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      connectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}connected_at'],
      )!,
    );
  }

  @override
  $SpotifyAccountsTable createAlias(String alias) {
    return $SpotifyAccountsTable(attachedDatabase, alias);
  }
}

class SpotifyAccountRow extends DataClass
    implements Insertable<SpotifyAccountRow> {
  final String userId;
  final String spotifyUserId;
  final String displayName;
  final String? imageUrl;
  final String? email;
  final DateTime connectedAt;
  const SpotifyAccountRow({
    required this.userId,
    required this.spotifyUserId,
    required this.displayName,
    this.imageUrl,
    this.email,
    required this.connectedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['spotify_user_id'] = Variable<String>(spotifyUserId);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['connected_at'] = Variable<DateTime>(connectedAt);
    return map;
  }

  SpotifyAccountsCompanion toCompanion(bool nullToAbsent) {
    return SpotifyAccountsCompanion(
      userId: Value(userId),
      spotifyUserId: Value(spotifyUserId),
      displayName: Value(displayName),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      connectedAt: Value(connectedAt),
    );
  }

  factory SpotifyAccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpotifyAccountRow(
      userId: serializer.fromJson<String>(json['userId']),
      spotifyUserId: serializer.fromJson<String>(json['spotifyUserId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      email: serializer.fromJson<String?>(json['email']),
      connectedAt: serializer.fromJson<DateTime>(json['connectedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'spotifyUserId': serializer.toJson<String>(spotifyUserId),
      'displayName': serializer.toJson<String>(displayName),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'email': serializer.toJson<String?>(email),
      'connectedAt': serializer.toJson<DateTime>(connectedAt),
    };
  }

  SpotifyAccountRow copyWith({
    String? userId,
    String? spotifyUserId,
    String? displayName,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> email = const Value.absent(),
    DateTime? connectedAt,
  }) => SpotifyAccountRow(
    userId: userId ?? this.userId,
    spotifyUserId: spotifyUserId ?? this.spotifyUserId,
    displayName: displayName ?? this.displayName,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    email: email.present ? email.value : this.email,
    connectedAt: connectedAt ?? this.connectedAt,
  );
  SpotifyAccountRow copyWithCompanion(SpotifyAccountsCompanion data) {
    return SpotifyAccountRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      spotifyUserId: data.spotifyUserId.present
          ? data.spotifyUserId.value
          : this.spotifyUserId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      email: data.email.present ? data.email.value : this.email,
      connectedAt: data.connectedAt.present
          ? data.connectedAt.value
          : this.connectedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpotifyAccountRow(')
          ..write('userId: $userId, ')
          ..write('spotifyUserId: $spotifyUserId, ')
          ..write('displayName: $displayName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('email: $email, ')
          ..write('connectedAt: $connectedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    spotifyUserId,
    displayName,
    imageUrl,
    email,
    connectedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpotifyAccountRow &&
          other.userId == this.userId &&
          other.spotifyUserId == this.spotifyUserId &&
          other.displayName == this.displayName &&
          other.imageUrl == this.imageUrl &&
          other.email == this.email &&
          other.connectedAt == this.connectedAt);
}

class SpotifyAccountsCompanion extends UpdateCompanion<SpotifyAccountRow> {
  final Value<String> userId;
  final Value<String> spotifyUserId;
  final Value<String> displayName;
  final Value<String?> imageUrl;
  final Value<String?> email;
  final Value<DateTime> connectedAt;
  final Value<int> rowid;
  const SpotifyAccountsCompanion({
    this.userId = const Value.absent(),
    this.spotifyUserId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.email = const Value.absent(),
    this.connectedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpotifyAccountsCompanion.insert({
    required String userId,
    required String spotifyUserId,
    required String displayName,
    this.imageUrl = const Value.absent(),
    this.email = const Value.absent(),
    required DateTime connectedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       spotifyUserId = Value(spotifyUserId),
       displayName = Value(displayName),
       connectedAt = Value(connectedAt);
  static Insertable<SpotifyAccountRow> custom({
    Expression<String>? userId,
    Expression<String>? spotifyUserId,
    Expression<String>? displayName,
    Expression<String>? imageUrl,
    Expression<String>? email,
    Expression<DateTime>? connectedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (spotifyUserId != null) 'spotify_user_id': spotifyUserId,
      if (displayName != null) 'display_name': displayName,
      if (imageUrl != null) 'image_url': imageUrl,
      if (email != null) 'email': email,
      if (connectedAt != null) 'connected_at': connectedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpotifyAccountsCompanion copyWith({
    Value<String>? userId,
    Value<String>? spotifyUserId,
    Value<String>? displayName,
    Value<String?>? imageUrl,
    Value<String?>? email,
    Value<DateTime>? connectedAt,
    Value<int>? rowid,
  }) {
    return SpotifyAccountsCompanion(
      userId: userId ?? this.userId,
      spotifyUserId: spotifyUserId ?? this.spotifyUserId,
      displayName: displayName ?? this.displayName,
      imageUrl: imageUrl ?? this.imageUrl,
      email: email ?? this.email,
      connectedAt: connectedAt ?? this.connectedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (spotifyUserId.present) {
      map['spotify_user_id'] = Variable<String>(spotifyUserId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (connectedAt.present) {
      map['connected_at'] = Variable<DateTime>(connectedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpotifyAccountsCompanion(')
          ..write('userId: $userId, ')
          ..write('spotifyUserId: $spotifyUserId, ')
          ..write('displayName: $displayName, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('email: $email, ')
          ..write('connectedAt: $connectedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrainingDaysTable extends TrainingDays
    with TableInfo<$TrainingDaysTable, TrainingDayRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrainingDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutCountMeta = const VerificationMeta(
    'workoutCount',
  );
  @override
  late final GeneratedColumn<int> workoutCount = GeneratedColumn<int>(
    'workout_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _setsCompletedMeta = const VerificationMeta(
    'setsCompleted',
  );
  @override
  late final GeneratedColumn<int> setsCompleted = GeneratedColumn<int>(
    'sets_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _volumeKgMeta = const VerificationMeta(
    'volumeKg',
  );
  @override
  late final GeneratedColumn<double> volumeKg = GeneratedColumn<double>(
    'volume_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _trainingSecondsMeta = const VerificationMeta(
    'trainingSeconds',
  );
  @override
  late final GeneratedColumn<int> trainingSeconds = GeneratedColumn<int>(
    'training_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isScheduledRestMeta = const VerificationMeta(
    'isScheduledRest',
  );
  @override
  late final GeneratedColumn<bool> isScheduledRest = GeneratedColumn<bool>(
    'is_scheduled_rest',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_scheduled_rest" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _routineIdsCsvMeta = const VerificationMeta(
    'routineIdsCsv',
  );
  @override
  late final GeneratedColumn<String> routineIdsCsv = GeneratedColumn<String>(
    'routine_ids_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _muscleGroupsCsvMeta = const VerificationMeta(
    'muscleGroupsCsv',
  );
  @override
  late final GeneratedColumn<String> muscleGroupsCsv = GeneratedColumn<String>(
    'muscle_groups_csv',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    date,
    workoutCount,
    setsCompleted,
    volumeKg,
    trainingSeconds,
    isScheduledRest,
    routineIdsCsv,
    muscleGroupsCsv,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'training_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrainingDayRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('workout_count')) {
      context.handle(
        _workoutCountMeta,
        workoutCount.isAcceptableOrUnknown(
          data['workout_count']!,
          _workoutCountMeta,
        ),
      );
    }
    if (data.containsKey('sets_completed')) {
      context.handle(
        _setsCompletedMeta,
        setsCompleted.isAcceptableOrUnknown(
          data['sets_completed']!,
          _setsCompletedMeta,
        ),
      );
    }
    if (data.containsKey('volume_kg')) {
      context.handle(
        _volumeKgMeta,
        volumeKg.isAcceptableOrUnknown(data['volume_kg']!, _volumeKgMeta),
      );
    }
    if (data.containsKey('training_seconds')) {
      context.handle(
        _trainingSecondsMeta,
        trainingSeconds.isAcceptableOrUnknown(
          data['training_seconds']!,
          _trainingSecondsMeta,
        ),
      );
    }
    if (data.containsKey('is_scheduled_rest')) {
      context.handle(
        _isScheduledRestMeta,
        isScheduledRest.isAcceptableOrUnknown(
          data['is_scheduled_rest']!,
          _isScheduledRestMeta,
        ),
      );
    }
    if (data.containsKey('routine_ids_csv')) {
      context.handle(
        _routineIdsCsvMeta,
        routineIdsCsv.isAcceptableOrUnknown(
          data['routine_ids_csv']!,
          _routineIdsCsvMeta,
        ),
      );
    }
    if (data.containsKey('muscle_groups_csv')) {
      context.handle(
        _muscleGroupsCsvMeta,
        muscleGroupsCsv.isAcceptableOrUnknown(
          data['muscle_groups_csv']!,
          _muscleGroupsCsvMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, date};
  @override
  TrainingDayRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrainingDayRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      workoutCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_count'],
      )!,
      setsCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets_completed'],
      )!,
      volumeKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_kg'],
      )!,
      trainingSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}training_seconds'],
      )!,
      isScheduledRest: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_scheduled_rest'],
      )!,
      routineIdsCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_ids_csv'],
      )!,
      muscleGroupsCsv: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_groups_csv'],
      )!,
    );
  }

  @override
  $TrainingDaysTable createAlias(String alias) {
    return $TrainingDaysTable(attachedDatabase, alias);
  }
}

class TrainingDayRow extends DataClass implements Insertable<TrainingDayRow> {
  final String userId;
  final DateTime date;
  final int workoutCount;
  final int setsCompleted;
  final double volumeKg;
  final int trainingSeconds;
  final bool isScheduledRest;
  final String routineIdsCsv;
  final String muscleGroupsCsv;
  const TrainingDayRow({
    required this.userId,
    required this.date,
    required this.workoutCount,
    required this.setsCompleted,
    required this.volumeKg,
    required this.trainingSeconds,
    required this.isScheduledRest,
    required this.routineIdsCsv,
    required this.muscleGroupsCsv,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['workout_count'] = Variable<int>(workoutCount);
    map['sets_completed'] = Variable<int>(setsCompleted);
    map['volume_kg'] = Variable<double>(volumeKg);
    map['training_seconds'] = Variable<int>(trainingSeconds);
    map['is_scheduled_rest'] = Variable<bool>(isScheduledRest);
    map['routine_ids_csv'] = Variable<String>(routineIdsCsv);
    map['muscle_groups_csv'] = Variable<String>(muscleGroupsCsv);
    return map;
  }

  TrainingDaysCompanion toCompanion(bool nullToAbsent) {
    return TrainingDaysCompanion(
      userId: Value(userId),
      date: Value(date),
      workoutCount: Value(workoutCount),
      setsCompleted: Value(setsCompleted),
      volumeKg: Value(volumeKg),
      trainingSeconds: Value(trainingSeconds),
      isScheduledRest: Value(isScheduledRest),
      routineIdsCsv: Value(routineIdsCsv),
      muscleGroupsCsv: Value(muscleGroupsCsv),
    );
  }

  factory TrainingDayRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrainingDayRow(
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      workoutCount: serializer.fromJson<int>(json['workoutCount']),
      setsCompleted: serializer.fromJson<int>(json['setsCompleted']),
      volumeKg: serializer.fromJson<double>(json['volumeKg']),
      trainingSeconds: serializer.fromJson<int>(json['trainingSeconds']),
      isScheduledRest: serializer.fromJson<bool>(json['isScheduledRest']),
      routineIdsCsv: serializer.fromJson<String>(json['routineIdsCsv']),
      muscleGroupsCsv: serializer.fromJson<String>(json['muscleGroupsCsv']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'workoutCount': serializer.toJson<int>(workoutCount),
      'setsCompleted': serializer.toJson<int>(setsCompleted),
      'volumeKg': serializer.toJson<double>(volumeKg),
      'trainingSeconds': serializer.toJson<int>(trainingSeconds),
      'isScheduledRest': serializer.toJson<bool>(isScheduledRest),
      'routineIdsCsv': serializer.toJson<String>(routineIdsCsv),
      'muscleGroupsCsv': serializer.toJson<String>(muscleGroupsCsv),
    };
  }

  TrainingDayRow copyWith({
    String? userId,
    DateTime? date,
    int? workoutCount,
    int? setsCompleted,
    double? volumeKg,
    int? trainingSeconds,
    bool? isScheduledRest,
    String? routineIdsCsv,
    String? muscleGroupsCsv,
  }) => TrainingDayRow(
    userId: userId ?? this.userId,
    date: date ?? this.date,
    workoutCount: workoutCount ?? this.workoutCount,
    setsCompleted: setsCompleted ?? this.setsCompleted,
    volumeKg: volumeKg ?? this.volumeKg,
    trainingSeconds: trainingSeconds ?? this.trainingSeconds,
    isScheduledRest: isScheduledRest ?? this.isScheduledRest,
    routineIdsCsv: routineIdsCsv ?? this.routineIdsCsv,
    muscleGroupsCsv: muscleGroupsCsv ?? this.muscleGroupsCsv,
  );
  TrainingDayRow copyWithCompanion(TrainingDaysCompanion data) {
    return TrainingDayRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      workoutCount: data.workoutCount.present
          ? data.workoutCount.value
          : this.workoutCount,
      setsCompleted: data.setsCompleted.present
          ? data.setsCompleted.value
          : this.setsCompleted,
      volumeKg: data.volumeKg.present ? data.volumeKg.value : this.volumeKg,
      trainingSeconds: data.trainingSeconds.present
          ? data.trainingSeconds.value
          : this.trainingSeconds,
      isScheduledRest: data.isScheduledRest.present
          ? data.isScheduledRest.value
          : this.isScheduledRest,
      routineIdsCsv: data.routineIdsCsv.present
          ? data.routineIdsCsv.value
          : this.routineIdsCsv,
      muscleGroupsCsv: data.muscleGroupsCsv.present
          ? data.muscleGroupsCsv.value
          : this.muscleGroupsCsv,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrainingDayRow(')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('workoutCount: $workoutCount, ')
          ..write('setsCompleted: $setsCompleted, ')
          ..write('volumeKg: $volumeKg, ')
          ..write('trainingSeconds: $trainingSeconds, ')
          ..write('isScheduledRest: $isScheduledRest, ')
          ..write('routineIdsCsv: $routineIdsCsv, ')
          ..write('muscleGroupsCsv: $muscleGroupsCsv')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    date,
    workoutCount,
    setsCompleted,
    volumeKg,
    trainingSeconds,
    isScheduledRest,
    routineIdsCsv,
    muscleGroupsCsv,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrainingDayRow &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.workoutCount == this.workoutCount &&
          other.setsCompleted == this.setsCompleted &&
          other.volumeKg == this.volumeKg &&
          other.trainingSeconds == this.trainingSeconds &&
          other.isScheduledRest == this.isScheduledRest &&
          other.routineIdsCsv == this.routineIdsCsv &&
          other.muscleGroupsCsv == this.muscleGroupsCsv);
}

class TrainingDaysCompanion extends UpdateCompanion<TrainingDayRow> {
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<int> workoutCount;
  final Value<int> setsCompleted;
  final Value<double> volumeKg;
  final Value<int> trainingSeconds;
  final Value<bool> isScheduledRest;
  final Value<String> routineIdsCsv;
  final Value<String> muscleGroupsCsv;
  final Value<int> rowid;
  const TrainingDaysCompanion({
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.workoutCount = const Value.absent(),
    this.setsCompleted = const Value.absent(),
    this.volumeKg = const Value.absent(),
    this.trainingSeconds = const Value.absent(),
    this.isScheduledRest = const Value.absent(),
    this.routineIdsCsv = const Value.absent(),
    this.muscleGroupsCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrainingDaysCompanion.insert({
    required String userId,
    required DateTime date,
    this.workoutCount = const Value.absent(),
    this.setsCompleted = const Value.absent(),
    this.volumeKg = const Value.absent(),
    this.trainingSeconds = const Value.absent(),
    this.isScheduledRest = const Value.absent(),
    this.routineIdsCsv = const Value.absent(),
    this.muscleGroupsCsv = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       date = Value(date);
  static Insertable<TrainingDayRow> custom({
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<int>? workoutCount,
    Expression<int>? setsCompleted,
    Expression<double>? volumeKg,
    Expression<int>? trainingSeconds,
    Expression<bool>? isScheduledRest,
    Expression<String>? routineIdsCsv,
    Expression<String>? muscleGroupsCsv,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (workoutCount != null) 'workout_count': workoutCount,
      if (setsCompleted != null) 'sets_completed': setsCompleted,
      if (volumeKg != null) 'volume_kg': volumeKg,
      if (trainingSeconds != null) 'training_seconds': trainingSeconds,
      if (isScheduledRest != null) 'is_scheduled_rest': isScheduledRest,
      if (routineIdsCsv != null) 'routine_ids_csv': routineIdsCsv,
      if (muscleGroupsCsv != null) 'muscle_groups_csv': muscleGroupsCsv,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrainingDaysCompanion copyWith({
    Value<String>? userId,
    Value<DateTime>? date,
    Value<int>? workoutCount,
    Value<int>? setsCompleted,
    Value<double>? volumeKg,
    Value<int>? trainingSeconds,
    Value<bool>? isScheduledRest,
    Value<String>? routineIdsCsv,
    Value<String>? muscleGroupsCsv,
    Value<int>? rowid,
  }) {
    return TrainingDaysCompanion(
      userId: userId ?? this.userId,
      date: date ?? this.date,
      workoutCount: workoutCount ?? this.workoutCount,
      setsCompleted: setsCompleted ?? this.setsCompleted,
      volumeKg: volumeKg ?? this.volumeKg,
      trainingSeconds: trainingSeconds ?? this.trainingSeconds,
      isScheduledRest: isScheduledRest ?? this.isScheduledRest,
      routineIdsCsv: routineIdsCsv ?? this.routineIdsCsv,
      muscleGroupsCsv: muscleGroupsCsv ?? this.muscleGroupsCsv,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (workoutCount.present) {
      map['workout_count'] = Variable<int>(workoutCount.value);
    }
    if (setsCompleted.present) {
      map['sets_completed'] = Variable<int>(setsCompleted.value);
    }
    if (volumeKg.present) {
      map['volume_kg'] = Variable<double>(volumeKg.value);
    }
    if (trainingSeconds.present) {
      map['training_seconds'] = Variable<int>(trainingSeconds.value);
    }
    if (isScheduledRest.present) {
      map['is_scheduled_rest'] = Variable<bool>(isScheduledRest.value);
    }
    if (routineIdsCsv.present) {
      map['routine_ids_csv'] = Variable<String>(routineIdsCsv.value);
    }
    if (muscleGroupsCsv.present) {
      map['muscle_groups_csv'] = Variable<String>(muscleGroupsCsv.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrainingDaysCompanion(')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('workoutCount: $workoutCount, ')
          ..write('setsCompleted: $setsCompleted, ')
          ..write('volumeKg: $volumeKg, ')
          ..write('trainingSeconds: $trainingSeconds, ')
          ..write('isScheduledRest: $isScheduledRest, ')
          ..write('routineIdsCsv: $routineIdsCsv, ')
          ..write('muscleGroupsCsv: $muscleGroupsCsv, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $XpTransactionsTable xpTransactions = $XpTransactionsTable(this);
  late final $WorkoutRoutinesTable workoutRoutines = $WorkoutRoutinesTable(
    this,
  );
  late final $RoutineExercisesTable routineExercises = $RoutineExercisesTable(
    this,
  );
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WorkoutSessionsTable workoutSessions = $WorkoutSessionsTable(
    this,
  );
  late final $SessionExercisesTable sessionExercises = $SessionExercisesTable(
    this,
  );
  late final $SessionSetsTable sessionSets = $SessionSetsTable(this);
  late final $ScheduleEntriesTable scheduleEntries = $ScheduleEntriesTable(
    this,
  );
  late final $PersonalRecordsTable personalRecords = $PersonalRecordsTable(
    this,
  );
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $UserAchievementsTable userAchievements = $UserAchievementsTable(
    this,
  );
  late final $BadgesTable badges = $BadgesTable(this);
  late final $UserBadgesTable userBadges = $UserBadgesTable(this);
  late final $ChallengesTable challenges = $ChallengesTable(this);
  late final $ChallengeProgressTable challengeProgress =
      $ChallengeProgressTable(this);
  late final $SpotifyAccountsTable spotifyAccounts = $SpotifyAccountsTable(
    this,
  );
  late final $TrainingDaysTable trainingDays = $TrainingDaysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    xpTransactions,
    workoutRoutines,
    routineExercises,
    exercises,
    workoutSessions,
    sessionExercises,
    sessionSets,
    scheduleEntries,
    personalRecords,
    achievements,
    userAchievements,
    badges,
    userBadges,
    challenges,
    challengeProgress,
    spotifyAccounts,
    trainingDays,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String name,
  Value<String?> email,
  Value<String?> photoUrl,
  required DateTime createdAt,
  Value<String?> passwordHash,
  Value<String?> passwordSalt,
  Value<int> lifetimeXp,
  Value<int> level,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<DateTime?> lastWorkoutAt,
  Value<int> totalWorkouts,
  Value<double> totalVolumeKg,
  Value<int> totalTrainingSeconds,
  Value<int> spotifyWorkouts,
  Value<int> spotifyTracksPlayed,
  Value<int> playlistWorkouts,
  Value<int> challengesCompleted,
  Value<int> personalRecordsCount,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> email,
  Value<String?> photoUrl,
  Value<DateTime> createdAt,
  Value<String?> passwordHash,
  Value<String?> passwordSalt,
  Value<int> lifetimeXp,
  Value<int> level,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<DateTime?> lastWorkoutAt,
  Value<int> totalWorkouts,
  Value<double> totalVolumeKg,
  Value<int> totalTrainingSeconds,
  Value<int> spotifyWorkouts,
  Value<int> spotifyTracksPlayed,
  Value<int> playlistWorkouts,
  Value<int> challengesCompleted,
  Value<int> personalRecordsCount,
  Value<int> rowid,
});

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastWorkoutAt => $composableBuilder(
    column: $table.lastWorkoutAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalWorkouts => $composableBuilder(
    column: $table.totalWorkouts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalVolumeKg => $composableBuilder(
    column: $table.totalVolumeKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTrainingSeconds => $composableBuilder(
    column: $table.totalTrainingSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spotifyWorkouts => $composableBuilder(
    column: $table.spotifyWorkouts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spotifyTracksPlayed => $composableBuilder(
    column: $table.spotifyTracksPlayed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get playlistWorkouts => $composableBuilder(
    column: $table.playlistWorkouts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get challengesCompleted => $composableBuilder(
    column: $table.challengesCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get personalRecordsCount => $composableBuilder(
    column: $table.personalRecordsCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastWorkoutAt => $composableBuilder(
    column: $table.lastWorkoutAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalWorkouts => $composableBuilder(
    column: $table.totalWorkouts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalVolumeKg => $composableBuilder(
    column: $table.totalVolumeKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTrainingSeconds => $composableBuilder(
    column: $table.totalTrainingSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spotifyWorkouts => $composableBuilder(
    column: $table.spotifyWorkouts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spotifyTracksPlayed => $composableBuilder(
    column: $table.spotifyTracksPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get playlistWorkouts => $composableBuilder(
    column: $table.playlistWorkouts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get challengesCompleted => $composableBuilder(
    column: $table.challengesCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get personalRecordsCount => $composableBuilder(
    column: $table.personalRecordsCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lifetimeXp => $composableBuilder(
    column: $table.lifetimeXp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastWorkoutAt => $composableBuilder(
    column: $table.lastWorkoutAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalWorkouts => $composableBuilder(
    column: $table.totalWorkouts,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalVolumeKg => $composableBuilder(
    column: $table.totalVolumeKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTrainingSeconds => $composableBuilder(
    column: $table.totalTrainingSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get spotifyWorkouts => $composableBuilder(
    column: $table.spotifyWorkouts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get spotifyTracksPlayed => $composableBuilder(
    column: $table.spotifyTracksPlayed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get playlistWorkouts => $composableBuilder(
    column: $table.playlistWorkouts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get challengesCompleted => $composableBuilder(
    column: $table.challengesCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get personalRecordsCount => $composableBuilder(
    column: $table.personalRecordsCount,
    builder: (column) => column,
  );
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UserRow,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
          UserRow,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                Value<int> lifetimeXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime?> lastWorkoutAt = const Value.absent(),
                Value<int> totalWorkouts = const Value.absent(),
                Value<double> totalVolumeKg = const Value.absent(),
                Value<int> totalTrainingSeconds = const Value.absent(),
                Value<int> spotifyWorkouts = const Value.absent(),
                Value<int> spotifyTracksPlayed = const Value.absent(),
                Value<int> playlistWorkouts = const Value.absent(),
                Value<int> challengesCompleted = const Value.absent(),
                Value<int> personalRecordsCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                email: email,
                photoUrl: photoUrl,
                createdAt: createdAt,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                lifetimeXp: lifetimeXp,
                level: level,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastWorkoutAt: lastWorkoutAt,
                totalWorkouts: totalWorkouts,
                totalVolumeKg: totalVolumeKg,
                totalTrainingSeconds: totalTrainingSeconds,
                spotifyWorkouts: spotifyWorkouts,
                spotifyTracksPlayed: spotifyTracksPlayed,
                playlistWorkouts: playlistWorkouts,
                challengesCompleted: challengesCompleted,
                personalRecordsCount: personalRecordsCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                required DateTime createdAt,
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> passwordSalt = const Value.absent(),
                Value<int> lifetimeXp = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<DateTime?> lastWorkoutAt = const Value.absent(),
                Value<int> totalWorkouts = const Value.absent(),
                Value<double> totalVolumeKg = const Value.absent(),
                Value<int> totalTrainingSeconds = const Value.absent(),
                Value<int> spotifyWorkouts = const Value.absent(),
                Value<int> spotifyTracksPlayed = const Value.absent(),
                Value<int> playlistWorkouts = const Value.absent(),
                Value<int> challengesCompleted = const Value.absent(),
                Value<int> personalRecordsCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                email: email,
                photoUrl: photoUrl,
                createdAt: createdAt,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                lifetimeXp: lifetimeXp,
                level: level,
                currentStreak: currentStreak,
                longestStreak: longestStreak,
                lastWorkoutAt: lastWorkoutAt,
                totalWorkouts: totalWorkouts,
                totalVolumeKg: totalVolumeKg,
                totalTrainingSeconds: totalTrainingSeconds,
                spotifyWorkouts: spotifyWorkouts,
                spotifyTracksPlayed: spotifyTracksPlayed,
                playlistWorkouts: playlistWorkouts,
                challengesCompleted: challengesCompleted,
                personalRecordsCount: personalRecordsCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, UserRow>(table),
                  BaseReferences<_$AppDatabase, $UsersTable, UserRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UserRow,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UserRow, BaseReferences<_$AppDatabase, $UsersTable, UserRow>),
      UserRow,
      PrefetchHooks Function()
    >;
typedef $$XpTransactionsTableCreateCompanionBuilder =
    XpTransactionsCompanion Function({
      required String id,
      required String userId,
      required int amount,
      required String source,
      required String description,
      Value<String?> workoutId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$XpTransactionsTableUpdateCompanionBuilder =
    XpTransactionsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<int> amount,
      Value<String> source,
      Value<String> description,
      Value<String?> workoutId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$XpTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $XpTransactionsTable> {
  $$XpTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$XpTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $XpTransactionsTable> {
  $$XpTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$XpTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $XpTransactionsTable> {
  $$XpTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$XpTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $XpTransactionsTable,
          XpTransactionRow,
          $$XpTransactionsTableFilterComposer,
          $$XpTransactionsTableOrderingComposer,
          $$XpTransactionsTableAnnotationComposer,
          $$XpTransactionsTableCreateCompanionBuilder,
          $$XpTransactionsTableUpdateCompanionBuilder,
          (
            XpTransactionRow,
            BaseReferences<
              _$AppDatabase,
              $XpTransactionsTable,
              XpTransactionRow
            >,
          ),
          XpTransactionRow,
          PrefetchHooks Function()
        > {
  $$XpTransactionsTableTableManager(
    _$AppDatabase db,
    $XpTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> workoutId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => XpTransactionsCompanion(
                id: id,
                userId: userId,
                amount: amount,
                source: source,
                description: description,
                workoutId: workoutId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required int amount,
                required String source,
                required String description,
                Value<String?> workoutId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => XpTransactionsCompanion.insert(
                id: id,
                userId: userId,
                amount: amount,
                source: source,
                description: description,
                workoutId: workoutId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$XpTransactionsTable, XpTransactionRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $XpTransactionsTable,
                    XpTransactionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$XpTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $XpTransactionsTable,
      XpTransactionRow,
      $$XpTransactionsTableFilterComposer,
      $$XpTransactionsTableOrderingComposer,
      $$XpTransactionsTableAnnotationComposer,
      $$XpTransactionsTableCreateCompanionBuilder,
      $$XpTransactionsTableUpdateCompanionBuilder,
      (
        XpTransactionRow,
        BaseReferences<_$AppDatabase, $XpTransactionsTable, XpTransactionRow>,
      ),
      XpTransactionRow,
      PrefetchHooks Function()
    >;
typedef $$WorkoutRoutinesTableCreateCompanionBuilder =
    WorkoutRoutinesCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required String category,
      Value<int> restDurationSeconds,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$WorkoutRoutinesTableUpdateCompanionBuilder =
    WorkoutRoutinesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<String> category,
      Value<int> restDurationSeconds,
      Value<DateTime?> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$WorkoutRoutinesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutRoutinesTable> {
  $$WorkoutRoutinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restDurationSeconds => $composableBuilder(
    column: $table.restDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutRoutinesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutRoutinesTable> {
  $$WorkoutRoutinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restDurationSeconds => $composableBuilder(
    column: $table.restDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutRoutinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutRoutinesTable> {
  $$WorkoutRoutinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get restDurationSeconds => $composableBuilder(
    column: $table.restDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$WorkoutRoutinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutRoutinesTable,
          WorkoutRoutineRow,
          $$WorkoutRoutinesTableFilterComposer,
          $$WorkoutRoutinesTableOrderingComposer,
          $$WorkoutRoutinesTableAnnotationComposer,
          $$WorkoutRoutinesTableCreateCompanionBuilder,
          $$WorkoutRoutinesTableUpdateCompanionBuilder,
          (
            WorkoutRoutineRow,
            BaseReferences<
              _$AppDatabase,
              $WorkoutRoutinesTable,
              WorkoutRoutineRow
            >,
          ),
          WorkoutRoutineRow,
          PrefetchHooks Function()
        > {
  $$WorkoutRoutinesTableTableManager(
    _$AppDatabase db,
    $WorkoutRoutinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutRoutinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutRoutinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutRoutinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> restDurationSeconds = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutRoutinesCompanion(
                id: id,
                name: name,
                description: description,
                category: category,
                restDurationSeconds: restDurationSeconds,
                createdAt: createdAt,
                updatedAt: updatedAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required String category,
                Value<int> restDurationSeconds = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutRoutinesCompanion.insert(
                id: id,
                name: name,
                description: description,
                category: category,
                restDurationSeconds: restDurationSeconds,
                createdAt: createdAt,
                updatedAt: updatedAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutRoutinesTable, WorkoutRoutineRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WorkoutRoutinesTable,
                    WorkoutRoutineRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutRoutinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutRoutinesTable,
      WorkoutRoutineRow,
      $$WorkoutRoutinesTableFilterComposer,
      $$WorkoutRoutinesTableOrderingComposer,
      $$WorkoutRoutinesTableAnnotationComposer,
      $$WorkoutRoutinesTableCreateCompanionBuilder,
      $$WorkoutRoutinesTableUpdateCompanionBuilder,
      (
        WorkoutRoutineRow,
        BaseReferences<_$AppDatabase, $WorkoutRoutinesTable, WorkoutRoutineRow>,
      ),
      WorkoutRoutineRow,
      PrefetchHooks Function()
    >;
typedef $$RoutineExercisesTableCreateCompanionBuilder =
    RoutineExercisesCompanion Function({
      required String id,
      required String routineId,
      required String exerciseId,
      required int position,
      Value<int> setCount,
      Value<int> reps,
      Value<double> weightKg,
      Value<int> warmUpSetCount,
      Value<int?> restDurationSeconds,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$RoutineExercisesTableUpdateCompanionBuilder =
    RoutineExercisesCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<String> exerciseId,
      Value<int> position,
      Value<int> setCount,
      Value<int> reps,
      Value<double> weightKg,
      Value<int> warmUpSetCount,
      Value<int?> restDurationSeconds,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$RoutineExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setCount => $composableBuilder(
    column: $table.setCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get warmUpSetCount => $composableBuilder(
    column: $table.warmUpSetCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restDurationSeconds => $composableBuilder(
    column: $table.restDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RoutineExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setCount => $composableBuilder(
    column: $table.setCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get warmUpSetCount => $composableBuilder(
    column: $table.warmUpSetCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restDurationSeconds => $composableBuilder(
    column: $table.restDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutineExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutineExercisesTable> {
  $$RoutineExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get setCount =>
      $composableBuilder(column: $table.setCount, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get warmUpSetCount => $composableBuilder(
    column: $table.warmUpSetCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get restDurationSeconds => $composableBuilder(
    column: $table.restDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$RoutineExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutineExercisesTable,
          RoutineExerciseRow,
          $$RoutineExercisesTableFilterComposer,
          $$RoutineExercisesTableOrderingComposer,
          $$RoutineExercisesTableAnnotationComposer,
          $$RoutineExercisesTableCreateCompanionBuilder,
          $$RoutineExercisesTableUpdateCompanionBuilder,
          (
            RoutineExerciseRow,
            BaseReferences<
              _$AppDatabase,
              $RoutineExercisesTable,
              RoutineExerciseRow
            >,
          ),
          RoutineExerciseRow,
          PrefetchHooks Function()
        > {
  $$RoutineExercisesTableTableManager(
    _$AppDatabase db,
    $RoutineExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutineExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutineExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutineExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> setCount = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> warmUpSetCount = const Value.absent(),
                Value<int?> restDurationSeconds = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineExercisesCompanion(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                position: position,
                setCount: setCount,
                reps: reps,
                weightKg: weightKg,
                warmUpSetCount: warmUpSetCount,
                restDurationSeconds: restDurationSeconds,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                required String exerciseId,
                required int position,
                Value<int> setCount = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> warmUpSetCount = const Value.absent(),
                Value<int?> restDurationSeconds = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoutineExercisesCompanion.insert(
                id: id,
                routineId: routineId,
                exerciseId: exerciseId,
                position: position,
                setCount: setCount,
                reps: reps,
                weightKg: weightKg,
                warmUpSetCount: warmUpSetCount,
                restDurationSeconds: restDurationSeconds,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoutineExercisesTable, RoutineExerciseRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $RoutineExercisesTable,
                    RoutineExerciseRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RoutineExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutineExercisesTable,
      RoutineExerciseRow,
      $$RoutineExercisesTableFilterComposer,
      $$RoutineExercisesTableOrderingComposer,
      $$RoutineExercisesTableAnnotationComposer,
      $$RoutineExercisesTableCreateCompanionBuilder,
      $$RoutineExercisesTableUpdateCompanionBuilder,
      (
        RoutineExerciseRow,
        BaseReferences<
          _$AppDatabase,
          $RoutineExercisesTable,
          RoutineExerciseRow
        >,
      ),
      RoutineExerciseRow,
      PrefetchHooks Function()
    >;
typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  required String id,
  required String name,
  required String primaryMuscle,
  Value<String> secondaryMuscles,
  Value<bool> isCustom,
  Value<bool> isFavorite,
  Value<String?> equipment,
  Value<DateTime?> lastUsedAt,
  Value<int> rowid,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> primaryMuscle,
  Value<String> secondaryMuscles,
  Value<bool> isCustom,
  Value<bool> isFavorite,
  Value<String?> equipment,
  Value<DateTime?> lastUsedAt,
  Value<int> rowid,
});

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryMuscle => $composableBuilder(
    column: $table.primaryMuscle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          ExerciseRow,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (
            ExerciseRow,
            BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>,
          ),
          ExerciseRow,
          PrefetchHooks Function()
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> primaryMuscle = const Value.absent(),
                Value<String> secondaryMuscles = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                primaryMuscle: primaryMuscle,
                secondaryMuscles: secondaryMuscles,
                isCustom: isCustom,
                isFavorite: isFavorite,
                equipment: equipment,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String primaryMuscle,
                Value<String> secondaryMuscles = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                primaryMuscle: primaryMuscle,
                secondaryMuscles: secondaryMuscles,
                isCustom: isCustom,
                isFavorite: isFavorite,
                equipment: equipment,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExercisesTable, ExerciseRow>(table),
                  BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      ExerciseRow,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (
        ExerciseRow,
        BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>,
      ),
      ExerciseRow,
      PrefetchHooks Function()
    >;
typedef $$WorkoutSessionsTableCreateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      required String id,
      required String routineId,
      required String name,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      required String status,
      Value<DateTime?> scheduledDate,
      Value<bool> wasScheduled,
      Value<int?> xpEarned,
      Value<int?> personalRecords,
      Value<bool> spotifyUsed,
      Value<int> spotifyTracksPlayed,
      Value<bool> playlistUsed,
      Value<int> rowid,
    });
typedef $$WorkoutSessionsTableUpdateCompanionBuilder =
    WorkoutSessionsCompanion Function({
      Value<String> id,
      Value<String> routineId,
      Value<String> name,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<String> status,
      Value<DateTime?> scheduledDate,
      Value<bool> wasScheduled,
      Value<int?> xpEarned,
      Value<int?> personalRecords,
      Value<bool> spotifyUsed,
      Value<int> spotifyTracksPlayed,
      Value<bool> playlistUsed,
      Value<int> rowid,
    });

class $$WorkoutSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasScheduled => $composableBuilder(
    column: $table.wasScheduled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get personalRecords => $composableBuilder(
    column: $table.personalRecords,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get spotifyUsed => $composableBuilder(
    column: $table.spotifyUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spotifyTracksPlayed => $composableBuilder(
    column: $table.spotifyTracksPlayed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get playlistUsed => $composableBuilder(
    column: $table.playlistUsed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasScheduled => $composableBuilder(
    column: $table.wasScheduled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get personalRecords => $composableBuilder(
    column: $table.personalRecords,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get spotifyUsed => $composableBuilder(
    column: $table.spotifyUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spotifyTracksPlayed => $composableBuilder(
    column: $table.spotifyTracksPlayed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get playlistUsed => $composableBuilder(
    column: $table.playlistUsed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSessionsTable> {
  $$WorkoutSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wasScheduled => $composableBuilder(
    column: $table.wasScheduled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);

  GeneratedColumn<int> get personalRecords => $composableBuilder(
    column: $table.personalRecords,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get spotifyUsed => $composableBuilder(
    column: $table.spotifyUsed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get spotifyTracksPlayed => $composableBuilder(
    column: $table.spotifyTracksPlayed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get playlistUsed => $composableBuilder(
    column: $table.playlistUsed,
    builder: (column) => column,
  );
}

class $$WorkoutSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSessionsTable,
          WorkoutSessionRow,
          $$WorkoutSessionsTableFilterComposer,
          $$WorkoutSessionsTableOrderingComposer,
          $$WorkoutSessionsTableAnnotationComposer,
          $$WorkoutSessionsTableCreateCompanionBuilder,
          $$WorkoutSessionsTableUpdateCompanionBuilder,
          (
            WorkoutSessionRow,
            BaseReferences<
              _$AppDatabase,
              $WorkoutSessionsTable,
              WorkoutSessionRow
            >,
          ),
          WorkoutSessionRow,
          PrefetchHooks Function()
        > {
  $$WorkoutSessionsTableTableManager(
    _$AppDatabase db,
    $WorkoutSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> routineId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<bool> wasScheduled = const Value.absent(),
                Value<int?> xpEarned = const Value.absent(),
                Value<int?> personalRecords = const Value.absent(),
                Value<bool> spotifyUsed = const Value.absent(),
                Value<int> spotifyTracksPlayed = const Value.absent(),
                Value<bool> playlistUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion(
                id: id,
                routineId: routineId,
                name: name,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                scheduledDate: scheduledDate,
                wasScheduled: wasScheduled,
                xpEarned: xpEarned,
                personalRecords: personalRecords,
                spotifyUsed: spotifyUsed,
                spotifyTracksPlayed: spotifyTracksPlayed,
                playlistUsed: playlistUsed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String routineId,
                required String name,
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                required String status,
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<bool> wasScheduled = const Value.absent(),
                Value<int?> xpEarned = const Value.absent(),
                Value<int?> personalRecords = const Value.absent(),
                Value<bool> spotifyUsed = const Value.absent(),
                Value<int> spotifyTracksPlayed = const Value.absent(),
                Value<bool> playlistUsed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSessionsCompanion.insert(
                id: id,
                routineId: routineId,
                name: name,
                startedAt: startedAt,
                completedAt: completedAt,
                status: status,
                scheduledDate: scheduledDate,
                wasScheduled: wasScheduled,
                xpEarned: xpEarned,
                personalRecords: personalRecords,
                spotifyUsed: spotifyUsed,
                spotifyTracksPlayed: spotifyTracksPlayed,
                playlistUsed: playlistUsed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutSessionsTable, WorkoutSessionRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WorkoutSessionsTable,
                    WorkoutSessionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSessionsTable,
      WorkoutSessionRow,
      $$WorkoutSessionsTableFilterComposer,
      $$WorkoutSessionsTableOrderingComposer,
      $$WorkoutSessionsTableAnnotationComposer,
      $$WorkoutSessionsTableCreateCompanionBuilder,
      $$WorkoutSessionsTableUpdateCompanionBuilder,
      (
        WorkoutSessionRow,
        BaseReferences<_$AppDatabase, $WorkoutSessionsTable, WorkoutSessionRow>,
      ),
      WorkoutSessionRow,
      PrefetchHooks Function()
    >;
typedef $$SessionExercisesTableCreateCompanionBuilder =
    SessionExercisesCompanion Function({
      required String id,
      required String sessionId,
      required String exerciseId,
      required int position,
      Value<String?> notes,
      Value<bool> isReplaced,
      Value<int> rowid,
    });
typedef $$SessionExercisesTableUpdateCompanionBuilder =
    SessionExercisesCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> exerciseId,
      Value<int> position,
      Value<String?> notes,
      Value<bool> isReplaced,
      Value<int> rowid,
    });

class $$SessionExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $SessionExercisesTable> {
  $$SessionExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isReplaced => $composableBuilder(
    column: $table.isReplaced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionExercisesTable> {
  $$SessionExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isReplaced => $composableBuilder(
    column: $table.isReplaced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionExercisesTable> {
  $$SessionExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isReplaced => $composableBuilder(
    column: $table.isReplaced,
    builder: (column) => column,
  );
}

class $$SessionExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionExercisesTable,
          SessionExerciseRow,
          $$SessionExercisesTableFilterComposer,
          $$SessionExercisesTableOrderingComposer,
          $$SessionExercisesTableAnnotationComposer,
          $$SessionExercisesTableCreateCompanionBuilder,
          $$SessionExercisesTableUpdateCompanionBuilder,
          (
            SessionExerciseRow,
            BaseReferences<
              _$AppDatabase,
              $SessionExercisesTable,
              SessionExerciseRow
            >,
          ),
          SessionExerciseRow,
          PrefetchHooks Function()
        > {
  $$SessionExercisesTableTableManager(
    _$AppDatabase db,
    $SessionExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isReplaced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionExercisesCompanion(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                position: position,
                notes: notes,
                isReplaced: isReplaced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String exerciseId,
                required int position,
                Value<String?> notes = const Value.absent(),
                Value<bool> isReplaced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionExercisesCompanion.insert(
                id: id,
                sessionId: sessionId,
                exerciseId: exerciseId,
                position: position,
                notes: notes,
                isReplaced: isReplaced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionExercisesTable, SessionExerciseRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $SessionExercisesTable,
                    SessionExerciseRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionExercisesTable,
      SessionExerciseRow,
      $$SessionExercisesTableFilterComposer,
      $$SessionExercisesTableOrderingComposer,
      $$SessionExercisesTableAnnotationComposer,
      $$SessionExercisesTableCreateCompanionBuilder,
      $$SessionExercisesTableUpdateCompanionBuilder,
      (
        SessionExerciseRow,
        BaseReferences<
          _$AppDatabase,
          $SessionExercisesTable,
          SessionExerciseRow
        >,
      ),
      SessionExerciseRow,
      PrefetchHooks Function()
    >;
typedef $$SessionSetsTableCreateCompanionBuilder =
    SessionSetsCompanion Function({
      required String id,
      required String sessionExerciseId,
      required String exerciseId,
      required int setIndex,
      Value<double> weightKg,
      Value<int> reps,
      Value<int?> durationSeconds,
      Value<bool> completed,
      Value<DateTime?> completedAt,
      Value<bool> isWarmUp,
      Value<int> rowid,
    });
typedef $$SessionSetsTableUpdateCompanionBuilder =
    SessionSetsCompanion Function({
      Value<String> id,
      Value<String> sessionExerciseId,
      Value<String> exerciseId,
      Value<int> setIndex,
      Value<double> weightKg,
      Value<int> reps,
      Value<int?> durationSeconds,
      Value<bool> completed,
      Value<DateTime?> completedAt,
      Value<bool> isWarmUp,
      Value<int> rowid,
    });

class $$SessionSetsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionSetsTable> {
  $$SessionSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionExerciseId => $composableBuilder(
    column: $table.sessionExerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setIndex => $composableBuilder(
    column: $table.setIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isWarmUp => $composableBuilder(
    column: $table.isWarmUp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionSetsTable> {
  $$SessionSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionExerciseId => $composableBuilder(
    column: $table.sessionExerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setIndex => $composableBuilder(
    column: $table.setIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isWarmUp => $composableBuilder(
    column: $table.isWarmUp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionSetsTable> {
  $$SessionSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionExerciseId => $composableBuilder(
    column: $table.sessionExerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setIndex =>
      $composableBuilder(column: $table.setIndex, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isWarmUp =>
      $composableBuilder(column: $table.isWarmUp, builder: (column) => column);
}

class $$SessionSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionSetsTable,
          SessionSetRow,
          $$SessionSetsTableFilterComposer,
          $$SessionSetsTableOrderingComposer,
          $$SessionSetsTableAnnotationComposer,
          $$SessionSetsTableCreateCompanionBuilder,
          $$SessionSetsTableUpdateCompanionBuilder,
          (
            SessionSetRow,
            BaseReferences<_$AppDatabase, $SessionSetsTable, SessionSetRow>,
          ),
          SessionSetRow,
          PrefetchHooks Function()
        > {
  $$SessionSetsTableTableManager(_$AppDatabase db, $SessionSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionExerciseId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> setIndex = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isWarmUp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionSetsCompanion(
                id: id,
                sessionExerciseId: sessionExerciseId,
                exerciseId: exerciseId,
                setIndex: setIndex,
                weightKg: weightKg,
                reps: reps,
                durationSeconds: durationSeconds,
                completed: completed,
                completedAt: completedAt,
                isWarmUp: isWarmUp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionExerciseId,
                required String exerciseId,
                required int setIndex,
                Value<double> weightKg = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> isWarmUp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionSetsCompanion.insert(
                id: id,
                sessionExerciseId: sessionExerciseId,
                exerciseId: exerciseId,
                setIndex: setIndex,
                weightKg: weightKg,
                reps: reps,
                durationSeconds: durationSeconds,
                completed: completed,
                completedAt: completedAt,
                isWarmUp: isWarmUp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SessionSetsTable, SessionSetRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SessionSetsTable,
                    SessionSetRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionSetsTable,
      SessionSetRow,
      $$SessionSetsTableFilterComposer,
      $$SessionSetsTableOrderingComposer,
      $$SessionSetsTableAnnotationComposer,
      $$SessionSetsTableCreateCompanionBuilder,
      $$SessionSetsTableUpdateCompanionBuilder,
      (
        SessionSetRow,
        BaseReferences<_$AppDatabase, $SessionSetsTable, SessionSetRow>,
      ),
      SessionSetRow,
      PrefetchHooks Function()
    >;
typedef $$ScheduleEntriesTableCreateCompanionBuilder =
    ScheduleEntriesCompanion Function({
      required String id,
      required DateTime date,
      Value<String?> routineId,
      Value<String?> label,
      Value<int> rowid,
    });
typedef $$ScheduleEntriesTableUpdateCompanionBuilder =
    ScheduleEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<String?> routineId,
      Value<String?> label,
      Value<int> rowid,
    });

class $$ScheduleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ScheduleEntriesTable> {
  $$ScheduleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScheduleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScheduleEntriesTable> {
  $$ScheduleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineId => $composableBuilder(
    column: $table.routineId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScheduleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScheduleEntriesTable> {
  $$ScheduleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get routineId =>
      $composableBuilder(column: $table.routineId, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);
}

class $$ScheduleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScheduleEntriesTable,
          ScheduleEntryRow,
          $$ScheduleEntriesTableFilterComposer,
          $$ScheduleEntriesTableOrderingComposer,
          $$ScheduleEntriesTableAnnotationComposer,
          $$ScheduleEntriesTableCreateCompanionBuilder,
          $$ScheduleEntriesTableUpdateCompanionBuilder,
          (
            ScheduleEntryRow,
            BaseReferences<
              _$AppDatabase,
              $ScheduleEntriesTable,
              ScheduleEntryRow
            >,
          ),
          ScheduleEntryRow,
          PrefetchHooks Function()
        > {
  $$ScheduleEntriesTableTableManager(
    _$AppDatabase db,
    $ScheduleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScheduleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScheduleEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScheduleEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> routineId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleEntriesCompanion(
                id: id,
                date: date,
                routineId: routineId,
                label: label,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                Value<String?> routineId = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ScheduleEntriesCompanion.insert(
                id: id,
                date: date,
                routineId: routineId,
                label: label,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScheduleEntriesTable, ScheduleEntryRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ScheduleEntriesTable,
                    ScheduleEntryRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScheduleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScheduleEntriesTable,
      ScheduleEntryRow,
      $$ScheduleEntriesTableFilterComposer,
      $$ScheduleEntriesTableOrderingComposer,
      $$ScheduleEntriesTableAnnotationComposer,
      $$ScheduleEntriesTableCreateCompanionBuilder,
      $$ScheduleEntriesTableUpdateCompanionBuilder,
      (
        ScheduleEntryRow,
        BaseReferences<_$AppDatabase, $ScheduleEntriesTable, ScheduleEntryRow>,
      ),
      ScheduleEntryRow,
      PrefetchHooks Function()
    >;
typedef $$PersonalRecordsTableCreateCompanionBuilder =
    PersonalRecordsCompanion Function({
      required String id,
      required String userId,
      required String exerciseId,
      required String exerciseName,
      required String type,
      required double value,
      Value<double?> weightKg,
      Value<int?> reps,
      Value<double?> previousValue,
      required DateTime achievedAt,
      Value<String?> workoutSessionId,
      Value<int> rowid,
    });
typedef $$PersonalRecordsTableUpdateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> exerciseId,
      Value<String> exerciseName,
      Value<String> type,
      Value<double> value,
      Value<double?> weightKg,
      Value<int?> reps,
      Value<double?> previousValue,
      Value<DateTime> achievedAt,
      Value<String?> workoutSessionId,
      Value<int> rowid,
    });

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get previousValue => $composableBuilder(
    column: $table.previousValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutSessionId => $composableBuilder(
    column: $table.workoutSessionId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get previousValue => $composableBuilder(
    column: $table.previousValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutSessionId => $composableBuilder(
    column: $table.workoutSessionId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get previousValue => $composableBuilder(
    column: $table.previousValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workoutSessionId => $composableBuilder(
    column: $table.workoutSessionId,
    builder: (column) => column,
  );
}

class $$PersonalRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalRecordsTable,
          PersonalRecordRow,
          $$PersonalRecordsTableFilterComposer,
          $$PersonalRecordsTableOrderingComposer,
          $$PersonalRecordsTableAnnotationComposer,
          $$PersonalRecordsTableCreateCompanionBuilder,
          $$PersonalRecordsTableUpdateCompanionBuilder,
          (
            PersonalRecordRow,
            BaseReferences<
              _$AppDatabase,
              $PersonalRecordsTable,
              PersonalRecordRow
            >,
          ),
          PersonalRecordRow,
          PrefetchHooks Function()
        > {
  $$PersonalRecordsTableTableManager(
    _$AppDatabase db,
    $PersonalRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> exerciseName = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> previousValue = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
                Value<String?> workoutSessionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonalRecordsCompanion(
                id: id,
                userId: userId,
                exerciseId: exerciseId,
                exerciseName: exerciseName,
                type: type,
                value: value,
                weightKg: weightKg,
                reps: reps,
                previousValue: previousValue,
                achievedAt: achievedAt,
                workoutSessionId: workoutSessionId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String exerciseId,
                required String exerciseName,
                required String type,
                required double value,
                Value<double?> weightKg = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> previousValue = const Value.absent(),
                required DateTime achievedAt,
                Value<String?> workoutSessionId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PersonalRecordsCompanion.insert(
                id: id,
                userId: userId,
                exerciseId: exerciseId,
                exerciseName: exerciseName,
                type: type,
                value: value,
                weightKg: weightKg,
                reps: reps,
                previousValue: previousValue,
                achievedAt: achievedAt,
                workoutSessionId: workoutSessionId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PersonalRecordsTable, PersonalRecordRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PersonalRecordsTable,
                    PersonalRecordRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonalRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalRecordsTable,
      PersonalRecordRow,
      $$PersonalRecordsTableFilterComposer,
      $$PersonalRecordsTableOrderingComposer,
      $$PersonalRecordsTableAnnotationComposer,
      $$PersonalRecordsTableCreateCompanionBuilder,
      $$PersonalRecordsTableUpdateCompanionBuilder,
      (
        PersonalRecordRow,
        BaseReferences<_$AppDatabase, $PersonalRecordsTable, PersonalRecordRow>,
      ),
      PersonalRecordRow,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      required String id,
      required String name,
      required String description,
      required String family,
      required String metric,
      required int threshold,
      required int xpReward,
      Value<String?> icon,
      Value<String?> badgeId,
      Value<int> rowid,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> family,
      Value<String> metric,
      Value<int> threshold,
      Value<int> xpReward,
      Value<String?> icon,
      Value<String?> badgeId,
      Value<int> rowid,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get family => $composableBuilder(
    column: $table.family,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get threshold => $composableBuilder(
    column: $table.threshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get family => $composableBuilder(
    column: $table.family,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get threshold => $composableBuilder(
    column: $table.threshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get family =>
      $composableBuilder(column: $table.family, builder: (column) => column);

  GeneratedColumn<String> get metric =>
      $composableBuilder(column: $table.metric, builder: (column) => column);

  GeneratedColumn<int> get threshold =>
      $composableBuilder(column: $table.threshold, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get badgeId =>
      $composableBuilder(column: $table.badgeId, builder: (column) => column);
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          AchievementRow,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            AchievementRow,
            BaseReferences<_$AppDatabase, $AchievementsTable, AchievementRow>,
          ),
          AchievementRow,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> family = const Value.absent(),
                Value<String> metric = const Value.absent(),
                Value<int> threshold = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> badgeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                name: name,
                description: description,
                family: family,
                metric: metric,
                threshold: threshold,
                xpReward: xpReward,
                icon: icon,
                badgeId: badgeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                required String family,
                required String metric,
                required int threshold,
                required int xpReward,
                Value<String?> icon = const Value.absent(),
                Value<String?> badgeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                name: name,
                description: description,
                family: family,
                metric: metric,
                threshold: threshold,
                xpReward: xpReward,
                icon: icon,
                badgeId: badgeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AchievementsTable, AchievementRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AchievementsTable,
                    AchievementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      AchievementRow,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        AchievementRow,
        BaseReferences<_$AppDatabase, $AchievementsTable, AchievementRow>,
      ),
      AchievementRow,
      PrefetchHooks Function()
    >;
typedef $$UserAchievementsTableCreateCompanionBuilder =
    UserAchievementsCompanion Function({
      required String achievementId,
      required String userId,
      Value<int> progress,
      Value<bool> unlocked,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });
typedef $$UserAchievementsTableUpdateCompanionBuilder =
    UserAchievementsCompanion Function({
      Value<String> achievementId,
      Value<String> userId,
      Value<int> progress,
      Value<bool> unlocked,
      Value<DateTime?> unlockedAt,
      Value<int> rowid,
    });

class $$UserAchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserAchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get unlocked => $composableBuilder(
    column: $table.unlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserAchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAchievementsTable> {
  $$UserAchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get achievementId => $composableBuilder(
    column: $table.achievementId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<bool> get unlocked =>
      $composableBuilder(column: $table.unlocked, builder: (column) => column);

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$UserAchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAchievementsTable,
          UserAchievementRow,
          $$UserAchievementsTableFilterComposer,
          $$UserAchievementsTableOrderingComposer,
          $$UserAchievementsTableAnnotationComposer,
          $$UserAchievementsTableCreateCompanionBuilder,
          $$UserAchievementsTableUpdateCompanionBuilder,
          (
            UserAchievementRow,
            BaseReferences<
              _$AppDatabase,
              $UserAchievementsTable,
              UserAchievementRow
            >,
          ),
          UserAchievementRow,
          PrefetchHooks Function()
        > {
  $$UserAchievementsTableTableManager(
    _$AppDatabase db,
    $UserAchievementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> achievementId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> progress = const Value.absent(),
                Value<bool> unlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAchievementsCompanion(
                achievementId: achievementId,
                userId: userId,
                progress: progress,
                unlocked: unlocked,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String achievementId,
                required String userId,
                Value<int> progress = const Value.absent(),
                Value<bool> unlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAchievementsCompanion.insert(
                achievementId: achievementId,
                userId: userId,
                progress: progress,
                unlocked: unlocked,
                unlockedAt: unlockedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserAchievementsTable, UserAchievementRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $UserAchievementsTable,
                    UserAchievementRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserAchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAchievementsTable,
      UserAchievementRow,
      $$UserAchievementsTableFilterComposer,
      $$UserAchievementsTableOrderingComposer,
      $$UserAchievementsTableAnnotationComposer,
      $$UserAchievementsTableCreateCompanionBuilder,
      $$UserAchievementsTableUpdateCompanionBuilder,
      (
        UserAchievementRow,
        BaseReferences<
          _$AppDatabase,
          $UserAchievementsTable,
          UserAchievementRow
        >,
      ),
      UserAchievementRow,
      PrefetchHooks Function()
    >;
typedef $$BadgesTableCreateCompanionBuilder = BadgesCompanion Function({
  required String id,
  required String name,
  required String emoji,
  required String description,
  Value<int> rowid,
});
typedef $$BadgesTableUpdateCompanionBuilder = BadgesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> emoji,
  Value<String> description,
  Value<int> rowid,
});

class $$BadgesTableFilterComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BadgesTableOrderingComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emoji => $composableBuilder(
    column: $table.emoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BadgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BadgesTable> {
  $$BadgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$BadgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BadgesTable,
          BadgeRow,
          $$BadgesTableFilterComposer,
          $$BadgesTableOrderingComposer,
          $$BadgesTableAnnotationComposer,
          $$BadgesTableCreateCompanionBuilder,
          $$BadgesTableUpdateCompanionBuilder,
          (BadgeRow, BaseReferences<_$AppDatabase, $BadgesTable, BadgeRow>),
          BadgeRow,
          PrefetchHooks Function()
        > {
  $$BadgesTableTableManager(_$AppDatabase db, $BadgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BadgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BadgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BadgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> emoji = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BadgesCompanion(
                id: id,
                name: name,
                emoji: emoji,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String emoji,
                required String description,
                Value<int> rowid = const Value.absent(),
              }) => BadgesCompanion.insert(
                id: id,
                name: name,
                emoji: emoji,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BadgesTable, BadgeRow>(table),
                  BaseReferences<_$AppDatabase, $BadgesTable, BadgeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BadgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BadgesTable,
      BadgeRow,
      $$BadgesTableFilterComposer,
      $$BadgesTableOrderingComposer,
      $$BadgesTableAnnotationComposer,
      $$BadgesTableCreateCompanionBuilder,
      $$BadgesTableUpdateCompanionBuilder,
      (BadgeRow, BaseReferences<_$AppDatabase, $BadgesTable, BadgeRow>),
      BadgeRow,
      PrefetchHooks Function()
    >;
typedef $$UserBadgesTableCreateCompanionBuilder = UserBadgesCompanion Function({
  required String badgeId,
  required String userId,
  required DateTime earnedAt,
  Value<bool> isShowcased,
  Value<int> rowid,
});
typedef $$UserBadgesTableUpdateCompanionBuilder = UserBadgesCompanion Function({
  Value<String> badgeId,
  Value<String> userId,
  Value<DateTime> earnedAt,
  Value<bool> isShowcased,
  Value<int> rowid,
});

class $$UserBadgesTableFilterComposer
    extends Composer<_$AppDatabase, $UserBadgesTable> {
  $$UserBadgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isShowcased => $composableBuilder(
    column: $table.isShowcased,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserBadgesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserBadgesTable> {
  $$UserBadgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get badgeId => $composableBuilder(
    column: $table.badgeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isShowcased => $composableBuilder(
    column: $table.isShowcased,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserBadgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserBadgesTable> {
  $$UserBadgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get badgeId =>
      $composableBuilder(column: $table.badgeId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get earnedAt =>
      $composableBuilder(column: $table.earnedAt, builder: (column) => column);

  GeneratedColumn<bool> get isShowcased => $composableBuilder(
    column: $table.isShowcased,
    builder: (column) => column,
  );
}

class $$UserBadgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserBadgesTable,
          UserBadgeRow,
          $$UserBadgesTableFilterComposer,
          $$UserBadgesTableOrderingComposer,
          $$UserBadgesTableAnnotationComposer,
          $$UserBadgesTableCreateCompanionBuilder,
          $$UserBadgesTableUpdateCompanionBuilder,
          (
            UserBadgeRow,
            BaseReferences<_$AppDatabase, $UserBadgesTable, UserBadgeRow>,
          ),
          UserBadgeRow,
          PrefetchHooks Function()
        > {
  $$UserBadgesTableTableManager(_$AppDatabase db, $UserBadgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserBadgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserBadgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserBadgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> badgeId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> earnedAt = const Value.absent(),
                Value<bool> isShowcased = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserBadgesCompanion(
                badgeId: badgeId,
                userId: userId,
                earnedAt: earnedAt,
                isShowcased: isShowcased,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String badgeId,
                required String userId,
                required DateTime earnedAt,
                Value<bool> isShowcased = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserBadgesCompanion.insert(
                badgeId: badgeId,
                userId: userId,
                earnedAt: earnedAt,
                isShowcased: isShowcased,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserBadgesTable, UserBadgeRow>(table),
                  BaseReferences<_$AppDatabase, $UserBadgesTable, UserBadgeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserBadgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserBadgesTable,
      UserBadgeRow,
      $$UserBadgesTableFilterComposer,
      $$UserBadgesTableOrderingComposer,
      $$UserBadgesTableAnnotationComposer,
      $$UserBadgesTableCreateCompanionBuilder,
      $$UserBadgesTableUpdateCompanionBuilder,
      (
        UserBadgeRow,
        BaseReferences<_$AppDatabase, $UserBadgesTable, UserBadgeRow>,
      ),
      UserBadgeRow,
      PrefetchHooks Function()
    >;
typedef $$ChallengesTableCreateCompanionBuilder = ChallengesCompanion Function({
  required String id,
  required String period,
  required String title,
  required String description,
  required String metric,
  required int target,
  required int xpReward,
  Value<String?> icon,
  Value<int> rowid,
});
typedef $$ChallengesTableUpdateCompanionBuilder = ChallengesCompanion Function({
  Value<String> id,
  Value<String> period,
  Value<String> title,
  Value<String> description,
  Value<String> metric,
  Value<int> target,
  Value<int> xpReward,
  Value<String?> icon,
  Value<int> rowid,
});

class $$ChallengesTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metric => $composableBuilder(
    column: $table.metric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpReward => $composableBuilder(
    column: $table.xpReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengesTable> {
  $$ChallengesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metric =>
      $composableBuilder(column: $table.metric, builder: (column) => column);

  GeneratedColumn<int> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<int> get xpReward =>
      $composableBuilder(column: $table.xpReward, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);
}

class $$ChallengesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengesTable,
          ChallengeRow,
          $$ChallengesTableFilterComposer,
          $$ChallengesTableOrderingComposer,
          $$ChallengesTableAnnotationComposer,
          $$ChallengesTableCreateCompanionBuilder,
          $$ChallengesTableUpdateCompanionBuilder,
          (
            ChallengeRow,
            BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>,
          ),
          ChallengeRow,
          PrefetchHooks Function()
        > {
  $$ChallengesTableTableManager(_$AppDatabase db, $ChallengesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> metric = const Value.absent(),
                Value<int> target = const Value.absent(),
                Value<int> xpReward = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion(
                id: id,
                period: period,
                title: title,
                description: description,
                metric: metric,
                target: target,
                xpReward: xpReward,
                icon: icon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String period,
                required String title,
                required String description,
                required String metric,
                required int target,
                required int xpReward,
                Value<String?> icon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengesCompanion.insert(
                id: id,
                period: period,
                title: title,
                description: description,
                metric: metric,
                target: target,
                xpReward: xpReward,
                icon: icon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChallengesTable, ChallengeRow>(table),
                  BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengesTable,
      ChallengeRow,
      $$ChallengesTableFilterComposer,
      $$ChallengesTableOrderingComposer,
      $$ChallengesTableAnnotationComposer,
      $$ChallengesTableCreateCompanionBuilder,
      $$ChallengesTableUpdateCompanionBuilder,
      (
        ChallengeRow,
        BaseReferences<_$AppDatabase, $ChallengesTable, ChallengeRow>,
      ),
      ChallengeRow,
      PrefetchHooks Function()
    >;
typedef $$ChallengeProgressTableCreateCompanionBuilder =
    ChallengeProgressCompanion Function({
      required String challengeId,
      required String userId,
      required String periodKey,
      Value<int> current,
      Value<bool> claimed,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });
typedef $$ChallengeProgressTableUpdateCompanionBuilder =
    ChallengeProgressCompanion Function({
      Value<String> challengeId,
      Value<String> userId,
      Value<String> periodKey,
      Value<int> current,
      Value<bool> claimed,
      Value<DateTime?> completedAt,
      Value<int> rowid,
    });

class $$ChallengeProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ChallengeProgressTable> {
  $$ChallengeProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get challengeId => $composableBuilder(
    column: $table.challengeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get periodKey => $composableBuilder(
    column: $table.periodKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChallengeProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ChallengeProgressTable> {
  $$ChallengeProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get challengeId => $composableBuilder(
    column: $table.challengeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodKey => $composableBuilder(
    column: $table.periodKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get claimed => $composableBuilder(
    column: $table.claimed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChallengeProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChallengeProgressTable> {
  $$ChallengeProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get challengeId => $composableBuilder(
    column: $table.challengeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get periodKey =>
      $composableBuilder(column: $table.periodKey, builder: (column) => column);

  GeneratedColumn<int> get current =>
      $composableBuilder(column: $table.current, builder: (column) => column);

  GeneratedColumn<bool> get claimed =>
      $composableBuilder(column: $table.claimed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$ChallengeProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChallengeProgressTable,
          ChallengeProgressRow,
          $$ChallengeProgressTableFilterComposer,
          $$ChallengeProgressTableOrderingComposer,
          $$ChallengeProgressTableAnnotationComposer,
          $$ChallengeProgressTableCreateCompanionBuilder,
          $$ChallengeProgressTableUpdateCompanionBuilder,
          (
            ChallengeProgressRow,
            BaseReferences<
              _$AppDatabase,
              $ChallengeProgressTable,
              ChallengeProgressRow
            >,
          ),
          ChallengeProgressRow,
          PrefetchHooks Function()
        > {
  $$ChallengeProgressTableTableManager(
    _$AppDatabase db,
    $ChallengeProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChallengeProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChallengeProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChallengeProgressTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> challengeId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> periodKey = const Value.absent(),
                Value<int> current = const Value.absent(),
                Value<bool> claimed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengeProgressCompanion(
                challengeId: challengeId,
                userId: userId,
                periodKey: periodKey,
                current: current,
                claimed: claimed,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String challengeId,
                required String userId,
                required String periodKey,
                Value<int> current = const Value.absent(),
                Value<bool> claimed = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChallengeProgressCompanion.insert(
                challengeId: challengeId,
                userId: userId,
                periodKey: periodKey,
                current: current,
                claimed: claimed,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ChallengeProgressTable, ChallengeProgressRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ChallengeProgressTable,
                    ChallengeProgressRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChallengeProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChallengeProgressTable,
      ChallengeProgressRow,
      $$ChallengeProgressTableFilterComposer,
      $$ChallengeProgressTableOrderingComposer,
      $$ChallengeProgressTableAnnotationComposer,
      $$ChallengeProgressTableCreateCompanionBuilder,
      $$ChallengeProgressTableUpdateCompanionBuilder,
      (
        ChallengeProgressRow,
        BaseReferences<
          _$AppDatabase,
          $ChallengeProgressTable,
          ChallengeProgressRow
        >,
      ),
      ChallengeProgressRow,
      PrefetchHooks Function()
    >;
typedef $$SpotifyAccountsTableCreateCompanionBuilder =
    SpotifyAccountsCompanion Function({
      required String userId,
      required String spotifyUserId,
      required String displayName,
      Value<String?> imageUrl,
      Value<String?> email,
      required DateTime connectedAt,
      Value<int> rowid,
    });
typedef $$SpotifyAccountsTableUpdateCompanionBuilder =
    SpotifyAccountsCompanion Function({
      Value<String> userId,
      Value<String> spotifyUserId,
      Value<String> displayName,
      Value<String?> imageUrl,
      Value<String?> email,
      Value<DateTime> connectedAt,
      Value<int> rowid,
    });

class $$SpotifyAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $SpotifyAccountsTable> {
  $$SpotifyAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spotifyUserId => $composableBuilder(
    column: $table.spotifyUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SpotifyAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpotifyAccountsTable> {
  $$SpotifyAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spotifyUserId => $composableBuilder(
    column: $table.spotifyUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpotifyAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpotifyAccountsTable> {
  $$SpotifyAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get spotifyUserId => $composableBuilder(
    column: $table.spotifyUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get connectedAt => $composableBuilder(
    column: $table.connectedAt,
    builder: (column) => column,
  );
}

class $$SpotifyAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpotifyAccountsTable,
          SpotifyAccountRow,
          $$SpotifyAccountsTableFilterComposer,
          $$SpotifyAccountsTableOrderingComposer,
          $$SpotifyAccountsTableAnnotationComposer,
          $$SpotifyAccountsTableCreateCompanionBuilder,
          $$SpotifyAccountsTableUpdateCompanionBuilder,
          (
            SpotifyAccountRow,
            BaseReferences<
              _$AppDatabase,
              $SpotifyAccountsTable,
              SpotifyAccountRow
            >,
          ),
          SpotifyAccountRow,
          PrefetchHooks Function()
        > {
  $$SpotifyAccountsTableTableManager(
    _$AppDatabase db,
    $SpotifyAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpotifyAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpotifyAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpotifyAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> spotifyUserId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<DateTime> connectedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpotifyAccountsCompanion(
                userId: userId,
                spotifyUserId: spotifyUserId,
                displayName: displayName,
                imageUrl: imageUrl,
                email: email,
                connectedAt: connectedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String spotifyUserId,
                required String displayName,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> email = const Value.absent(),
                required DateTime connectedAt,
                Value<int> rowid = const Value.absent(),
              }) => SpotifyAccountsCompanion.insert(
                userId: userId,
                spotifyUserId: spotifyUserId,
                displayName: displayName,
                imageUrl: imageUrl,
                email: email,
                connectedAt: connectedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SpotifyAccountsTable, SpotifyAccountRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $SpotifyAccountsTable,
                    SpotifyAccountRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SpotifyAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpotifyAccountsTable,
      SpotifyAccountRow,
      $$SpotifyAccountsTableFilterComposer,
      $$SpotifyAccountsTableOrderingComposer,
      $$SpotifyAccountsTableAnnotationComposer,
      $$SpotifyAccountsTableCreateCompanionBuilder,
      $$SpotifyAccountsTableUpdateCompanionBuilder,
      (
        SpotifyAccountRow,
        BaseReferences<_$AppDatabase, $SpotifyAccountsTable, SpotifyAccountRow>,
      ),
      SpotifyAccountRow,
      PrefetchHooks Function()
    >;
typedef $$TrainingDaysTableCreateCompanionBuilder =
    TrainingDaysCompanion Function({
      required String userId,
      required DateTime date,
      Value<int> workoutCount,
      Value<int> setsCompleted,
      Value<double> volumeKg,
      Value<int> trainingSeconds,
      Value<bool> isScheduledRest,
      Value<String> routineIdsCsv,
      Value<String> muscleGroupsCsv,
      Value<int> rowid,
    });
typedef $$TrainingDaysTableUpdateCompanionBuilder =
    TrainingDaysCompanion Function({
      Value<String> userId,
      Value<DateTime> date,
      Value<int> workoutCount,
      Value<int> setsCompleted,
      Value<double> volumeKg,
      Value<int> trainingSeconds,
      Value<bool> isScheduledRest,
      Value<String> routineIdsCsv,
      Value<String> muscleGroupsCsv,
      Value<int> rowid,
    });

class $$TrainingDaysTableFilterComposer
    extends Composer<_$AppDatabase, $TrainingDaysTable> {
  $$TrainingDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workoutCount => $composableBuilder(
    column: $table.workoutCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setsCompleted => $composableBuilder(
    column: $table.setsCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeKg => $composableBuilder(
    column: $table.volumeKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trainingSeconds => $composableBuilder(
    column: $table.trainingSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isScheduledRest => $composableBuilder(
    column: $table.isScheduledRest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineIdsCsv => $composableBuilder(
    column: $table.routineIdsCsv,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleGroupsCsv => $composableBuilder(
    column: $table.muscleGroupsCsv,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrainingDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $TrainingDaysTable> {
  $$TrainingDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workoutCount => $composableBuilder(
    column: $table.workoutCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setsCompleted => $composableBuilder(
    column: $table.setsCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeKg => $composableBuilder(
    column: $table.volumeKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trainingSeconds => $composableBuilder(
    column: $table.trainingSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isScheduledRest => $composableBuilder(
    column: $table.isScheduledRest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineIdsCsv => $composableBuilder(
    column: $table.routineIdsCsv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroupsCsv => $composableBuilder(
    column: $table.muscleGroupsCsv,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrainingDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrainingDaysTable> {
  $$TrainingDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get workoutCount => $composableBuilder(
    column: $table.workoutCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setsCompleted => $composableBuilder(
    column: $table.setsCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<double> get volumeKg =>
      $composableBuilder(column: $table.volumeKg, builder: (column) => column);

  GeneratedColumn<int> get trainingSeconds => $composableBuilder(
    column: $table.trainingSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isScheduledRest => $composableBuilder(
    column: $table.isScheduledRest,
    builder: (column) => column,
  );

  GeneratedColumn<String> get routineIdsCsv => $composableBuilder(
    column: $table.routineIdsCsv,
    builder: (column) => column,
  );

  GeneratedColumn<String> get muscleGroupsCsv => $composableBuilder(
    column: $table.muscleGroupsCsv,
    builder: (column) => column,
  );
}

class $$TrainingDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrainingDaysTable,
          TrainingDayRow,
          $$TrainingDaysTableFilterComposer,
          $$TrainingDaysTableOrderingComposer,
          $$TrainingDaysTableAnnotationComposer,
          $$TrainingDaysTableCreateCompanionBuilder,
          $$TrainingDaysTableUpdateCompanionBuilder,
          (
            TrainingDayRow,
            BaseReferences<_$AppDatabase, $TrainingDaysTable, TrainingDayRow>,
          ),
          TrainingDayRow,
          PrefetchHooks Function()
        > {
  $$TrainingDaysTableTableManager(_$AppDatabase db, $TrainingDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrainingDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrainingDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrainingDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> workoutCount = const Value.absent(),
                Value<int> setsCompleted = const Value.absent(),
                Value<double> volumeKg = const Value.absent(),
                Value<int> trainingSeconds = const Value.absent(),
                Value<bool> isScheduledRest = const Value.absent(),
                Value<String> routineIdsCsv = const Value.absent(),
                Value<String> muscleGroupsCsv = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingDaysCompanion(
                userId: userId,
                date: date,
                workoutCount: workoutCount,
                setsCompleted: setsCompleted,
                volumeKg: volumeKg,
                trainingSeconds: trainingSeconds,
                isScheduledRest: isScheduledRest,
                routineIdsCsv: routineIdsCsv,
                muscleGroupsCsv: muscleGroupsCsv,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required DateTime date,
                Value<int> workoutCount = const Value.absent(),
                Value<int> setsCompleted = const Value.absent(),
                Value<double> volumeKg = const Value.absent(),
                Value<int> trainingSeconds = const Value.absent(),
                Value<bool> isScheduledRest = const Value.absent(),
                Value<String> routineIdsCsv = const Value.absent(),
                Value<String> muscleGroupsCsv = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrainingDaysCompanion.insert(
                userId: userId,
                date: date,
                workoutCount: workoutCount,
                setsCompleted: setsCompleted,
                volumeKg: volumeKg,
                trainingSeconds: trainingSeconds,
                isScheduledRest: isScheduledRest,
                routineIdsCsv: routineIdsCsv,
                muscleGroupsCsv: muscleGroupsCsv,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrainingDaysTable, TrainingDayRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TrainingDaysTable,
                    TrainingDayRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrainingDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrainingDaysTable,
      TrainingDayRow,
      $$TrainingDaysTableFilterComposer,
      $$TrainingDaysTableOrderingComposer,
      $$TrainingDaysTableAnnotationComposer,
      $$TrainingDaysTableCreateCompanionBuilder,
      $$TrainingDaysTableUpdateCompanionBuilder,
      (
        TrainingDayRow,
        BaseReferences<_$AppDatabase, $TrainingDaysTable, TrainingDayRow>,
      ),
      TrainingDayRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$XpTransactionsTableTableManager get xpTransactions =>
      $$XpTransactionsTableTableManager(_db, _db.xpTransactions);
  $$WorkoutRoutinesTableTableManager get workoutRoutines =>
      $$WorkoutRoutinesTableTableManager(_db, _db.workoutRoutines);
  $$RoutineExercisesTableTableManager get routineExercises =>
      $$RoutineExercisesTableTableManager(_db, _db.routineExercises);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(_db, _db.workoutSessions);
  $$SessionExercisesTableTableManager get sessionExercises =>
      $$SessionExercisesTableTableManager(_db, _db.sessionExercises);
  $$SessionSetsTableTableManager get sessionSets =>
      $$SessionSetsTableTableManager(_db, _db.sessionSets);
  $$ScheduleEntriesTableTableManager get scheduleEntries =>
      $$ScheduleEntriesTableTableManager(_db, _db.scheduleEntries);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$UserAchievementsTableTableManager get userAchievements =>
      $$UserAchievementsTableTableManager(_db, _db.userAchievements);
  $$BadgesTableTableManager get badges =>
      $$BadgesTableTableManager(_db, _db.badges);
  $$UserBadgesTableTableManager get userBadges =>
      $$UserBadgesTableTableManager(_db, _db.userBadges);
  $$ChallengesTableTableManager get challenges =>
      $$ChallengesTableTableManager(_db, _db.challenges);
  $$ChallengeProgressTableTableManager get challengeProgress =>
      $$ChallengeProgressTableTableManager(_db, _db.challengeProgress);
  $$SpotifyAccountsTableTableManager get spotifyAccounts =>
      $$SpotifyAccountsTableTableManager(_db, _db.spotifyAccounts);
  $$TrainingDaysTableTableManager get trainingDays =>
      $$TrainingDaysTableTableManager(_db, _db.trainingDays);
}
