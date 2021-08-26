import 'package:dartz/dartz.dart';
import 'package:smartforce_test/core/errors/failure.dart';
import 'package:smartforce_test/data/model/event.dart';

abstract class EventRepository {
  Future<Either<Failure, List<Event>>> getEvents();

  Future<Either<Failure, List<Event>>> getNextEvents();
}
