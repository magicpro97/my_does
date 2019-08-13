import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  Widget _top;
  Widget _bottom;

  BackgroundWidget(Widget top, Widget bottom) {
    _top = top;
    _bottom = bottom;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(height: 200, color: Colors.blue[900], child: _top),
      Container(
        margin: EdgeInsets.only(top: 150),
        child: _bottom,
      )
    ]);
  }
}
