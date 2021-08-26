import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartforce_test/data/model/event.dart';
import 'package:smartforce_test/data/model/user.dart';

abstract class EventSource {
  Future<List<Event>> getEvents();

  Future<List<Event>> loadMoreEvents();
}

class IEventSource implements EventSource {
  final firestoreInstance = FirebaseFirestore.instance;
  List<Event> eventList = [];
  List<DocumentSnapshot> documentSnapshotList = [];

  @override
  Future<List<Event>> getEvents() async {
    final cRef = firestoreInstance.collection("events").orderBy("id").limit(2);
    QuerySnapshot snapshot = await cRef.get();
    documentSnapshotList.addAll(snapshot.docs);
    snapshot.docs.forEach((data) {
      Event event = Event(
          id: data['id'],
          title: data['title'],
          date: data['date'],
          images: List.from(data['images']),
          user: User.fromMap(data['postBy']),
          price: data['price'],
          matchPercent: data['matchPercent'],
          location: data['location']);
      eventList.add(event);
    });
    return eventList;
  }

  @override
  Future<List<Event>> loadMoreEvents() async {
    final cRef = firestoreInstance
        .collection("events")
        .orderBy("id")
        .limit(2)
        .startAfterDocument(
            documentSnapshotList[documentSnapshotList.length - 1]);
    QuerySnapshot snapshot = await cRef.get();
    documentSnapshotList.addAll(snapshot.docs);

    snapshot.docs.forEach((data) {
      Event event = Event(
          id: data['id'],
          title: data['title'],
          date: data['date'],
          images: List.from(data['images']),
          user: User.fromMap(data['postBy']),
          price: data['price'],
          matchPercent: data['matchPercent'],
          location: data['location']);
      eventList.add(event);
    });
    return eventList;
  }
}
