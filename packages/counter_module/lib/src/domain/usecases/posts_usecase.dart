import 'package:injectable/injectable.dart';


import '../../../core/usecase/usecase.dart';
import '../../../core/utils/typedef.dart';
import '../entities/posts_entity.dart';
import '../repositories/i_post_repo.dart';


@injectable
class PostsUseCase implements UsecaseWithoutParams<List<PostEntity>>{

final IPostsRepo postsRepo;

PostsUseCase({required this.postsRepo});

  @override
  ResultFuture<List<PostEntity>> call() async{
    final posts = await postsRepo.getPostsFromDatasource();

    return posts;
  }
}