// ignore: import_of_legacy_library_into_null_safe
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartforce_test/data/model/event.dart';
import 'package:smartforce_test/main.dart';
import 'package:smartforce_test/presentation/blocs/bloc/my_bloc.dart';

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

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 2.0,
          spreadRadius: 1.0,
          offset: Offset(0, 0),
        )
      ]),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(event.user.profileURL),
            ),
            trailing: IconButton(
              icon: Icon(Icons.more_horiz_outlined),
              onPressed: () {},
            ),
            title: Text(event.user.name),
            subtitle: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 15.0,
                ),
                Text(event.location)
              ],
            ),
          ),
          Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Carousel(
              dotBgColor: Colors.transparent,
              dotColor: Colors.grey,
              dotSize: 5.0,
              images: event.images.map((e) => NetworkImage(e)).toList(),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              event.date,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.green),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              event.title,
              maxLines: 2,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${event.price}"),
                Text("${event.matchPercent}% Match"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
