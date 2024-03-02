import 'package:flutter/material.dart'; // Add import for Material package
import 'package:table_calendar/table_calendar.dart';// Add import for TableCalendar

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  late DateTime selected;
  late DateTime focused;

  @override
  void initState() {

    selected = DateTime(2024, 3, 4);
    focused = DateTime.now();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      // selectedDayPredicate: (day) {
      //   setState(() {
      //     selected = day;
      //   });
      // },
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) {
        return isSameDay(selected, day);
      },

      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          selected = selectedDay;
          focused = focusedDay;
          print(selected);

        });

      },
      onDayLongPressed: (selectedDay, focusedDay) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return  SizedBox(
              height: 200, // Ajustez la hauteur selon vos besoins
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text("Détails de la journée"),
                    Text("uyuyuyuyuu")
                  ],
                ),
              ),
            );
          },
        );
      }

      ,
      onPageChanged: (focusedDay) {
        setState(() {
          focused = focusedDay;
        });

      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blue.shade900,
          shape: BoxShape.circle,
        ),


        todayDecoration: const BoxDecoration(
          color: Colors.cyan,
          shape: BoxShape.circle,
        ),

      ),

      focusedDay: focused,
      firstDay: DateTime(2000,3,1), lastDay: DateTime(2030,12,31),
    );

  }
}
