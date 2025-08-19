import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/main_failure.dart';
import '../../../core/utils/typedef.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/i_profile_repo.dart';
import '../datsources/profile_remote_datasource.dart';

@LazySingleton(as: IProfileRepo)
class ProfileRepository implements IProfileRepo {
  ProfileRemoteDataSource remoteDataSource;

  ProfileRepository({required this.remoteDataSource});

  @override
  ResultFuture<List<ProfileEntity>> getProfileFromDatasource() async {
    try {
      final result = await remoteDataSource.getProfile();

      return result.fold(
        (failure) {
          // Return failure if there's an error (Left case)
          return Left(failure);
        },
        (profiles) {
          // Return the list of profiles if the request is successful (Right case)
          return Right(profiles);
        },
      );
    } on APIException catch (e) {
      return Left(MainFailure.serverFailure(message: e.message));
    } catch (_) {
      return Left(MainFailure.unexpectedFailure());
    }
  }
}
