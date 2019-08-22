import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:provider/provider.dart';

class TagForm extends StatefulWidget {
  final Tag tag;

  TagForm({Key key, this.tag}) : super(key: key);

  @override
  _TagFormState createState() => _TagFormState();
}

class _TagFormState extends State<TagForm> {
  String tagName;
  Color color;
  bool isColorPicked;

  @override
  void initState() {
    final tag = widget.tag;
    if (tag != null) {
      tagName = tag.name;
      color = Color(tag.color);
    }
    isColorPicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 115.0,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: TextField(
                minLines: 1,
                maxLength: 10,
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
                            isColorPicked = true;
                          })),
                )),
            Expanded(
              child: RaisedButton(
                color: Colors.blue[900],
                onPressed: () => _submitFormTagAction(widget.tag),
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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

  void _submitFormTagAction(Tag tag) {
    final tagDao = Provider
        .of<MoorDatabase>(context)
        .tagDao;
    if (tag == null) {
      tagDao.insertTag(Tag(
        name: tagName,
        createdDate: DateTime.now(),
        updatedDate: DateTime.now(),
        color: isColorPicked ? color.value : Colors.grey,
      ));
    } else {
      tagDao.updateTag(Tag(
        id: tag.id,
        name: tag.name,
        createdDate: tag.createdDate,
        updatedDate: DateTime.now(),
        color: isColorPicked ? color.value : Colors.grey,
      ));
    }

    Navigator.pop(context);
  }
}
