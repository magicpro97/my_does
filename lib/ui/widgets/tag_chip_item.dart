import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_does/data/repositories/local/db.dart';

class TagChipItem extends StatelessWidget {
  final Tag tag;
  final Function onDeleted;

  TagChipItem({this.tag, this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Color(tag.color),
      deleteIcon: Icon(Icons.remove),
      deleteIconColor: Colors.white,
      onDeleted: () => onDeleted(),
      label: Text(
        tag.name,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
