part of 'my_bloc.dart';

class MyState {
  const MyState();
}

class MyInitial extends MyState {}

class MyLoadingState extends MyState {}

class EventsLoadedState extends MyState {
  final List<Event> events;

  EventsLoadedState(this.events);
}

class EventsFailedState extends MyState {
  final String error;

  EventsFailedState(this.error);
}
