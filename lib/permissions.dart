import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  bool _calendarPermissionGranted = false;
  bool _notificationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final calendarWriteStatus = await Permission.calendarWriteOnly.status;
    final calendarFullAccessStatus = await Permission.calendarFullAccess.status;
    final notificationStatus = await Permission.notification.status;

    setState(() {
      _calendarPermissionGranted =
          calendarWriteStatus.isGranted || calendarFullAccessStatus.isGranted;
      _notificationPermissionGranted = notificationStatus.isGranted;
    });
  }

  Future<void> _requestCalendarPermission() async {
    await Permission.calendarWriteOnly.request();
    await Permission.calendarFullAccess.request();

    _checkPermissions();
  }

  Future<void> _requestNotificationPermission() async {
    await Permission.notification.request();

    _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // calendar card
            PermissionCard(
              icon: Icons.calendar_today,
              title: 'Calendar',
              description:
                  'Allow access to your calendar to schedule events and tasks.',
              isGranted: _calendarPermissionGranted,
              onTap: () async {
                await _requestCalendarPermission();
                if (mounted && _calendarPermissionGranted) {
                  Navigator.pushReplacementNamed(context, '/calendar');
                }
              },
            ),
            // calendar notification
            const SizedBox(height: 20),
            PermissionCard(
              icon: Icons.notifications,
              title: 'Notifications',
              description:
                  'Enable notifications for reminders and study suggestions.',
              isGranted: _notificationPermissionGranted,
              onTap: _requestNotificationPermission,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed:
                  _calendarPermissionGranted && _notificationPermissionGranted
                      ? () {
                          Navigator.pushReplacementNamed(context, '/calendar');
                        }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isGranted;
  final VoidCallback onTap;

  const PermissionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.isGranted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(description),
                  ],
                ),
              ),
              if (isGranted)
                const Icon(Icons.check_circle, color: Colors.green)
              else
                const Icon(Icons.warning, color: Colors.orange),
            ],
          ),
        ),
      ),
    );
  }
}
