import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smartforce_test/core/usecase/usecase.dart';
import 'package:smartforce_test/data/model/event.dart';
import 'package:smartforce_test/data/source/event_source.dart';
import 'package:smartforce_test/domain/usecase/get_event_usecase.dart';
import 'package:smartforce_test/domain/usecase/load_next_events_usecase.dart';

part 'my_event.dart';
part 'my_state.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc(this.getEventUseCase, this.loadNextEventsUseCase) : super(MyInitial());

  final GetEventUseCase getEventUseCase;
  final LoadNextEventsUseCase loadNextEventsUseCase;

  @override
  Stream<MyState> mapEventToState(
    MyEvent event,
  ) async* {
    if (event is LoadEventsEvent) {
      yield MyLoadingState();
      final eventsOrFail = await getEventUseCase(event.limit);

      yield* eventsOrFail.fold((error) async* {
        yield EventsFailedState(error.message);
      }, (events) async* {
        yield EventsLoadedState(events);
      });
    }
    if (event is LoadNextEventsEvent) {
      final eventsOrFail = await loadNextEventsUseCase(event.limit);
      yield* eventsOrFail.fold((error) async* {
        yield EventsFailedState(error.message);
      }, (events) async* {
        yield EventsLoadedState(events);
      });
    }
  }
}
