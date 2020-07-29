import 'package:flutter/material.dart';
import 'package:todo/providers/provider.dart';
import 'package:todo/services/auth_service.dart';
import 'package:todo/views/home_screen.dart';
import 'package:todo/views/login_screen.dart';

import 'package:todo/views/register_screen.dart';

void main() => runApp(Todo());

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFFF3B00),
        ),
        home: HomeController(),
        initialRoute: '/',
        routes: {
          
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    return StreamBuilder(
      stream: auth.onAuthStateChanged,  
      builder: (context, AsyncSnapshot<String> snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
           return signedIn ? HomeScreen() : RegisterScreen();
        }

        return CircularProgressIndicator();
      },
    );
  }
}