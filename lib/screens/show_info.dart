import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  final String title, description, beginTime, endTime;
  InfoView({this.title, this.description, this.beginTime, this.endTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close_rounded),
              ),
              Text("delete", style: TextStyle(color: Colors.red))
            ],
          ),
          SizedBox(height: 20),
          Text(
            title == "" ? "(No Title)" : title,
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          viewTile(icon: Icons.calendar_today, text: "Friday, 13 Aug, 2021"),
          viewTile(
              icon: Icons.notifications_none, text: "$beginTime - $endTime"),
          description == ""
              ? SizedBox()
              : viewTile(icon: Icons.comment_outlined, text: description)
        ],
      ),
    ));
  }

  Widget viewTile({IconData icon, String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 20),
          Flexible(
            child: Text(text),
          )
        ],
      ),
    );
  }
}
