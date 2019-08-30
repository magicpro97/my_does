import 'package:flutter/material.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/utils/date_time_utils.dart';

class NoteCardItem extends StatefulWidget {
  final Note note;
  final Tag tag;

  NoteCardItem({this.note, this.tag});

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
    final _note = widget.note;
    final _tag = widget.tag;

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
              child: Container(
                color: _tag != null ? Color(_tag.color) : Colors.grey,
              ),
            ),
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 300.0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '${_note.title}',
                          style:
                          TextStyle(color: Colors.blue[900], fontSize: 26),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      width: 300.0,
                      child: Text(
                        '${_note.description}',
                        style: TextStyle(color: Colors.black12, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${DateTimeUtils.dateToString(_note.date)}',
                      style: TextStyle(
                        color: Colors.pink[400],
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${DateTimeUtils.timeToString(_note.time)}',
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
