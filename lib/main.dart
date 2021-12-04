import 'package:festipoche/screens/public/login.dart';
import 'package:festipoche/screens/public/register.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginPage(),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => RegisterPage(),
        '/login': (BuildContext context) => LoginPage(),
      },
      initialRoute: '/register',
    );
  }
}

