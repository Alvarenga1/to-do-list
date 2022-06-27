import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class AppBarWrapper extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
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

class AppBarWrapperState extends ConsumerState<AppBarWrapper> {
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
          IconButton(
              icon: ref.watch(MyApp.themeProvider)
                  ? const Icon(Icons.dark_mode)
                  : const Icon(Icons.light_mode),
              onPressed: () {
                ref.read(MyApp.themeProvider.notifier).state =
                    !ref.read(MyApp.themeProvider);
              }),
        ]));
  }
}
