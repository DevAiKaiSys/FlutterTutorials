import 'package:fpdart/fpdart.dart';
import 'package:repository_layer/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}
