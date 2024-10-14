import 'package:flutter/material.dart';

class CalendarWeek extends StatelessWidget {
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final DateTime selectedDay;
  CalendarWeek({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    int firstDayOfMonth = DateTime(selectedDay.year, selectedDay.month, 1).weekday;
    int daysInMonth = months[selectedDay.month - 1];

    // Adjust for leap year
    if (selectedDay.month == 2 && ((selectedDay.year % 4 == 0 && selectedDay.year % 100 != 0) || (selectedDay.year % 400 == 0))) {
      daysInMonth = 29;
    }

    int daysInPreviousMonth = selectedDay.month == 1 ? months[11] : months[selectedDay.month - 2];
    if (selectedDay.month == 3 && ((selectedDay.year % 4 == 0 && selectedDay.year % 100 != 0) || (selectedDay.year % 400 == 0))) {
      daysInPreviousMonth = 29;
    }

    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          children: [
            const TableCell(
              child: Text(
                '', 
                textAlign: TextAlign.center,
                ),
            ),
            for (int i = 0; i < 7; i++)
              TableCell(
                child: Text(
                  '${days[i]} ${_getDayNumber(selectedDay, i+1, firstDayOfMonth, daysInMonth, daysInPreviousMonth)}',
                  textAlign: TextAlign.center,
                  ),
              ),
          ],
        ),
        for (var i = 0; i < 24; i++)
          TableRow(
            children: [
              TableCell(
                child: Text(
                  '${i}h - ${i}h59 ', 
                  textAlign: TextAlign.end,
                  selectionColor: Colors.grey[200],
                  ),
              ),
              // ignore: unused_local_variable
              for (var day in days) 
                const TableCell(
                  child: Text('x',textAlign: TextAlign.center,),
                ),
            ],
          ),
      ],
    );
  }

  String _getDayNumber(DateTime selectedDay, int dayNumberInWeek, int firstDayOfMonth, int daysInMonth, int daysInPreviousMonth) {
    int dayNumber = dayNumberInWeek - firstDayOfMonth + 1;
    if (dayNumber > 0 && dayNumber <= daysInMonth) {
      return dayNumber.toString();
    } else if (dayNumber <= 0) {
      return (daysInPreviousMonth + dayNumber).toString();
    } else {
      return (dayNumber - daysInMonth).toString();
    }
  }
}