import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';

class TagForm extends StatefulWidget {
  final String tagName;
  final Color color;

  TagForm({Key key, this.tagName, this.color}) : super(key: key);

  @override
  _TagFormState createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  String tagName;
  Color color;

  @override
  void initState() {
    tagName = widget.tagName;
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: TextField(
              maxLength: 20,
              onSubmitted: (value) {
                tagName = value;
              },
              onChanged: (value) {
                tagName = value;
              },
              decoration: InputDecoration(
                hintText: 'What kind of note?',
              ),
            ),
          ),
          Expanded(
              child: InkWell(
                child: Container(
                  height: 32.0,
                  width: 32.0,
                  child: Icon(
                    Icons.color_lens,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                      gradient: color == null
                          ? SweepGradient(colors: Colors.primaries)
                          : null),
                ),
                onTap: () =>
                    showDialog(
                      context: context,
                      builder: (context) =>
                          _buildColorPickerDialog(color, context),
                    ).then((value) =>
                        setState(() {
                          color = value;
                        })),
              ))
        ],
      ),
    );
  }

  Widget _buildColorPickerDialog(Color color, BuildContext context) {
    void _chooseColorDoneAction(Color color) {
      Navigator.pop(context, color);
    }

    return AlertDialog(
      title: Text('Choose your color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: color,
          onColorChanged: (value) {
            color = value;
          },
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => _chooseColorDoneAction(color),
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue[900],
        )
      ],
    );
  }
}