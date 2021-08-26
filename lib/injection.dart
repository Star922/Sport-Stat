import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:smartforce_test/data/repository/i_event_repository.dart';
import 'package:smartforce_test/data/source/event_source.dart';
import 'package:smartforce_test/domain/repository/event_repository.dart';
import 'package:smartforce_test/domain/usecase/get_event_usecase.dart';
import 'package:smartforce_test/domain/usecase/load_next_events_usecase.dart';
import 'package:smartforce_test/presentation/blocs/bloc/my_bloc.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => MyBloc(sl(), sl()));

  sl.registerLazySingleton(() => GetEventUseCase(sl()));

  sl.registerLazySingleton(() => LoadNextEventsUseCase(sl()));

  sl.registerLazySingleton<EventSource>(() => IEventSource());

  sl.registerLazySingleton<EventRepository>(() => IEventRepository(sl(), sl()));

  sl.registerLazySingleton(() => DataConnectionChecker());

  sl.registerLazySingleton<NetworkInfo>(() => INetworkInfo(sl()));
}
