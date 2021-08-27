// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartforce_test/data/model/event.dart';
import 'package:smartforce_test/main.dart';
import 'package:smartforce_test/presentation/blocs/bloc/my_bloc.dart';
import 'package:smartforce_test/presentation/widgets/event_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_scrollController);
    super.initState();
  }

  void _scrollController() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      BlocProvider.of<MyBloc>(context)..add(LoadNextEventsEvent(2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Southamption",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.blue,
            tabs: [
              Tab(text: "FOR YOU"),
              Tab(text: "TRENDING"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<MyBloc, MyState>(
              builder: (context, state) {
                if (state is EventsFailedState) {
                  return Center(
                    child: Text(state.error),
                  );
                }
                if (state is EventsLoadedState) {
                  final eventList = state.events;
                  return Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: ListView.builder(
                        itemCount: eventList.length,
                        controller: scrollController,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return EventWidget(
                            event: eventList[index],
                          );
                        }),
                  );
                }
                if (state is MyLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              },
            ),
            Container(
              alignment: Alignment.center,
              child: Text("Trending"),
            )
          ],
        ),
      ),
    );
  }
}
