import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/error/main_failure.dart';
import '../../../core/network/network.dart';
import '../../../core/utils/typedef.dart';
import '../../domain/entities/profile_entity.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  ResultFuture<List<ProfileEntity>> getProfile();
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDatasourceImpl implements ProfileRemoteDataSource {
  final NetworkService networkService;

  ProfileRemoteDatasourceImpl({required this.networkService});

  @override
  ResultFuture<List<ProfileEntity>> getProfile() async {
    try {
      final result = await networkService.makeRequest(
        url: ApiEndPoints.baseUrl,
        method: HttpMethod.get,
      );

      return result.fold(
        (failure) {
          // Handle and return known failure
          return Left(failure);
        },
        (success) {
          try {
            final List<dynamic> responseBody = success;
            final List<ProfileEntity> profiles = responseBody
                .map((json) => ProfileModel.fromJson(json))
                .toList();
            return Right(profiles);
          } catch (e) {
            // Error during parsing
            return Left(MainFailure.unexpectedFailure());
          }
        },
      );
    } catch (e) {
      // Catches unexpected errors or exceptions like network timeouts
      return Left(MainFailure.unexpectedFailure());
    }
  }
}
