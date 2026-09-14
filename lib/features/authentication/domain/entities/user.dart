import 'package:equatable/equatable.dart';

/// The single authenticated user of the device. Charlizard is local-first
/// with a single-user model in v1; multi-account support would extend this
/// entity with an account switcher.
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    this.email,
    this.photoUrl,
    this.createdAt,
  });

  final String id;
  final String name;
  final String? email;
  final String? photoUrl;
  final DateTime? createdAt;

  /// Initials for avatar fallback (e.g. "Charly Mars" -> "CM").
  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.runes.first == 0 ? '?' : String.fromCharCode(parts.first.runes.first).toUpperCase();
    }
    final first = String.fromCharCode(parts.first.runes.first);
    final last = String.fromCharCode(parts.last.runes.first);
    return (first + last).toUpperCase();
  }

  User copyWith({String? name, String? email, String? photoUrl}) => User(
        id: id,
        name: name ?? this.name,
        email: email ?? this.email,
        photoUrl: photoUrl ?? this.photoUrl,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [id, name, email, photoUrl, createdAt];
}
