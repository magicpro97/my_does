import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget top;
  final Widget bottom;

  BackgroundWidget({this.top, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(height: 200, color: Colors.blue[900], child: this.top),
      Container(
        margin: EdgeInsets.only(top: 150),
        child: this.bottom,
      )
    ]);
  }
}
