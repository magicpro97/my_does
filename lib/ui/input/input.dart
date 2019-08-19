import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/utils/date_time_utils.dart';
import 'package:provider/provider.dart';
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
  var _titleController;
  var _descriptionController;
  var _dateController;
  var _timeController;

  @override
  void initState() {
    final _note = widget.note ??
        Note(
            id: '0',
            title: '',
            description: '',
            date: DateTime.now(),
            time: DateTime.now(),
            createdDate: DateTime.now(),
            updatedDate: DateTime.now());
    _titleController = TextEditingController(text: _note.title);
    _descriptionController = TextEditingController(text: _note.description);
    _dateController =
        TextEditingController(text: DateTimeUtils.dateToString(_note.date));
    _timeController =
        TextEditingController(text: DateTimeUtils.timeToString(_note.time));
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
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          centerTitle: true,
          title: _inputTile(),
        ),
        body: Stack(children: <Widget>[
          Container(
            height: 220,
            width: double.infinity,
            color: Colors.blue[900],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: _input(),
          )
        ]));
  }

  Widget _inputTile() {
    return Text(
      _isCreateFrom() ? "Create a new note" : "Update your note",
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
      ),
    );
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    helperText: 'What you do?',
                    suffixIcon: Icon(Icons.edit),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'How to?',
                    suffixIcon: Icon(Icons.note),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _dateTimeField(),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () => submitFormAction(context),
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

  Widget _dateTimeField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimeField(
              format: DateTimeUtils.dateFormat,
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'When will?',
                prefixIcon: Icon(Icons.date_range),
              ),
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
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimeField(
              format: DateTimeUtils.timeFormat,
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time',
                hintText: 'What time?',
                prefixIcon: Icon(Icons.timer),
              ),
              onShowPicker:
                  (BuildContext context, DateTime currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
            ),
          ),
        ),
      ],
    );
  }

  void submitFormAction(BuildContext context) {
    final noteDao = Provider
        .of<MoorDatabase>(context)
        .noteDao;
    final _note = Note(
      id: widget.note != null ? widget.note.id : Uuid().v1(),
      title: _titleController.text,
      description: _descriptionController.text,
      date: DateTimeUtils.dateFormat.parse(_dateController.text),
      time: DateTimeUtils.timeFormat.parse(_timeController.text),
      createdDate:
      widget.note != null ? widget.note.createdDate : DateTime.now(),
      updatedDate: DateTime.now(),
    );
    if (_isCreateFrom()) {
      noteDao.insertNote(_note);
    } else {
      noteDao.updateNote(_note);
    }
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (Route<dynamic> route) => false);
  }

  bool _isCreateFrom() {
    return widget.note == null ? true : false;
  }
}
