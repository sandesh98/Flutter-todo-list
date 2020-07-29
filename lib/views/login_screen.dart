import 'package:flutter/material.dart';
import 'package:todo/providers/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submit() async {
    final form = formKey.currentState;
    form.save();

    try {
      final auth = Provider.of(context).auth;
      String uid = await auth.loginUser(_email, _password);
      print(uid);
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Row(
                children: <Widget>[
                  Text('Todo #594',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Inloggen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),

              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none
                          )
                        ),
                        onSaved: (value) => _email = value,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Wachtwoord',
                          filled: true,
                          fillColor: Colors.white,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide.none
                          )
                        ),
                        onSaved: (value) => _password = value,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            onPressed: submit,
                            color: Colors.white,
                            textColor: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 7
                              ),
                              child: Text('Inloggen',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 20.0
                                ),
                              ),
                            )
                          ),
                          FlatButton(
                            child: Text('Ik heb nog geen account.',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        )
      ),
    );
  }
}