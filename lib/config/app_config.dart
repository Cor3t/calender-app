import 'package:flutter/material.dart';
import 'data.dart';
import 'template.dart';

class CalendarProvider extends ChangeNotifier {
  DateTime selectedDay;
  DateTime focusedDay = DateTime.now();
  String thisMonth;
  Map<DateTime, List<Data>> events = data;

  CalendarProvider() {
    thisMonth = months[focusedDay.month - 1];
    selectedDay =
        DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day);
  }

  List<Data> getEventsForDay(DateTime day) {
    return events[day];
  }

  void changeSelectedDay(DateTime date) {
    selectedDay = date;

    notifyListeners();
  }

  void changeFocusedDay(DateTime date) {
    focusedDay = date;
    notifyListeners();
  }

  void changeMonth(DateTime date) {
    thisMonth = months[date.month - 1];
    notifyListeners();
  }

  void addEvent(DateTime date, List<Data> _data) {
    if (events.containsKey(date)) {
      events[date].add(_data[0]);
    } else {
      events[date] = _data;
    }
    notifyListeners();
  }
}

class EditProvider extends ChangeNotifier {
  String startTime = "00:00";
  String endTime = "00:00";
  DateTime date;
  bool show = true;

  void changeStartTime(String time) {
    startTime = time;
    notifyListeners();
  }

  void changeEndTime(String time) {
    endTime = time;
    notifyListeners();
  }

  void changeDate(DateTime datetime) {
    date = datetime;
    notifyListeners();
  }

  void showTime() {
    show = !show;
    notifyListeners();
  }
}
