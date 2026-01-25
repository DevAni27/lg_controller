import 'package:flutter/material.dart';
import 'ssh_controller.dart';
import 'settings_controller.dart';
import '../helpers/kml_helper.dart';
import '../helpers/snackbar_helper.dart';

class LgController {
  final SshController sshController;
  final SettingsController settingsController;

  LgController({required this.sshController, required this.settingsController});

  Future<void> relaunchLg(BuildContext context) async {
    try {
      String res = await sshController.runCommand(
        'lg-relaunch',
      );
      sshController.close();
      showSnackBar(
          context: context, message: 'Rebooting LGs', color: Colors.green);
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), color: Colors.red);
    }
  }

  Future<void> rebootLg(BuildContext context) async {
    try {
      for (var i = int.parse(settingsController.lgRigsNum!); i >= 1; i--) {
        try {
          await sshController.runCommand(
              'sshpass -p ${settingsController.lgPassword} ssh -t lg$i "echo ${settingsController.lgPassword} | sudo -S reboot"');
        } catch (e) {
          // ignore: avoid_print
          print(e);
        }
      }
      await sshController.close();
      showSnackBar(
          context: context, message: 'Rebooting LGs', color: Colors.green);
    } catch (e) {
      showSnackBar(context: context, message: e.toString(), color: Colors.red);
    }
  }

  Future<void> dispatchQuery(BuildContext context, String query) async {
    try {
      const target = "/tmp/query.txt";
      final res = await sshController.runCommand(
        "echo '$query' > $target",
      );
      showSnackBar(
        context: context,
        message: 'Dispatching KML query',
        color: Colors.green,
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: e.toString(),
        color: Colors.red,
      );
    }
  }

  
}