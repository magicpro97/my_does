import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';

class TagForm extends StatelessWidget {
  final String title;

  TagForm({this.title});

  @override
  Widget build(BuildContext context) {
    String tagName;
    Color color;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.blue[900]),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            )),
        Divider(),
        _buildTagForm(tagName, context, color),
      ],
    );
  }

  Widget _buildTagForm(String tagName, BuildContext context, Color color) {
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
              child: Icon(
                Icons.color_lens,
                color: Colors.white,
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.pink),
            ),
            onTap: () => showDialog(
              context: context,
              builder: (context) => _buildColorPickerDialog(color, context),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildColorPickerDialog(Color color, BuildContext context) {
    return AlertDialog(
      title: Text('Choose your color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: Colors.red,
          onColorChanged: (value) {
            color = value;
          },
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
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
