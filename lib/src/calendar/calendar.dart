import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncrotel/src/calendar/calendar_day.dart';
import 'package:syncrotel/src/calendar/calendar_week.dart';
import 'package:syncrotel/src/calendar/calendar_month.dart';


class Calendar extends StatefulWidget {
  const Calendar(this.prefs, {super.key});
  final SharedPreferences prefs;

  @override
  _CalendarState createState() => _CalendarState(prefs);
}

class _CalendarState extends State<Calendar> {
  _CalendarState(this.prefs);
  final SharedPreferences prefs;
  int formatSelected = 2;
  final List<String> calendarFormat = ['Journée', 'Semaine', 'Mois'];

  void changeFormat(int newFormat) {
    // Update the format_selected using the new_format value
    setState(() {
      formatSelected = newFormat;
    });
  }

  void changeSelectedDay(DateTime newSelectedDay) {
    // Update the selectedDay using the new_selectedDay value
    setState(() {
      prefs.setString('selectedDay', newSelectedDay.toIso8601String());
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = prefs.get('selectedDay') == null ? DateTime.now() : DateTime.parse(prefs.get('selectedDay').toString());
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children:[
                Text("Affichage calendrier : format ${calendarFormat[formatSelected]}_${selectedDay.year}/${selectedDay.month}"),
                Table(
                  children: [
                    TableRow(
                      children: [
                        for (int i = 0;i<calendarFormat.length;i++)
                          TableCell(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: formatSelected == i ? Colors.blue : Colors.grey,
                              ),
                              onPressed: (){changeFormat(i);},
                              child: Text(calendarFormat[i]),
                            ),
                          ),
                      ],
                    )
                  ]
                ),
              ]
            ),
          ]
        ),
        if (formatSelected == 0)
          CalendarDay(selectedDay: selectedDay,)
        else if (formatSelected == 1)
          CalendarWeek(selectedDay: selectedDay,)
        else
          CalendarMonth(
            selectedDay: selectedDay,
            prefs: prefs,
            changeSelectedDay: changeSelectedDay,
          )
      ]
    );
  }
}