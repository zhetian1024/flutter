import 'tabs.dart';
import 'package:flutter/material.dart';
import 'musicPlayer.dart';

final routes = {'/': (context) => Tabs(), '/music': (context) => Music()};

var onGenerateRoute = (RouteSettings settinge) {
  final String name = settinge.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settinge.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settinge.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
