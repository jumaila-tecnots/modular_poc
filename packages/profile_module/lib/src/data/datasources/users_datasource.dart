import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:profile_module/core/failure/failure.dart';
import 'package:profile_module/core/network/user_service.dart';
import 'package:profile_module/src/domain/entities/user_entity.dart';

class UsersDataSource {
  final UserService userService;
  const UsersDataSource(this.userService);

  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final res = await userService.getUsers();
      return Right(res);
    } on DioException catch(e) {
      return Left(NetworkFailure(e.message ??"Something went wrong"));
    } catch(e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}