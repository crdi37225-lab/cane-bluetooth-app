import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceListScreen extends StatefulWidget {
  @override
  _DeviceListScreenState createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  @override
  void initState() {
    super.initState();
    flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        setState(() {
          if (!devicesList.contains(r.device)) {
            devicesList.add(r.device);
          }
        });
      }
    });
    flutterBlue.startScan();
  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bluetooth Devices')), 
      body: ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(devicesList[index].name.isNotEmpty ? devicesList[index].name : 'Unknown Device'),
            subtitle: Text(devicesList[index].id.toString()),
            onTap: () {
              // Handle device tap
            },
          );
        },
      ),
    );
  }
}