import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';


import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/error/main_failure.dart';
import '../../../../core/network/network.dart';
import '../../../core/utils/typedef.dart';
import '../../domain/entities/posts_entity.dart';
import '../models/post_model.dart';


abstract class PostRemoteDataSource{
ResultFuture<List<PostEntity>> getPosts();
}



@LazySingleton(as: PostRemoteDataSource)
class PostRemoteDatasourceImpl implements PostRemoteDataSource {
  final NetworkService networkService;

  PostRemoteDatasourceImpl({required this.networkService});

  @override
  ResultFuture<List<PostEntity>> getPosts() async {
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
            final List<PostEntity> posts = responseBody
                .map((json) => PostModel.fromJson(json))
                .toList();
            return Right(posts);
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
