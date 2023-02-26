import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/screens/task_controller.dart';
import 'package:to_do_list/services/navigation_service.dart';
import 'package:to_do_list/services/router.dart';
import 'package:to_do_list/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationSupportDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TaskAdapter());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  static bool isDarkMode = false;
  static var themeProvider = StateProvider((_) => isDarkMode, name: "theme");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Tasks',
      navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider) ? darkTheme : lightTheme,
      onGenerateRoute: ScreenRouter.generateRoute,
      home: const TaskScreen(
        screenType: Screen.task,
      ),
    );
  }
}
