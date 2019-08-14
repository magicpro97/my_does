import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_does/screens/base/background_widget.dart';
import 'package:my_does/screens/home/home.dart';

class InputScreen extends StatefulWidget {
  static String routeAddName = '/AddScreen';
  static String routeEditName = '/EditScreen';

  final List<Map<String, dynamic>> todos;
  final int index;
  final String title;

  InputScreen({this.title, this.todos, this.index});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _dateFormat = DateFormat('dd-MM-yyyy');
  final _timeFormat = DateFormat("HH:mm");

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  var _todo;

  @override
  void initState() {
    _todo = widget.index == null
        ? {
      'id': (widget.todos.length).toString(),
    }
        : widget.todos[widget.index];
    _titleController.text = _todo['title'] ?? '';
    _descriptionController.text = _todo['description'] ?? '';
    _dateController.text = _todo['date'] != null
        ? _todo['date']
        : _dateFormat.format(DateTime.now());
    _timeController.text = _todo['time'] != null
        ? _todo['time']
        : _timeFormat.format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        top: _inputTile(),
        bottom: _input(context),
      ),
    );
  }

  Widget _inputTile() {
    return Center(
        child: Text(
          this.widget.title,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ));
  }

  Widget _input(BuildContext context) {
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
                  format: _dateFormat,
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
                  format: _timeFormat,
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
                      _todo['title'] = _titleController.text;
                      _todo['description'] = _titleController.text;
                      _todo['date'] = _dateController.text;
                      _todo['time'] = _timeController.text;
                      if (widget.index == null) {
                        widget.todos.add(_todo);
                      }
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          HomeScreen.routeName,
                              (Route<dynamic> route) => false);
                    },
                    child: Text(
                      widget.index == null ? 'Create Now' : 'Update',
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
}
