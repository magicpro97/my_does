import 'package:flutter/material.dart';
import 'package:my_does/features/input/widgets/tag_form.dart';

class InputTagDialog extends StatefulWidget {
  final bool isCreateDialog;

  InputTagDialog({Key key, this.isCreateDialog}) : super(key: key);

  @override
  _InputTagDialogState createState() => _InputTagDialogState();
}

class _InputTagDialogState extends State<InputTagDialog> {
  @override
  void initState() {
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
              widget.isCreateDialog ? "Create a new tag" : "Update your tag",
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
    );
  }
}
