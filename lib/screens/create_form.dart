import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeme/config/app_config.dart';
import 'package:skeme/config/data.dart';
import 'package:skeme/config/template.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:provider/provider.dart';

class CreateInfo extends StatefulWidget {
  final DateTime dateTime;
  CreateInfo({this.dateTime});
  _CreateInfoState createState() => _CreateInfoState();
}

class _CreateInfoState extends State<CreateInfo> {
  final DateFormat dateFormat = DateFormat("EEEE, d MMMM yyyy");
  DateTime _date;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  EditProvider editprovider;

  @override
  void initState() {
    super.initState();
    editprovider = Provider.of<EditProvider>(context, listen: false);
    _date = widget.dateTime;
  }

  void upDateEvent() {
    CalendarProvider _calendarProvider =
        Provider.of<CalendarProvider>(context, listen: false);

    List<Data> data = [
      Data(
          title: titleTextController.text,
          description: descriptionTextController.text,
          beginTime: editprovider.startTime,
          endTime: editprovider.endTime,
          color: Colors.blue)
    ];
    _calendarProvider.addEvent(
        DateTime.utc(_date.year, _date.month, _date.day), data);
  }

  Widget _time({String label, String time, Function function}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        GestureDetector(
            onTap: () {
              function(context);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              width: 75,
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5)),
              child: Text(time, style: TextStyle(fontSize: 20)),
            ))
      ],
    );
  }

  showPickerStartTime(BuildContext context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              initValue: int.parse(editprovider.startTime.substring(0, 2)),
              begin: 0,
              end: 24,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }),
          NumberPickerColumn(
              initValue: int.parse(editprovider.startTime.substring(3)),
              begin: 0,
              end: 59,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }),
        ]),
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          var result = value
              .map((element) => element < 10 ? "0$element" : "$element")
              .toList()
              .join(":");
          editprovider.changeStartTime(result);
        }).showDialog(context);
  }

  showPickerEndTime(BuildContext context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
              initValue: int.parse(editprovider.endTime.substring(0, 2)),
              begin: 0,
              end: 24,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }),
          NumberPickerColumn(
              initValue: int.parse(editprovider.endTime.substring(3)),
              begin: 0,
              end: 59,
              onFormatValue: (v) {
                return v < 10 ? "0$v" : "$v";
              }),
        ]),
        hideHeader: true,
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          var result = value
              .map((element) => element < 10 ? "0$element" : "$element")
              .toList()
              .join(":");
          editprovider.changeEndTime(result);
        }).showDialog(context);
  }

  showPickerDate(BuildContext context) {
    Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(
          value: widget.dateTime,
        ),
        title: Text("Select Data"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          editprovider
              .changeDate((picker.adapter as DateTimePickerAdapter).value);
          _date = editprovider.date;
        }).showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProvider>(builder: (context, edit, child) {
      return Container(
        padding: EdgeInsets.all(15),
        width: screenWidth(context),
        height: screenHeight(context) - 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.cancel),
                Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: Colors.blue[900],
                  ),
                  onPressed: () {
                    upDateEvent();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text("Date and Time", style: boldSubHeading),
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 15),
                        Text("All day"),
                        Spacer(),
                        CupertinoSwitch(
                            activeColor: Colors.blue[900],
                            value: !edit.show,
                            onChanged: (ischanged) {
                              edit.showTime();
                            })
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showPickerDate(context);
                            },
                            child: Text(dateFormat.format(_date)),
                          ),
                          SizedBox(height: 15),
                          Visibility(
                            visible: edit.show,
                            child: Row(
                              children: [
                                _time(
                                  label: "Start Time",
                                  time: edit.startTime,
                                  function: showPickerStartTime,
                                ),
                                Spacer(),
                                _time(
                                  label: "End Time",
                                  time: edit.endTime,
                                  function: showPickerEndTime,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Title", style: boldSubHeading),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5)),
                        child: TextField(
                            controller: titleTextController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write the title"))),
                    SizedBox(height: 10),
                    Text("Note", style: boldSubHeading),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(5)),
                      child: TextField(
                        controller: descriptionTextController,
                        autofocus: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write your important note"),
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
