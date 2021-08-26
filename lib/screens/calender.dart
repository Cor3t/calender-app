import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeme/config/app_config.dart';
import 'package:skeme/config/data.dart';
import 'package:skeme/screens/create_form.dart';
import 'package:skeme/screens/show_info.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:skeme/config/template.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  addSomething() {
    CalendarProvider _calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    List<Data> data = [
      Data(
          title: "Single",
          beginTime: "10:00",
          description: "Do Something",
          endTime: "11:00",
          color: Colors.blue)
    ];
    _calendarProvider.addEvent(DateTime.utc(2021, 8, 18), data);
    print(_calendarProvider.events);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarProvider>(builder: (context, calendar, child) {
      return Scaffold(
        backgroundColor: Color(0xFFE9E9E9),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Scaffold.of(context).showBottomSheet(
                (context) => CreateInfo(dateTime: calendar.selectedDay));
          },
          child: Icon(Icons.add),
        ),
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxHeight > 480) {
            return straightView(
                context: context,
                calendarBuilders: _calendarBuilder(),
                events: calendar.getEventsForDay);
          } else {
            return Container();
          }
        })),
      );
    });
  }

  CalendarBuilders _calendarBuilder() {
    CalendarProvider _calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);
    return CalendarBuilders(
      selectedBuilder: (context, date, _) {
        return Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Text(
                date.day.toString(),
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        );
      },
      todayBuilder: (context, date, _) {
        return Center(
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: Center(
                child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
          ),
        );
      },
      markerBuilder: (context, date, events) {
        if (_calendarProvider.events.isEmpty) {
          return Container();
        } else if (_calendarProvider.events.containsKey(date)) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _calendarProvider.events[date]
                  .map((e) => _marker(e.color))
                  .toList());
        } else {
          return Container();
        }
      },
    );
  }

  Container _marker(Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 9),
      width: 5,
      height: 5,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
    );
  }
}

Widget straightView(
    {BuildContext context,
    CalendarBuilders calendarBuilders,
    Function events}) {
  int _today = DateTime.now().day;
  CalendarProvider _calendarProvider =
      Provider.of<CalendarProvider>(context, listen: false);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          margin: EdgeInsets.only(bottom: 20, left: 19),
          child: RichText(
            text: TextSpan(
                text: _calendarProvider.thisMonth,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: _calendarProvider.focusedDay.year.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  )
                ]),
          )),
      TableCalendar(
        eventLoader: (day) {
          return _calendarProvider.getEventsForDay(day);
        },
        daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date)[0]),
        onPageChanged: (date) {
          _calendarProvider.changeMonth(date);
          _calendarProvider.changeFocusedDay(date);
        },
        calendarStyle: CalendarStyle(
            weekendTextStyle: Theme.of(context).textTheme.bodyText2),
        headerVisible: false,
        calendarBuilders: calendarBuilders,
        onDaySelected: (selectDay, focusedDay) {
          _calendarProvider.changeSelectedDay(selectDay);
          _calendarProvider.changeFocusedDay(focusedDay);
        },
        selectedDayPredicate: (date) {
          return isSameDay(_calendarProvider.selectedDay, date) &&
              (date.day != _today);
        },
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _calendarProvider.focusedDay,
      ),
      SizedBox(height: 20),
      Expanded(
          child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            text: weeks[
                                _calendarProvider.selectedDay.weekday - 1],
                            children: [
                          TextSpan(
                              text:
                                  " ${_calendarProvider.selectedDay.day.toString()}")
                        ])),
                  ),
                  SizedBox(width: 20),
                  Expanded(child: Divider(thickness: 2))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: events(_calendarProvider.selectedDay) != null
                      ? events(_calendarProvider.selectedDay).length
                      : 1,
                  itemBuilder: (context, index) {
                    var info = events(_calendarProvider.selectedDay);
                    return events(_calendarProvider.selectedDay) != null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return InfoView(
                                  title: info[index].title,
                                  description: info[index].description,
                                  beginTime: info[index].beginTime,
                                  endTime: info[index].endTime,
                                );
                              }));
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 10, top: 20),
                                child: Row(
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: "${info[index].beginTime}\n",
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                          TextSpan(text: info[index].endTime)
                                        ])),
                                    SizedBox(width: 25),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            info[index].title != ""
                                                ? info[index].title
                                                : "(No title)",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            info[index].description,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        : Center(
                            child: Container(
                              child: Text('NO EVENT'),
                            ),
                          );
                  }),
            ),
          ],
        ),
      ))
    ],
  );
}
