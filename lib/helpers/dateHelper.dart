import 'package:flutter/material.dart';

import 'genericHelper.dart';

String getDateTimeString(DateTime dayOfTheYear) {
  String result = '${dayOfTheYear.year}-';
  result += padString(dayOfTheYear.month.toString(), 2);
  result += '-';
  result += padString(dayOfTheYear.day.toString(), 2);
  return result;
}
