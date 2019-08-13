import 'package:flutter/material.dart';
import 'package:my_does/screens/base/background_widget.dart';

class InputScreen extends StatelessWidget {
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
      style: TextStyle(fontSize: 20, color: Colors.white),
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
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'When will?',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'What time?',
                      border: OutlineInputBorder()),
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
