import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/features/home/home_page.dart';
import 'package:my_does/features/input/bloc/bloc.dart';
import 'package:my_does/features/input/tag_field.dart';
import 'package:my_does/utils/date_time_utils.dart';
import 'package:provider/provider.dart';

class InputPage extends StatefulWidget {
  static String routeAddName = '/AddScreen';
  static String routeEditName = '/EditScreen';

  final Note note;

  InputPage({this.note});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  FocusNode descriptionNote;

  @override
  void initState() {
    super.initState();
    descriptionNote = FocusNode();
  }

  @override
  void dispose() {
    Provider.of<InputBloc>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MoorDatabase>(context);
    final inputBloc = Provider.of<InputBloc>(context);
    inputBloc.noteDao = db.noteDao;
    if (!_isCreateFrom()) {
      inputBloc.changeTitle(widget.note.title);
      inputBloc.changeDescription(widget.note.description);
      inputBloc.changeDate(widget.note.date);
      inputBloc.changeTime(widget.note.time);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: _inputTile(),
      ),
      body: BlocBuilder(
        bloc: inputBloc,
        builder: (context, state) =>
            Builder(
              builder: (BuildContext context) =>
                  Stack(children: <Widget>[
                    Container(
                      height: 180,
                      width: double.infinity,
                      color: Colors.blue[900],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: _inputBody(context),
                    )
                  ]),
            ),
      ),
    );
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

  Widget _inputBody(BuildContext context) =>
      Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildTitleField(),
                _buildDescriptionField(),
                _buildTagField(),
                _buildDateField(),
                _buildTimeField(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () => submitFormAction(),
                      child: Text(
                        _isCreateFrom() ? 'Create' : 'Update',
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

  Padding _buildDescriptionField() {
    final inputBloc = Provider.of<InputBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: StreamBuilder<String>(
          stream: inputBloc.description,
          builder: (context, snapshot) {
            return TextFormField(
              focusNode: descriptionNote,
              initialValue: snapshot.data,
              minLines: 1,
              maxLines: 3,
              maxLength: 255,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'How to?',
                prefixIcon: Icon(Icons.note),
              ),
              onSaved: inputBloc.changeDescription,
              onChanged: inputBloc.changeDescription,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
            );
          }),
    );
  }

  Padding _buildTitleField() {
    final inputBloc = Provider.of<InputBloc>(context);
    final titleNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<String>(
          stream: inputBloc.title,
          builder: (context, snapshot) {
            return TextFormField(
              focusNode: titleNode,
              initialValue: snapshot.data,
              maxLength: 20,
              textInputAction: TextInputAction.next,
              onSaved: inputBloc.changeTitle,
              onChanged: inputBloc.changeTitle,
              onFieldSubmitted: (_) {
                titleNode.unfocus();
                FocusScope.of(context).requestFocus(descriptionNote);
              },
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: 'Title*',
                helperText: 'What you do?',
                prefixIcon: Icon(Icons.edit),
                errorText: snapshot.error,
              ),
            );
          }),
    );
  }

  Widget _buildTimeField() {
    final inputBloc = Provider.of<InputBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: StreamBuilder<String>(
          stream: inputBloc.timeString,
          builder: (context, snapshot) {
            return DateTimeField(
              format: DateTimeUtils.timeFormat,
              initialValue: DateTime.now(),
              decoration: InputDecoration(
                labelText: 'Time',
                hintText: 'What time?',
                prefixIcon: Icon(Icons.timer),
                errorText: snapshot.error,
              ),
              onChanged: inputBloc.changeTime,
              onShowPicker:
                  (BuildContext context, DateTime currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.convert(time);
              },
            );
          }),
    );
  }

  Widget _buildDateField() {
    final inputBloc = Provider.of<InputBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: StreamBuilder<String>(
          stream: inputBloc.dateString,
          builder: (context, snapshot) {
            return DateTimeField(
              format: DateTimeUtils.dateFormat,
              initialValue: DateTime.now(),
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'When will?',
                prefixIcon: Icon(Icons.date_range),
                errorText: snapshot.error,
              ),
              onShowPicker: (BuildContext context, DateTime currentValue) {
                return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
              },
            );
          }),
    );
  }

  void submitFormAction() {
    final inputBloc = Provider.of<InputBloc>(context);

    if (_isCreateFrom()) {
      inputBloc.dispatch(InsertNote());
    } else {
      inputBloc.dispatch(UpdateNote(note: widget.note));
    }
    Navigator.pushNamedAndRemoveUntil(
        context, HomePage.routeName, (Route<dynamic> route) => false);
  }

  bool _isCreateFrom() {
    return widget.note == null ? true : false;
  }

  Widget _buildTagField() => TagField();
}
