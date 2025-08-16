import 'package:dartz/dartz.dart';
import 'package:profile_module/core/failure/failure.dart';
import 'package:profile_module/src/data/datasources/users_datasource.dart';
import 'package:profile_module/src/domain/entities/user_entity.dart';
import 'package:profile_module/src/domain/repositories/users_repository.dart';

class UserRepositoryImpl implements UsersRepository {
  final UsersDataSource dataSource;
  const UserRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getUserProfile() async {
    return await dataSource.getUsers();
  }

}