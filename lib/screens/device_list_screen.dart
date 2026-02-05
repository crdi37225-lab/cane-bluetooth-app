import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];
  @override
  void initState() {
    super.initState();
    flutterBlue.scan().listen((scanResult) {
      if (!devicesList.contains(scanResult.device)) {
        setState(() {
          devicesList.add(scanResult.device);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Device List'),
      ),
      body: ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devicesList[index].name.isNotEmpty ? devicesList[index].name : 'Unknown device'),
            subtitle: Text(devicesList[index].id.toString()),
            onTap: () async {
              await devicesList[index].connect();
              // Navigate to another screen or show connection status
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Optionally add functionality to stop scanning
        },
        child: Icon(Icons.search),
        tooltip: 'Scan for devices',
      ),
    );
  }
}