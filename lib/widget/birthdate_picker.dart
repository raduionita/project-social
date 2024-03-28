import 'package:flutter/material.dart';

Future<DateTime?> showBirthDatePicker({required BuildContext context, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) {
  final now = DateTime.now();
  return showDatePicker(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      cancelText: "",
      confirmText: "done",
      helpText: "Enter your birth date",
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1900, 01, 01), // DateTime(now.year - 100, now.month, now.day),
      lastDate: lastDate ?? DateTime(now.year - 18, now.month, now.day),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year);
}
