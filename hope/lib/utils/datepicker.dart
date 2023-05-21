import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

Future pickDate(context) async {
  return await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.single
    ),
    dialogSize: const Size(325, 400),
    borderRadius: BorderRadius.circular(15)
  );
}