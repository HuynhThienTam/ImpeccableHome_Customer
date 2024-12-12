import 'package:flutter/material.dart';
import 'package:impeccablehome_customer/model/notification_model.dart';

class NotificationDetailScreen extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailScreen({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notification.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the content of the notification
            Text(
              notification.content,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            // You can add more details or interactions here as needed
          ],
        ),
      ),
    );
  }
}
