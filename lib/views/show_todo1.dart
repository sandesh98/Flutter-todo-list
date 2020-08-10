// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/Todo.dart';
// import 'package:intl/intl.dart';

class ShowTodo extends StatelessWidget {

  final Todo todo;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // FirebaseUser user;

  ShowTodo({Key key, @required this.todo}) : super (key: key);

  // @override
  // void initState() {
  //   super.initState();
  //   initUser();
  // }

  // initUser() async {
  //   user = await _auth.currentUser();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.name),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Text('Gemaakt door:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text('Sandesh',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white
              ),
            ),

            SizedBox(height: 20),
            Text('Gemaakt op:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text('jubk',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white
              ),
            ),

            SizedBox(height: 20),
            Text('Todo afgerond:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(todo.done ? 'Ja' : 'Nee',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white
              ),
            ),

            SizedBox(height: 20),
            Text('Todo bewerken:',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(todo.name,
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}