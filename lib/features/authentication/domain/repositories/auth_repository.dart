import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

/// Local-first auth contract. Credentials live in the on-device database
/// (salted SHA-256); the session id lives in secure storage. A remote
/// backend later only needs to re-implement this interface.
abstract class AuthRepository {
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User?>> currentUser(String? userId);
  Future<Either<Failure, User>> updateProfile({String? name, String? photoPath});
  Future<void> logout();
}
