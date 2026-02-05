// bluetooth_provider.dart
// This file includes the logic for Bluetooth and TTS (Text-to-Speech) provider.

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_tts/flutter_tts.dart';

class BluetoothProvider extends ChangeNotifier {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _connectedDevice;

  List<BluetoothDevice> get devices => _devices;
  BluetoothDevice? get connectedDevice => _connectedDevice;

  void scanForDevices() {
    _flutterBlue.startScan();
    _flutterBlue.scanResults.listen((results) {
      _devices = results.map((result) => result.device).toList();
      notifyListeners();
    });
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    _connectedDevice = device;
    notifyListeners();
  }

  void disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      notifyListeners();
    }
  }
}

class TtsProvider {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.speak(text);
  }
}