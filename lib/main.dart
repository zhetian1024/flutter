import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app_test/tabs.dart';
import 'routers.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'hwq',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
