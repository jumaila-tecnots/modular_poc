

import '../../../core/utils/typedef.dart';
import '../entities/posts_entity.dart';

abstract class IPostsRepo{
  ResultFuture<List<PostEntity >> getPostsFromDatasource();
}