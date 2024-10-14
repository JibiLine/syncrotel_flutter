import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CalendarMonth extends StatefulWidget {
  const CalendarMonth({super.key, required this.selectedDay, required this.prefs, required this.changeSelectedDay});

  final Function changeSelectedDay;
  final DateTime selectedDay;
  final SharedPreferences prefs;

  @override
  _CalendarMonthState createState() => _CalendarMonthState(selectedDay, prefs, changeSelectedDay);

}



class _CalendarMonthState extends State<CalendarMonth> {
  _CalendarMonthState(this.selectedDay, this.prefs, this.changeSelectedDay);
  final Function changeSelectedDay;
  DateTime selectedDay;
  final SharedPreferences prefs;
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<int> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

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
      border: const TableBorder(
        horizontalInside: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1.0,
        ),
        verticalInside: BorderSide(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey[200],
          ),
          children: [
            for (var day in days)
              TableCell(
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        for (var i = 0; i < 6; i++)
          TableRow(
            children: [
              for (int j = 0; j < 7; j++)
                TableCell(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        selectedDay == _getDay(i, j, firstDayOfMonth, daysInMonth, daysInPreviousMonth) ? Colors.blue 
                        : i%2 == 0 ? (Colors.grey[200] ?? Colors.grey) 
                        : Colors.white,
                      ),
                    ),
                    onPressed: () {
                      changeSelectedDay(_getDay(i, j, firstDayOfMonth, daysInMonth, daysInPreviousMonth));
                      setState(() {
                        selectedDay = _getDay(i, j, firstDayOfMonth, daysInMonth, daysInPreviousMonth);
                      });
                    }, 
                    child: Text(
                      _getDay(i, j, firstDayOfMonth, daysInMonth, daysInPreviousMonth).day.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _getDayColor(i, j, firstDayOfMonth, daysInMonth),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  DateTime _getDay(int row, int column, int firstDayOfMonth, int daysInMonth, int daysInPreviousMonth) {
    int dayNumber = row * 7 + column - firstDayOfMonth + 2;
    if (dayNumber > 0 && dayNumber <= daysInMonth) {
      return DateTime(selectedDay.year, selectedDay.month, dayNumber);
    } else if (dayNumber <= 0) {
      return DateTime(selectedDay.year, selectedDay.month - 1, daysInPreviousMonth + dayNumber);
    } else {
      return DateTime(selectedDay.year, selectedDay.month + 1, dayNumber - daysInMonth);
    }
  }

  Color _getDayColor(int row, int column, int firstDayOfMonth, int daysInMonth) {
    int dayNumber = row * 7 + column - firstDayOfMonth + 2;
    if (dayNumber > 0 && dayNumber <= daysInMonth) {
      return Colors.black;
    } else {
      return Colors.grey;
    }
  }
}