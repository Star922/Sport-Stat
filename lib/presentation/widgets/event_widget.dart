import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:smartforce_test/data/model/event.dart';

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
