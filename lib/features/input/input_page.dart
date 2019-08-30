import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/features/home/home_page.dart';
import 'package:my_does/features/input/bloc/bloc.dart';
import 'package:my_does/features/input/tag_field.dart';
import 'package:my_does/features/input/widgets/tag_chip_item.dart';
import 'package:my_does/utils/date_time_utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class InputPage extends StatefulWidget {
  static String routeAddName = '/AddScreen';
  static String routeEditName = '/EditScreen';

  final Note note;

  InputPage({this.note});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  String title;
  String description;
  String date;
  String time;
  GlobalKey<FormState> formKey;
  bool autoValidate;
  TagChipItem tagChipItem;
  FocusNode descriptionNote;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    autoValidate = false;
    descriptionNote = FocusNode();
    if (widget.note == null) {
      title = '';
      description = '';
      date = DateTimeUtils.dateToString(DateTime.now());
      time = DateTimeUtils.timeToString(DateTime.now());
    } else {
      final note = widget.note;
      title = note.title;
      description = note.description;
      date = DateTimeUtils.dateToString(note.date);
      time = DateTimeUtils.timeToString(note.time);
    }
    tagChipItem = TagChipItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputBloc = Provider.of<InputBloc>(context);

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
                        child: _inputBody(context, state),
                      )
                    ]),
              ),
        ));
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

  Widget _inputBody(BuildContext context, InputState state) =>
      Container(
        height: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidate: autoValidate,
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
                        onPressed: () => submitFormAction(context),
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
        ),
      );

  Padding _buildDescriptionField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: TextFormField(
        focusNode: descriptionNote,
        initialValue: description,
        minLines: 1,
        maxLines: 3,
        maxLength: 255,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Description',
          hintText: 'How to?',
          prefixIcon: Icon(Icons.note),
        ),
        onSaved: (String value) => description = value,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }

  Padding _buildTitleField() {
    final titleNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        focusNode: titleNode,
        initialValue: title,
        validator: (String value) => _validateTitle(value),
        maxLength: 20,
        textInputAction: TextInputAction.next,
        onSaved: (String value) => title = value,
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
        ),
      ),
    );
  }

  String _validateTitle(String value) {
    if (value.isEmpty) {
      return 'Please type something for your title!';
    }
    return null;
  }

  Widget _buildTimeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: DateTimeField(
        format: DateTimeUtils.timeFormat,
        initialValue: DateTimeUtils.timeFormat.parse(time),
        validator: (DateTime value) => _validateTime(value),
        decoration: InputDecoration(
          labelText: 'Time',
          hintText: 'What time?',
          prefixIcon: Icon(Icons.timer),
        ),
        onShowPicker: (BuildContext context, DateTime currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: DateTimeField(
        validator: (DateTime value) => _validateDate(value),
        format: DateTimeUtils.dateFormat,
        initialValue: DateTimeUtils.dateFormat.parse(date),
        decoration: InputDecoration(
          labelText: 'Date',
          hintText: 'When will?',
          prefixIcon: Icon(Icons.date_range),
        ),
        onShowPicker: (BuildContext context, DateTime currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
        },
      ),
    );
  }

  void submitFormAction(BuildContext context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final noteDao = Provider
          .of<MoorDatabase>(context)
          .noteDao;
      final _note = Note(
        id: widget.note != null ? widget.note.id : Uuid().v1(),
        title: title,
        description: description,
        date: DateTimeUtils.dateFormat.parse(date),
        time: DateTimeUtils.timeFormat.parse(time),
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
          context, HomePage.routeName, (Route<dynamic> route) => false);
    } else {
      setState(() => autoValidate = true);
    }
  }

  bool _isCreateFrom() {
    return widget.note == null ? true : false;
  }

  String _validateDate(DateTime value) {
    try {
      DateTimeUtils.dateToString(value);
    } catch (Exception) {
      return 'Wrong date format. Should be dd-MM-yy';
    }
    return null;
  }

  String _validateTime(DateTime value) {
    try {
      DateTimeUtils.timeToString(value);
    } catch (Exception) {
      return 'Wrong time format. Should be hh:mm';
    }
    return null;
  }

  Widget _buildTagField() => TagField();
}
