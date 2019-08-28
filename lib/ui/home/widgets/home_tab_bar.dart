import 'package:flutter/material.dart';
import 'package:my_does/data/repositories/local/db.dart';

class HomeTabBar extends StatelessWidget {
  final List<Tag> tags;
  final TabController tabController;

  const HomeTabBar({
    Key key,
    this.tags,
    @required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      unselectedLabelColor: Colors.white.withOpacity(0.3),
      indicatorColor: Colors.white,
      tabs: <Tab>[
        ...tags.map((tag) => Tab(
              child: Text(tag.name),
              icon: Icon(
                Icons.lens,
                color: Color(tag.color),
              ),
            )),
      ],
    );
  }
}
