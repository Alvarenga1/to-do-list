import 'package:flutter/material.dart';

class DrawerWrapper extends StatelessWidget {
  const DrawerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(child: Text("Header")),
          ListTile(
            title: const Text("Today"),
            leading: const Icon(Icons.today),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Upcoming"),
            leading: const Icon(Icons.upcoming),
            onTap: () {},
          ),
          ListTile(
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {}),
          ListTile(
              title: const Text("About"),
              leading: const Icon(Icons.info),
              onTap: () {}),
        ],
      ),
    );
  }
}
