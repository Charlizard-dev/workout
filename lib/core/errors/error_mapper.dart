import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'failures.dart';

/// Converts any thrown object into a sanitized [Failure].
Failure _failureFrom(Object error, {String? fallback}) {
  if (error is Failure) return error;
  if (error is DioException) {
    return switch (error.type) {
      DioExceptionType.connectionError ||
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const NetworkFailure(),
      _ => switch (error.response?.statusCode) {
          401 || 403 => const AuthFailure(),
          404 => const NotFoundFailure(),
          _ => ServerFailure(fallback ?? const ServerFailure().message),
        },
    };
  }
  // Drift wraps sqlite errors in its own exceptions.
  if (error.toString().contains('SqliteException')) {
    return CacheFailure(fallback ?? const CacheFailure().message);
  }
  return UnexpectedFailure(fallback ?? const UnexpectedFailure().message);
}

/// Runs [body] and maps any thrown error to a typed [Failure] on the Left
/// side of an [Either]. Keeps datasource/repository code free of try/catch
/// noise.
Future<Either<Failure, T>> guard<T>(Future<T> Function() body, {String? fallback}) async {
  try {
    return Right(await body());
  } on Failure catch (f) {
    return Left(f);
  } catch (error) {
    return Left(_failureFrom(error, fallback: fallback));
  }
}

/// Synchronous variant of [guard].
Either<Failure, T> guardSync<T>(T Function() body, {String? fallback}) {
  try {
    return Right(body());
  } on Failure catch (f) {
    return Left(f);
  } catch (error) {
    return Left(_failureFrom(error, fallback: fallback));
  }
}
