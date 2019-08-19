import 'package:flutter/material.dart';

class NoteCardItem extends StatefulWidget {
  final Key key;
  final String title;
  final String description;
  final String date;
  final String time;
  final Color tagColor;

  NoteCardItem({
    this.key,
    this.title,
    this.description,
    this.date,
    this.time,
    this.tagColor,
  }) : super(key: key);

  @override
  _NoteCardItemState createState() => _NoteCardItemState();
}

class _NoteCardItemState extends State<NoteCardItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      margin: EdgeInsets.only(bottom: 16.0),
      constraints: BoxConstraints(
        minHeight: 100.0,
      ),
      child: Card(
        elevation: 6.0,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 12.0,
                  bottom: 12.0,
                  right: 8.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '${widget.title}',
                        style: TextStyle(color: Colors.blue[900], fontSize: 26),
                      ),
                    ),
                    Text(
                      '${widget.description}',
                      style: TextStyle(color: Colors.black12, fontSize: 18),
                      maxLines: 5,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.lens,
                      color: Colors.red,
                    ),
                    Text(
                      '${widget.date}',
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${widget.time}',
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
