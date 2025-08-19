import 'package:injectable/injectable.dart';

import '../../../core/usecase/usecase.dart';
import '../../../core/utils/typedef.dart';
import '../entities/profile_entity.dart';
import '../repositories/i_profile_repo.dart';

@injectable
class ProfileUseCase implements UsecaseWithoutParams<List<ProfileEntity>> {
  final IProfileRepo postsRepo;

  ProfileUseCase({required this.postsRepo});

  @override
  ResultFuture<List<ProfileEntity>> call() async {
    final posts = await postsRepo.getProfileFromDatasource();

    return posts;
  }
}
