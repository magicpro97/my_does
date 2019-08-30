import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/features/input/widgets/input_tag_dialog.dart';
import 'package:my_does/features/input/widgets/tag_chip_item.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc.dart';

class TagField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tagDao = Provider.of<MoorDatabase>(context).tagDao;
    final inputBloc = Provider.of<InputBloc>(context);
    inputBloc.tagDao = tagDao;
    Future(() => inputBloc.dispatch(InitialPage()));

    return BlocBuilder(
      bloc: inputBloc,
      builder: (context, state) {
        if (state is InitialTagFieldState) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 150,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: StreamBuilder<List<Tag>>(
                                stream: state.listTagStream,
                                builder: (context, snapshot) {
                                  List<Tag> tags;

                                  if (snapshot.hasData) {
                                    tags = snapshot.data;
                                  } else {
                                    tags = [];
                                  }

                                  final List<DropdownMenuItem<Tag>> tagItems =
                                  tags
                                      .map((tag) =>
                                      DropdownMenuItem<Tag>(
                                        value: tag,
                                        child: TagChipItem(
                                          tag: tag,
                                          onDeleted: () =>
                                              _deleteTagAction(tag,
                                                  context, inputBloc),
                                        ),
                                      ))
                                      .toList();

                                  return DropdownButton<Tag>(
                                    items: tagItems,
                                    value: inputBloc.tag ?? tags.first,
                                    onChanged: (item) {
                                      print(item);
                                      inputBloc.dispatch(SelectedTagChange(
                                          selectedItem: item));
                                    },
                                  );
                                })),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: RaisedButton(
                        color: Colors.blue[900],
                        onPressed: () => _buildCreateNewTagDialog(context),
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                Text('Select your tag'),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  void _buildCreateNewTagDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => InputTagDialog(
        isCreateDialog: true,
      ),
    );
  }

  void _deleteTagAction(Tag tag, BuildContext context, InputBloc inputBloc) {
    inputBloc.dispatch(DeleteTag(tag: tag));
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () => inputBloc.dispatch(InsertTag(tag: tag)))));
  }
}
