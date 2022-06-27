import 'package:flutter/material.dart';
import 'package:to_do_list/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  static bool isDarkMode = false;
  static var themeProvider = StateProvider((_) => isDarkMode, name: "theme");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ref.watch(themeProvider) ? darkTheme : lightTheme,
      home: const HomeScreen(),
    );
  }
}
