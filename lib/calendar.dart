// calendar.dart

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Meeting> meetings = <Meeting>[]; // List to store events/appointments

  @override
  void initState() {
    super.initState();
    // Initialize some sample appointments/events
    _getDataSource();
  }

  void _getDataSource() {
    meetings = <Meeting>[
      Meeting(
        eventName: 'Meeting',
        from: DateTime(2024, 10, 29, 9, 0, 0),
        to: DateTime(2024, 10, 29, 10, 0, 0),
        background: Colors.lightBlue,
        isAllDay: false,
      ),
      Meeting(
        eventName: 'Workshop',
        from: DateTime(2024, 10, 30, 11, 0, 0),
        to: DateTime(2024, 10, 30, 12, 30, 0),
        background: Colors.orange,
        isAllDay: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month, // You can change the view (day, week, etc.)
        dataSource: MeetingDataSource(meetings), // Use your data source
        // Add more properties to customize the calendar
        // e.g., initialDisplayDate, firstDayOfWeek, etc.
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add/Edit Event page
          Navigator.pushNamed(context, '/addEvent');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// A data source class for the calendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

// A class to represent an appointment/event
class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
  });

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
