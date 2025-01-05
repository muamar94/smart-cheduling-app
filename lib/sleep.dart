// sleep.dart

import 'package:flutter/material.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({super.key});

  @override
  State<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  List<SleepRecord> sleepRecords = [];

  @override
  void initState() {
    super.initState();
    _getDataSource();
  }

  void _getDataSource() {
    sleepRecords = <SleepRecord>[
      SleepRecord(
        bedtime: DateTime(2024, 10, 28, 22, 0, 0),
        wakeUpTime: DateTime(2024, 10, 29, 6, 30, 0),
      ),
      SleepRecord(
        bedtime: DateTime(2024, 10, 29, 23, 30, 0),
        wakeUpTime: DateTime(2024, 10, 30, 7, 0, 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
      ),
      body: ListView.builder(
        itemCount: sleepRecords.length,
        itemBuilder: (context, index) {
          final record = sleepRecords[index];
          return SleepRecordItem(record: record);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Sleep Record page
          Navigator.pushNamed(context, '/addSleepRecord');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SleepRecordItem extends StatelessWidget {
  final SleepRecord record;

  const SleepRecordItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Slept from ${record.bedtime.toLocal()}'
                .split(' ')[1]
                .substring(0, 5) +
            ' to ${record.wakeUpTime.toLocal()}'.split(' ')[1].substring(0, 5)),
        subtitle: Text('Duration: ${record.duration.inHours} hours '
            '${record.duration.inMinutes.remainder(60)} minutes'),
      ),
    );
  }
}

class SleepRecord {
  SleepRecord({required this.bedtime, required this.wakeUpTime});

  DateTime bedtime;
  DateTime wakeUpTime;

  Duration get duration => wakeUpTime.difference(bedtime);
}
