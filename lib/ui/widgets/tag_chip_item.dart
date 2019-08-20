import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_does/data/repositories/local/db.dart';

class TagChipItem extends StatelessWidget {
  final Tag tag;
  final Function onDelete;

  TagChipItem({this.tag, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Color(tag.color),
      deleteIcon: Icon(Icons.remove),
      deleteIconColor: Colors.white,
      onDeleted: () => onDelete,
      label: Text(tag.name),
    );
  }
}
