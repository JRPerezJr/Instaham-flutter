import 'dart:async';

import 'package:flutter/material.dart';

import 'comments.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instaham',
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Instaham')),
          ),
          body: Post(),
        ));
  }
}

class Post extends StatefulWidget {
  @override
  PostState createState() => new PostState();
}

class PostState extends State<Post> {
  bool liked = false;
  bool showHeartOverlay = false;

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  _doubleTapped() {
    setState(() {
      showHeartOverlay = true;
      liked = true;
      if (showHeartOverlay) {
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            showHeartOverlay = false;
          });
        });
      }
    });
  }

  _commentButtonPressed() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CommentsPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    IconButton heartButton = IconButton(
      iconSize: 35.0,
      icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
          color: liked ? Colors.red : null),
      tooltip: 'Increase volume by 10%',
      onPressed: () => _pressed(),
    );
    IconButton commentButton = IconButton(
      iconSize: 35.0,
      icon: Icon(Icons.chat_bubble_outline, color: Colors.grey),
      onPressed: () => _commentButtonPressed(),
    );
    return Column(
      children: <Widget>[
        PostHeader(),
        GestureDetector(
          onDoubleTap: () => _doubleTapped(),
          child: Stack(alignment: Alignment.center, children: <Widget>[
            Image.asset('images/mtb.jpg'),
            showHeartOverlay
                ? Positioned(
                    child: Opacity(
                        opacity: 0.85,
                        child: new Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 80.0,
                        )))
                : Container()
          ]),
        ),
        ListTile(
            contentPadding: EdgeInsets.all(0.0),
            leading: Row(
              children: <Widget>[
                heartButton,
                commentButton,
              ],
            ))
      ],
    );
  }
}

class PostHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            CircleImage(),
            Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                child: Text(
                  'mteknik',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ));
  }
}

class CircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage('images/mtb.jpg'))),
    );
  }
}
