import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_netease_music/anims/needle_anim.dart';
import 'package:flutter_netease_music/anims/record_anim.dart';
import 'package:flutter_netease_music/player_page.dart';
import 'dart:ui';

String coverArt =
        'http://p1.music.126.net/8VXjgbrubTdmKqmQdcdK2Q==/79164837212619.jpg?param=300x300',
    mp3Url =
        'http://m10.music.126.net/20190717113315/2856e4286279810a7e534edb407a2ff4/ymusic/54a0/f8f5/9656/0854385f57b68a56b8408d96f93c5c71.mp3';

class MusicPlayerExample extends StatefulWidget {
  Map arguments;
  MusicPlayerExample({this.arguments});


  @override
  State<StatefulWidget> createState() {
    return new _MusicPlayerExampleState(arguments: this.arguments);
  }
}

class _MusicPlayerExampleState extends State<MusicPlayerExample>
    with TickerProviderStateMixin {
  AnimationController controller_record;
  Animation<double> animation_record;
  Animation<double> animation_needle;
  AnimationController controller_needle;
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);

  final GlobalKey<PlayerState> musicPlayerKey = new GlobalKey();

  Map arguments;
  _MusicPlayerExampleState({this.arguments});

  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation_needle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(this.arguments["coverArt"]),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                Colors.black54,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        new Container(
            child: new BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Opacity(
            opacity: 0.6,
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
          ),
        )),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Container(
              child: Text(
                this.arguments['title'],
                style: new TextStyle(fontSize: 13.0),
              ),
            ),
          ),
          body: new Stack(
            alignment: const FractionalOffset(0.5, 0.0),
            children: <Widget>[
              new Stack(
                alignment: const FractionalOffset(0.7, 0.1),
                children: <Widget>[
                  new Container(
                    child: RotateRecord(
                        animation: _commonTween.animate(controller_record)),
                    margin: EdgeInsets.only(top: 100.0),
                  ),
                  new Container(
                    child: new PivotTransition(
                      turns: _rotateTween.animate(controller_needle),
                      alignment: FractionalOffset.topLeft,
                      child: new Container(
                        width: 100.0,
                        child: new Image.asset("images/play_needle.png"),
                      ),
                    ),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: new Player(
                  onError: (e) {
                    Scaffold.of(context).showSnackBar(
                      new SnackBar(
                        content: new Text(e),
                      ),
                    );
                  },
                  onPrevious: () {},
                  onNext: () {},
                  onCompleted: () {},
                  onPlaying: (isPlaying) {
                    if (isPlaying) {
                      controller_record.forward();
                      controller_needle.forward();
                    } else {
                      controller_record.stop(canceled: false);
                      controller_needle.reverse();
                    }
                  },
                  key: musicPlayerKey,
                  color: Colors.white,
                  audioUrl: this.arguments['mp3Url'],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller_record.dispose();
    controller_needle.dispose();
    super.dispose();
  }
}
