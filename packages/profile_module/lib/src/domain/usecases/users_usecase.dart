import 'package:dartz/dartz.dart';
import 'package:profile_module/core/failure/failure.dart';
import 'package:profile_module/core/usecase/usecase.dart';
import 'package:profile_module/src/domain/repositories/users_repository.dart';

class UsersUsecase implements UseCase {
  final UsersRepository userRepository;
  const UsersUsecase(this.userRepository);

  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await userRepository.getUserProfile();
  }

}