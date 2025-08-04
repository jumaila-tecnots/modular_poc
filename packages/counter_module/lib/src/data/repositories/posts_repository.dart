import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/main_failure.dart';
import '../../../core/utils/typedef.dart';
import '../../domain/entities/posts_entity.dart';
import '../../domain/repositories/i_post_repo.dart';
import '../datsources/posts_remote_datasource.dart';



@LazySingleton(as: IPostsRepo)
class PostsRepository implements IPostsRepo {

  PostRemoteDataSource remoteDataSource;

  PostsRepository({required this.remoteDataSource});

  @override
  ResultFuture<List<PostEntity>> getPostsFromDatasource() async {
    try {
      final result = await remoteDataSource.getPosts();

      return result.fold(
            (failure) {
          // Return failure if there's an error (Left case)
          return Left(failure);
        },
            (posts) {
          // Return the list of posts if the request is successful (Right case)
          return Right(posts);
        },
      );
    } on APIException catch (e) {
      return Left(MainFailure.serverFailure(message: e.message));
    } catch (_) {
      return Left(MainFailure.unexpectedFailure());
    }
  }
}


