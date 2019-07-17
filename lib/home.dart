import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {
  List _data = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('widget build');

    getmusicRankings() {
      Dio dio = new Dio();
      dio
          .get(
        'https://api.apiopen.top/musicRankings',
      )
          .then((res) {
        setState(() {
          this._data = res.data['result'];
        });
      });
      // print(res.data);
    }

    getmusicRankings();

    return Column(
      children: <Widget>[
        Container(
            height: 450,
            child: ListView(
              children: this
                  ._data
                  .map((item) => Container(
                        child: Column(
                          children: <Widget>[
                            // Text(item["content"][0]["title"]),
                            // Image.network(item["content"][0]["pic_big"]),
                            Listener(
                              onPointerDown: (e) {
                                print(item["content"][0]["title"]);

                                Dio dio = new Dio();
                                dio.get('https://api.apiopen.top/searchMusic',
                                    queryParameters: {
                                      "name": item["content"][0]["title"]
                                    }).then((res) => {
                                      print(res.data["result"][0]["title"]),
                                      Navigator.pushNamed(context, '/music',
                                          arguments: {
                                            'coverArt': res.data["result"][0]
                                                ["pic"],
                                                'mp3Url': res.data["result"][0]
                                                ["url"],
                                                'title':res.data["result"][0]
                                                ["title"]
                                          })
                                    });
                              },
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Text(item["content"][0]["title"]),
                                    Image.network(
                                        item["content"][0]["pic_big"]),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ))
      ],
    );
  }
}
