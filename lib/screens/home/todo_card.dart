import 'package:flutter/material.dart';

class TodoCardWidget extends StatelessWidget {
  final Key key;
  final String title;
  final String description;
  final String date;
  final String time;

  TodoCardWidget({this.key, this.title, this.description, this.date, this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8.0,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        '$title',
                        style: TextStyle(color: Colors.blue[900], fontSize: 26),
                      ),
                    ),
                    Text(
                      '$description',
                      style: TextStyle(color: Colors.black12, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '$date',
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$time',
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
