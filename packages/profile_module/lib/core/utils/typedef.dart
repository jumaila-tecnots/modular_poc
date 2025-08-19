import 'package:dartz/dartz.dart';

import '../error/main_failure.dart';




// typedef ResultFuture<T> =Future<Either<MainFailure,T>>;
// typedef ResultVoid =ResultFuture<void>;
//
// typedef DataMap=Map<String,dynamic>;




// A type alias for Future that returns Either<MainFailure, T>, where T is any type
typedef ResultFuture<T> = Future<Either<MainFailure, T>>;

// A type alias for a Future that returns either failure or no result (void)
typedef ResultVoid = Future<Either<MainFailure, Unit>>; // Use 'Unit' instead of 'void'

// A type alias for a map of string keys and dynamic values
typedef DataMap = Map<String, dynamic>;
