import 'package:flutter/material.dart';

class WeeklyWorkingTimeWidget extends StatelessWidget {
  final List<Map<String, String>> workingTime;

  const WeeklyWorkingTimeWidget({
    Key? key,
    required this.workingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayMapping = {
      'Monday': 'Mon',
      'Tuesday': 'Tue',
      'Wednesday': 'Wed',
      'Thursday': 'Thu',
      'Friday': 'Fri',
      'Saturday': 'Sat',
      'Sunday': 'Sun',
    };
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: daysOfWeek.map((day) {
        // Find matching data for the day
        final dataForDay = workingTime.firstWhere(
          (entry) => dayMapping[entry['day']] == day,
          orElse: () => {},
        );

        // Determine if the day has data
        final hasData = dataForDay.isNotEmpty;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 1),
          margin: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenWidth*(4/25),
                alignment: Alignment.centerLeft,
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:  hasData ? Color(0xFFFFA500) : Color(0xFFC0C0C0),
                  ),
                ),
              ),
              Container(
                width: screenWidth*(1/4),
                child: Text(
                  hasData
                      ? "${dataForDay['startTime']} to ${dataForDay['finishedTime']}"
                      : "Not working",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Example Usage