import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Data {
  final String id, title, description, beginTime, endTime;
  final Color color;

  Data({
    this.id,
    @required this.title,
    this.description,
    @required this.beginTime,
    this.endTime,
    @required this.color,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      beginTime: json["begin_time"],
      endTime: json["end_time"],
      color: json["color"]);

  Map<String, dynamic> toJson(Data data) => {
        "id": data.id,
        "title": data.title,
        "description": data.description,
      };
}

class Date {
  final String id, date;

  Date({
    this.id,
    this.date,
  });

  factory Date.fromJson(Map<String, dynamic> json) =>
      Date(id: json["id"], date: json["date"]);

  Map<String, dynamic> toJson(Date date) => {"id": date.id, "date": date.date};
}

Map<DateTime, List<Data>> data = {
  DateTime.utc(2021, 7, 21): [
    Data(
        title: "My birthday",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.blue),
    Data(
        title: "My birthday",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "11:00am",
        endTime: "2:00pm",
        color: Colors.blue),
  ],
  DateTime.utc(2021, 7, 29): [
    Data(
        title: "My birthday",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.blue),
    Data(
        title: "My birthday",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.blue),
  ],
  DateTime.utc(2021, 7, 22): [
    Data(
        title: "Work",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.red),
    Data(
        title: "Work",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.red),
  ],
  DateTime.utc(2021, 7, 11): [
    Data(
        title: "Call Mom",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.blue),
  ],
  DateTime.utc(2021, 7, 1): [
    Data(
        title: "My birthday",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.blue),
  ],
  DateTime.utc(2021, 7, 6): [
    Data(
        title: "Bye Shoe",
        description: "I want to celebrate my birthday in jamaiaca",
        beginTime: "12:00pm",
        endTime: "4:00pm",
        color: Colors.yellow),
  ]
};
