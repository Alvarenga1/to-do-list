import 'package:flutter/material.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_controller.dart';

import '../constants.dart';

class ScreenRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case taskRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TaskScreen(
                  screenType: Screen.task,
                ));
      case todayRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TaskScreen(
                  screenType: Screen.today,
                ));
      case upcomingRoute:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const TaskScreen(
                  screenType: Screen.upcoming,
                ));

      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
