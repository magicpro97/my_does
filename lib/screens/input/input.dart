import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_does/screens/base/background_widget.dart';

class InputScreen extends StatelessWidget {
  static String routeName = 'InputScreen';
  final _dateFormat = DateFormat('dd-MM-yyyy');
  final _timeFormat = DateFormat("HH:mm");
  final String title;

  InputScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        top: _inputTile(),
        bottom: _input(),
      ),
    );
  }

  Widget _inputTile() {
    return Center(
        child: Text(
          this.title,
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
                  decoration: InputDecoration(
                      labelText: 'Add Title',
                      hintText: 'What you do?',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
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
                  decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'When will?',
                      border: OutlineInputBorder()),
                  onShowPicker: (BuildContext context, DateTime currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DateTimeField(
                  decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'What time?',
                      border: OutlineInputBorder()),
                  format: _timeFormat,
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
                    onPressed: () {},
                    child: Text(
                      'Create Now',
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
                  onPressed: () {},
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
