import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:to_do_list/constants.dart';
import 'package:to_do_list/services/navigation_service.dart';

class DrawerWrapper extends StatelessWidget {
  const DrawerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 160,
            child: DrawerHeader(child: Container()),
          ),
          ListTile(
            title: const Text("Tasks"),
            leading: const Icon(Icons.check),
            onTap: () async {
              await NavigationService.pushReplacementNamed(taskRoute);
            },
          ),
          ListTile(
            title: const Text("Today"),
            leading: const Icon(Icons.today),
            onTap: () async {
              await NavigationService.pushReplacementNamed(todayRoute);
            },
          ),
          ListTile(
            title: const Text("Upcoming"),
            leading: const Icon(Icons.upcoming),
            onTap: () async {
              await NavigationService.pushReplacementNamed(upcomingRoute);
            },
          ),
          Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            IconButton(
                onPressed: () {}, icon: FaIcon(FontAwesomeIcons.linkedin)),
            IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.github)),
            IconButton(onPressed: () {}, icon: Icon(Icons.email)),
          ]),
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 13.0, left: 13.0),
              child: Text("Created by Renan Alvarenga,\nLicensed under MIT"),
            )
          ]),
        ],
      ),
    );
  }
}
