import 'package:flutter/material.dart';

class ConnectedDeviceScreen extends StatelessWidget {
  final String deviceStatus;
  final List<String> receivedMessages;

  ConnectedDeviceScreen({required this.deviceStatus, required this.receivedMessages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connected Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Device Status: $deviceStatus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Received Messages:',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: receivedMessages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(receivedMessages[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}