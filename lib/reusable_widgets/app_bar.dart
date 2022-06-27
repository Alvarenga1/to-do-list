import 'package:flutter/material.dart';

class AppBarWrapper extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const AppBarWrapper({
    Key? key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);
  @override
  final Size preferredSize; // default is 56.0
  @override
  AppBarWrapperState createState() => AppBarWrapperState();
}

class AppBarWrapperState extends State<AppBarWrapper> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        titleSpacing: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Text(
              widget.title,
              style: const TextStyle(fontFamily: 'Proxima Nova'),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(icon: const Icon(Icons.light_mode), onPressed: () {}),
        ]));
  }
}
