//@dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartforce_test/injection.dart' as di;
import 'package:smartforce_test/presentation/blocs/bloc/my_bloc.dart';
import 'package:smartforce_test/presentation/pages/event_page.dart';

final GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyBloc>()..add(LoadEventsEvent(2)),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
              textTheme: TextTheme()),
          home: EventPage()),
    );
  }
}
