import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Music extends StatefulWidget{
  @override
  _Music createState() {
    // TODO: implement createState
    return _Music();
  }
}
class _Music extends State<Music>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("音乐播放器"),
      ),
    );
  }
}