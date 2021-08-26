part of 'my_bloc.dart';

abstract class MyEvent extends Equatable {
  const MyEvent();

  @override
  List<Object> get props => [];
}

class LoadEventsEvent extends MyEvent {
  final int limit;

  LoadEventsEvent(this.limit);
}

class LoadNextEventsEvent extends MyEvent {
  final int limit;

  LoadNextEventsEvent(this.limit);
}
