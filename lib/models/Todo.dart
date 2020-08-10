import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String name;
  final bool done;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final DocumentReference reference;

  Todo.fromMap(Map<String, dynamic> map, {this.reference})
    : name = map['name'],
      done = map['done'],
      createdAt = map['createdAt'],
      updatedAt = map['updatedAt'];
  
  Todo.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);
}