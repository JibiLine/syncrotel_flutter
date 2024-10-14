import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final DateTime selectedDay;

  const CalendarDay({super.key, 
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    var days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(5),
      },
      children: [
        TableRow(
          children: [
            const TableCell(
              child: Text(
                'Heure',
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
              child: Text(
                '${days[selectedDay.weekday]} - ${selectedDay.day}/${selectedDay.month}/${selectedDay.year}',
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
                  '${i}h - ${i}h59',
                  textAlign: TextAlign.center,
                ),
              ),
              const TableCell(child: Text('x', textAlign: TextAlign.center)),
            ],
          ),
      ],
    );
  }
}