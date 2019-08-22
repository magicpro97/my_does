import 'package:flutter/material.dart';
import 'package:my_does/data/repositories/local/db.dart';
import 'package:my_does/ui/widgets/input_tag_dialog.dart';
import 'package:my_does/ui/widgets/tag_chip_item.dart';
import 'package:provider/provider.dart';

class TagField extends StatefulWidget {
  TagField({Key key}) : super(key: key);

  @override
  _TagFieldState createState() => _TagFieldState();
}

class _TagFieldState extends State<TagField> {
  TagChipItem tagChipItem;

  @override
  void initState() {
    tagChipItem = TagChipItem(
      tag: null,
      onDeleted: null,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tagDao = Provider.of<MoorDatabase>(context).tagDao;
    List<Tag> tags;
    List<DropdownMenuItem<TagChipItem>> tagChipItems;

    return StreamBuilder<List<Tag>>(
        stream: tagDao.watchTags(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            tags = snapshot.data;
            tagChipItems = tags
                .map((tag) => DropdownMenuItem<TagChipItem>(
                      child: TagChipItem(
                        tag: tag,
                        onDeleted: () => _deleteTagAction(tag, context),
                      ),
                    ))
                .toList();
            tagChipItem = tagChipItems.first.value;
          } else {
            tagChipItems = [];
          }

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
                          child: DropdownButton<TagChipItem>(
                            items: tagChipItems,
                            value: tagChipItem,
                            onChanged: (newTag) {
                              setState(() {
                                tagChipItem = newTag;
                                print(newTag);
                                print(tagChipItem);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: RaisedButton(
                        color: Colors.blue[900],
                        onPressed: () => _buildCreateNewTagDialog(),
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
        });
  }

  void _buildCreateNewTagDialog() {
    showDialog(
      context: context,
      builder: (context) => InputTagDialog(
        isCreateDialog: true,
      ),
    );
  }

  void _deleteTagAction(Tag tag, BuildContext context) {
    final tagDao = Provider.of<MoorDatabase>(context).tagDao;
    setState(() {});
    tagDao.deleteTag(tag);
    Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Deleted'),
        action: SnackBarAction(
            label: 'Undo', onPressed: () => tagDao.insertTag(tag))));
  }
}
