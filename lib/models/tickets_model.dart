import 'package:cloud_firestore/cloud_firestore.dart';

class Ticket {
  String name;
  String busNumber;
  bool WithAcAndCurtains;
  double price;
  int timestamp;
  List<String> bustops;


  Ticket({
    this.name,
    this.busNumber,
    this.WithAcAndCurtains,
    this.timestamp,
    this.price,
    this.bustops = const [],
  });

  Ticket.fromSnapshot(QueryDocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());

  Ticket.fromMap(dynamic map)
      : name = map['name'],
        busNumber = map['busNumber'],
        WithAcAndCurtains = map['WithAcAndCurtains'],
        price = map['price'],
        bustops = map['bustops'],
        timestamp = map['timestamp'];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['name'] = this.name;
    map['busNumber'] = this.busNumber;
    map['WithAcAndCurtains'] = this.WithAcAndCurtains;
    map['price'] = this.price;
    map['timestamp'] = this.timestamp;
    map['bustops'] = this.bustops;

    return map;
  }
}
