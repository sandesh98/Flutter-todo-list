import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/Todo.dart';
import 'package:todo/providers/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Mijn todo\'s'),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () async {
            final auth = Provider.of(context).auth;
            auth.logout();
          },
        ),
      ),
      body: _buildBody(context, _name)
    );
  }
}

Widget _buildBody(BuildContext context, String _name) {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final db = Firestore.instance;

  void addTodo() async {
    final form = formKey.currentState;
    form.save();

    try {
      final uid = await Provider.of(context).auth.getCurrentUID();
      await db.collection("userData")
        .document(uid)
        .collection("todo")
        .add({
          'name': _name,
          'done': false
        })
        .then((_) => form.reset());
    } catch (e) {
      print('Oeps..');
    }
  }

  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            Text('30 todo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Zoek op naam of locatie',
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10, 
                      vertical: 7
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide.none
                    )
                  ),
                  onSaved: (value) => _name = value,
                  validator: (value) {
                    if(value.isEmpty) {
                      return 'Please enter some text';
                    }

                    return null;
                  },
                ),
              ),
              IconButton(
                iconSize: 28.0,
                icon: Icon(
                  Icons.add,
                  color: Colors.white
                ),
                onPressed: addTodo
              )
            ],
          ),
        ),
      ),

      Expanded(
        child: StreamBuilder<QuerySnapshot>(
          stream: getUsersTodos(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return _buildList(context, snapshot.data.documents);
          }
        )
      )
    ],
  );
}

Stream<QuerySnapshot> getUsersTodos(BuildContext context) async* {
  final uid = await Provider.of(context).auth.getCurrentUID();
  yield* Firestore.instance.collection("userData").document(uid).collection("todo").snapshots();
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  var todo = Todo.fromSnapshot(data);

  return Dismissible(
      key: Key(data.documentID),
      background: Container(color: Colors.blue),
      onDismissed: (direction) async {
        final uid = await Provider.of(context).auth.getCurrentUID();
        Firestore.instance.collection("userData")
          .document(uid)
          .collection('todo')
          .document(data.documentID)
          .delete();
      },
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(todo.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                ),
              ),
              subtitle: Text('Gemaakt op: 27-07-2020 | Nummer 1',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0
                ),
              ),
              trailing: IconButton(
                iconSize: 32,
                icon: Icon(
                  todo.done?Icons.check_box:Icons.check_box_outline_blank
                ),
                onPressed: () {
                  Firestore.instance.runTransaction((transaction) async {
                    DocumentSnapshot freshSnapshot = await transaction.get(todo.reference);
                    await transaction.update(freshSnapshot.reference, {
                      'done': !todo.done
                    });
                  });
                },
              ),
            ),
          )
        ],
      ),
    ),
  );

}