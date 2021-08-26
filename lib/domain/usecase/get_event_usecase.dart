import 'package:smartforce_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:smartforce_test/core/usecase/usecase.dart';
import 'package:smartforce_test/data/model/event.dart';
import 'package:smartforce_test/domain/repository/event_repository.dart';

class GetEventUseCase extends CommonUseCase<List<Event>, int> {
  final EventRepository eventRepository;

  GetEventUseCase(this.eventRepository);
  @override
  Future<Either<Failure, List<Event>>> call(int params) {
    return eventRepository.getEvents();
  }
}
