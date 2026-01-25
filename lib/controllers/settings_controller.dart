import 'package:flutter/material.dart';

class SettingsController with ChangeNotifier {
  String? _lgIp;
  String? _lgPort;
  String? _lgUsername;
  String? _lgPassword;
  String? _lgRigsNum;

  
  String? get lgIp => _lgIp;
  String? get lgPort => _lgPort;
  String? get lgUsername => _lgUsername;
  String? get lgPassword => _lgPassword;
  String? get lgRigsNum => _lgRigsNum;

  Future<void> updateLgIp(String newLgIp) async {
    if (newLgIp == lgIp) {
      return;
    } else {
      _lgIp = newLgIp;
    }
  }

  Future<void> updateLgPort(String newLgPort) async {
    if (newLgPort == lgPort) {
      return;
    } else {
      _lgPort = newLgPort;
    }
  }

  Future<void> updateLgUsername(String newLgUsername) async {
    if (newLgUsername == lgUsername) {
      return;
    } else {
      _lgUsername = newLgUsername;
    }
  }

  Future<void> updateLgPassword(String newLgPassword) async {
    if (newLgPassword == lgPassword) {
      return;
    } else {
      _lgPassword = newLgPassword;
    }
  }

  Future<void> updateLgRigsNum(String newLgRigsNum) async {
    if (newLgRigsNum == lgRigsNum) {
      return;
    } else {
      _lgRigsNum = newLgRigsNum;
    }
  }
}