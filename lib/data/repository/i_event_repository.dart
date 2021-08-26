import 'package:smartforce_test/core/network/network_info.dart';
import 'package:smartforce_test/data/model/event.dart';
import 'package:smartforce_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smartforce_test/data/source/event_source.dart';
import 'package:smartforce_test/domain/repository/event_repository.dart';

class IEventRepository extends EventRepository {
  final EventSource eventSource;
  final NetworkInfo networkInfo;

  IEventRepository(this.eventSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    if (await networkInfo.isConncected) {
      try {
        final events = await eventSource.getEvents();
        return Right(events);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getNextEvents() async {
    if (await networkInfo.isConncected) {
      try {
        final events = await eventSource.loadMoreEvents();
        return Right(events);
      } catch (error) {
        return Left(ServerFailure(error.toString()));
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
