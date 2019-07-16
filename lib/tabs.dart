import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home.dart';
import 'feilei.dart';
import 'shezhi.dart';

class Tabs extends StatefulWidget {
  @override
  _Tabs createState() {
    // TODO: implement createState
    return _Tabs();
  }
}

class _Tabs extends State<Tabs> {
 List pages=[Home(),Feilei(),Shezhi()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text("分类")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("设置")),
        ],
        currentIndex: this._currentIndex,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
          });
        },
      ),
    );
    ;
  }
}
