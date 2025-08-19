import '../../../core/utils/typedef.dart';
import '../entities/profile_entity.dart';

abstract class IProfileRepo {
  ResultFuture<List<ProfileEntity>> getProfileFromDatasource();
}
