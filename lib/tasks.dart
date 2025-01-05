// tasks.dart

import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = []; // List to store tasks

  @override
  void initState() {
    super.initState();
    // Initialize with some sample tasks (replace with your actual data)
    _getDataSource();
  }

  void _getDataSource() {
    tasks = <Task>[
      Task(
        title: 'Grocery Shopping',
        description: 'Buy milk, eggs, bread, and cheese from the supermarket.',
        deadline: DateTime(2024, 11, 2),
        isCompleted: false,
      ),
      Task(
        title: 'Finish Project Report',
        description: 'Complete the report for the ongoing project.',
        deadline: DateTime(2024, 11, 5),
        isCompleted: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskItem(
            task: task,
            onCompleted: (value) {
              setState(() {
                task.isCompleted = value;
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add/Edit Task page
          Navigator.pushNamed(context, '/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onCompleted;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onCompleted(value!),
        ),
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Text(
          'Deadline: ${task.deadline.toLocal()}'.split(' ')[0],
        ),
      ),
    );
  }
}

class Task {
  Task({
    required this.title,
    required this.description,
    required this.deadline,
    required this.isCompleted,
  });

  String title;
  String description;
  DateTime deadline;
  bool isCompleted;
}
