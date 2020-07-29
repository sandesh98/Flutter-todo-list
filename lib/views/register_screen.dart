import 'package:flutter/material.dart';
import 'package:todo/providers/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _name, _email, _password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submit() async {
    final form = formKey.currentState;
    form.save();

    try {
      final auth = Provider.of(context).auth;
      String uid = await auth.registerUser(_email, _password, _name);
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
                  Text('Account maken',
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
                          hintText: 'Naam',
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
                        onSaved: (value) => _name = value,
                      ),
                    ),

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
                              child: Text('Account maken',
                                style: TextStyle(
                                  fontFamily: 'Rubik',
                                  fontSize: 20.0
                                ),
                              ),
                            )
                          ),
                          FlatButton(
                            child: Text('Ik heb al een account.',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
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