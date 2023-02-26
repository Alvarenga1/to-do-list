import 'dart:io';

import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat.yMMMd(defaultLocale);
final String defaultLocale = Platform.localeName;

const String hiveTaskBox = "hiveTaskBox";

//Routes
const String taskRoute = "/task";
const String todayRoute = "/today";
const String upcomingRoute = "/upcoming";
