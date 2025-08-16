import 'package:dartz/dartz.dart';
import 'package:profile_module/core/failure/failure.dart';
import 'package:profile_module/src/domain/entities/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserEntity>>> getUserProfile();
}