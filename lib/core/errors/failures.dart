import 'package:equatable/equatable.dart';

/// Base class for all domain failures. Failures carry a human-readable
/// message safe to display in the UI; they never expose raw exceptions.
sealed class Failure extends Equatable {
  const Failure(this.message);

  /// Human-readable, localized-safe message.
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Network unreachable or timed out.
final class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection. Check your network and try again.']);
}

/// Server returned an error or malformed payload.
final class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong on our side. Please try again.']);
}

/// Local database/cache read or write failed.
final class CacheFailure extends Failure {
  const CacheFailure([super.message = 'We couldn\u2019t save your data on this device.']);
}

/// Resource not found (routine, workout, playlist...).
final class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'We couldn\u2019t find what you\u2019re looking for.']);
}

/// Authentication/authorization rejected (Spotify, backend).
final class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed. Please sign in again.']);
}

/// Input validation failed.
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Spotify playback unavailable (no device, no premium, etc.).
final class PlaybackFailure extends Failure {
  const PlaybackFailure(super.message);
}

/// Image generation/export failed.
final class ImageExportFailure extends Failure {
  const ImageExportFailure([super.message = 'We couldn\u2019t generate your share image.']);
}

/// Share/save to gallery failed.
final class ShareFailure extends Failure {
  const ShareFailure(super.message);
}

/// Anything unexpected, already sanitized for display.
final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Something unexpected happened. Please try again.']);
}
