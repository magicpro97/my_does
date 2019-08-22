import 'package:flutter/material.dart';
import 'package:my_does/ui/widgets/tag_form.dart';

class InputTagDialog extends StatefulWidget {
  final String title;

  InputTagDialog({Key key, this.title}) : super(key: key);

  @override
  _InputTagDialogState createState() => _InputTagDialogState();
}

class _InputTagDialogState extends State<InputTagDialog> {
  String tagName;
  Color color;

  @override
  void initState() {
    tagName = '';
    color = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          height: 32.0,
          decoration: BoxDecoration(
            color: Colors.blue[900],
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )),
      contentPadding: EdgeInsets.all(0.0),
      titlePadding: EdgeInsets.all(0.0),
      backgroundColor: Colors.white,
      elevation: 8.0,
      content: TagForm(),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Done",
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }
}
