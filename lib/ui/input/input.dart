import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:my_does/data/models/todo.dart';
import 'package:my_does/ui/home/home.dart';
import 'package:my_does/utils/date_time_utils.dart';

class InputScreen extends StatefulWidget {
  static String routeAddName = '/AddScreen';
  static String routeEditName = '/EditScreen';

  final List<Todo> todoList;
  final int index;
  final String title;

  InputScreen({this.title, this.todoList, this.index});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  Todo _todo;

  @override
  void initState() {
    _todo = widget.index == null
        ? Todo(id: widget.todoList.length.toString(), title: '')
        : widget.todoList[widget.index];
    _titleController.text = _todo.title ?? '';
    _descriptionController.text = _todo.description ?? '';
    _dateController.text = _todo.date != null
        ? DateTimeUtils.dateToString(_todo.date)
        : DateTimeUtils.dateFormat.format(DateTime.now());
    _timeController.text = _todo.time != null
        ? DateTimeUtils.timeToString(_todo.time)
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
          this.widget.title,
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
                      _todo.title = _titleController.text;
                      _todo.description = _titleController.text;
                      _todo.date =
                          DateTimeUtils.dateFormat.parse(_dateController.text);
                      _todo.time =
                          DateTimeUtils.timeFormat.parse(_timeController.text);
                      if (widget.index == null) {
                        widget.todoList.add(_todo);
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
