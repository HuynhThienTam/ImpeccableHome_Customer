import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/utils/color_themes.dart';
void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: oceanBlueColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: SizedBox(
          width:  MediaQuery.of(context).size.width*(3/4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                
              ),
            ],
          ),
        ),
      ),
  );
}
 String formatDateToDisplay(DateTime pickedDate) {
    return "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
  }

  String formatTimeToDisplay(DateTime pickedTime) {
    return "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
  }
DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
  final now = DateTime.now(); // Get the current date
  return DateTime(
    now.year,
    now.month,
    now.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}
 String formatWorkingTime(DateTime workingDay) {
    // Helper function to get the day name
    String _getDayName(int weekday) {
      const dayNames = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ];
      return dayNames[weekday - 1]; // weekdays are 1-based in DateTime
    }

    // Helper function to get the month name
    String _getMonthName(int month) {
      const monthNames = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec"
      ];
      return monthNames[month - 1]; // months are 1-based in DateTime
    }

    // Format the workingDay
    return "${_getDayName(workingDay.weekday)}-${workingDay.day.toString().padLeft(2, '0')} ${_getMonthName(workingDay.month)} ${workingDay.year}";
  }