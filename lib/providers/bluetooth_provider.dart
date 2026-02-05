import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BluetoothProvider {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  // List of available devices
  List<BluetoothDevice> devicesList = new List<BluetoothDevice>();

  // Flutter text to speech instance
  FlutterTts _flutterTts = FlutterTts();

  BluetoothProvider() {
    // Initialize Bluetooth listening
    _flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!devicesList.contains(r.device)) {
          devicesList.add(r.device);
        }
      }
    });
  }

  // Start scanning for devices
  void startScan() {
    _flutterBlue.startScan();
  }

  // Stop scanning for devices
  void stopScan() {
    _flutterBlue.stopScan();
  }

  // Function to connect to a selected Bluetooth device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    _flutterTts.speak('Connected to ${device.name}');
  }

  // Function to disconnect from a Bluetooth device
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
    _flutterTts.speak('Disconnected from ${device.name}');
  }

  // Function to get the list of devices
  List<BluetoothDevice> getDevices() {
    return devicesList;
  }
}