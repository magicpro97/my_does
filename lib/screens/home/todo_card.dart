import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 8.0,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        'Buy whikas',
                        style:
                        TextStyle(color: Colors.blue[900], fontSize: 26),
                      ),
                    ),
                    Text(
                      'Near market there is cat',
                      style: TextStyle(color: Colors.black12, fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Tomorrow',
                    style: TextStyle(color: Colors.pink[400], fontSize: 16,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}