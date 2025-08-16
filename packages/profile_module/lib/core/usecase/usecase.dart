import 'package:dartz/dartz.dart';
import 'package:profile_module/core/failure/failure.dart';

abstract class UseCase<Out, In> {
  Future<Either<Failure, Out>> call(In params);
}

class NoParams {
  const NoParams();
}