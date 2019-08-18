import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_does/data/models/note.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/utils/date_time_utils.dart';
import 'package:uuid/uuid.dart';

class InputScreen extends StatefulWidget {
  static String routeAddName = '/AddScreen';
  static String routeEditName = '/EditScreen';

  final Note note;

  InputScreen({this.note});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  Note _note;

  @override
  void initState() {
    _note = widget.note ?? Note(id: Uuid().v1().toString());
    _titleController.text = _note.title ?? '';
    _descriptionController.text = _note.description ?? '';
    _dateController.text = _note.date != null
        ? DateTimeUtils.dateToString(_note.date)
        : DateTimeUtils.dateFormat.format(DateTime.now());
    _timeController.text = _note.time != null
        ? DateTimeUtils.timeToString(_note.time)
        : DateTimeUtils.timeFormat.format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
          Container(
              height: 220,
              color: Colors.blue[900],
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: _inputTile(),
              )),
          Container(
            margin: const EdgeInsets.only(top: 150),
            child: _input(),
          )
        ]));
  }

  Widget _inputTile() {
    return Center(
        child: Text(
          _note.title,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ));
  }

  Widget _input() {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: 'Add Title',
                      hintText: 'What you do?',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'How to?',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DateTimeField(
                  format: DateTimeUtils.dateFormat,
                  controller: _dateController,
                  decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'When will?',
                      border: OutlineInputBorder()),
                  onShowPicker:
                      (BuildContext context, DateTime currentValue) async {
                    return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DateTimeField(
                  format: DateTimeUtils.timeFormat,
                  controller: _timeController,
                  decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'What time?',
                      border: OutlineInputBorder()),
                  onShowPicker:
                      (BuildContext context, DateTime currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      _note.title = _titleController.text;
                      _note.description = _titleController.text;
                      _note.date =
                          DateTimeUtils.dateFormat.parse(_dateController.text);
                      _note.time =
                          DateTimeUtils.timeFormat.parse(_timeController.text);
                      if (_isCreateFrom()) {
                        _addNewNoteAction(_note);
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
                              (Route<dynamic> route) => false);
                    },
                    child: Text(
                      _isCreateFrom() ? 'Create Now' : 'Update',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Colors.pink,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isCreateFrom() {
    return widget.note == null ? false : true;
  }

  void _addNewNoteAction(Note note) {}
}
