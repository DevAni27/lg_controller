import 'package:flutter/material.dart';
import 'ssh_controller.dart';
import 'settings_controller.dart';
import '../helpers/kml_helper.dart';
import '../helpers/snackbar_helper.dart';

class LgController {
  final SshController sshController;
  final SettingsController settingsController;

  LgController({required this.sshController, required this.settingsController});

  Future<void> relaunchLG(BuildContext context) async {
  try {
    final cmd = '''
echo '${settingsController.lgPassword}' | sudo -S systemctl restart lightdm
''';

    await sshController.runCommand(cmd);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Relaunching Liquid Galaxy…'),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Relaunch failed: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> shutDownLG(BuildContext context) async {
  try {
    final cmd = '''
echo '${settingsController.lgPassword}' | sudo -S shutdown -h now
''';

    await sshController.runCommand(cmd);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Shutting down Liquid Galaxy…'),
        backgroundColor: Colors.red,
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shutdown failed: $e'),
        backgroundColor: Colors.red,
      ),
    );
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

Future<void> sendLogoToLeftScreen(BuildContext context) async {
  try {
    // For a 3-screen rig, leftmost slave is usually slave_2.kml
    // General formula from docs:
    // leftRig = floor(rigCount/2) + 2
    final rigCount = int.tryParse(settingsController.lgRigsNum ?? "3") ?? 3;
    final leftRig = (rigCount / 2).floor() + 2; // 3 -> 3/2=1 -> +2 => 3? (docs use this for larger rigs)
    
    // For 3-rig, many setups use slave_2 as left screen.
    // So FORCE slave_2 for your task/demo rig:
    final leftSlaveKmlPath = "/var/www/html/kml/slave_$leftRig.kml";

    final kml = KmlHelper.logoScreenOverlay(
      "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgXmdNgBTXup6bdWew5RzgCmC9pPb7rK487CpiscWB2S8OlhwFHmeeACHIIjx4B5-Iv-t95mNUx0JhB_oATG3-Tq1gs8Uj0-Xb9Njye6rHtKKsnJQJlzZqJxMDnj_2TXX3eA5x6VSgc8aw/s320-rw/LOGO+LIQUID+GALAXY-sq1000-+OKnoline.png"
    );

    // Write multi-line file safely
    await sshController.runCommand("""
bash -lc 'cat > $leftSlaveKmlPath << "EOF"
$kml
EOF'
""");

    // Verification
    final verify = await sshController.runCommand("head -n 8 $leftSlaveKmlPath");
    print("slave_2.kml now: >>>$verify<<<");

    showSnackBar(context: context, message: "Logo written to left screen KML", color: Colors.green);
  } catch (e) {
    showSnackBar(context: context, message: "Logo failed: $e", color: Colors.red);
  }
}

// Future<void> sendPyramidInline(BuildContext context) async {
//   try {
//     final kml = KmlHelper.pyramidKml(lat: 18.5246, lon: 73.8786);

//     // IMPORTANT: one-line query (remove newlines)
//     final oneLine = kml.replaceAll("\n", "").replaceAll("\r", "");

//     await dispatchQuery(context, "kml=$oneLine");

//     // fly out so you can see it
//     await dispatchQuery(
//       context,
//       'flytoview=<LookAt><longitude>73.8786</longitude><latitude>18.5246</latitude><range>8000</range><tilt>65</tilt><heading>0</heading></LookAt>',
//     );
//   } catch (e) {
//     showSnackBar(context: context, message: "Inline pyramid failed: $e", color: Colors.red);
//   }
// }

Future<void> cleanLogo(BuildContext context) async {
  final rigs = int.tryParse(settingsController.lgRigsNum ?? "3") ?? 3;

  // leftmost screen index in LG rig:
  // for 3 rigs -> 3 (your lg3), for 5 -> 4, etc.
  final leftRig = (rigs / 2).floor() + 2;

  const emptyKml = '''
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document></Document>
</kml>
''';

  try {
    await sshController.runCommand(
      'cat > /var/www/html/kml/slave_$leftRig.kml << "EOF"\n$emptyKml\nEOF',
    );

    showSnackBar(
      context: context,
      message: "Logo cleared on slave_$leftRig",
      color: Colors.green,
    );
  } catch (e) {
    showSnackBar(
      context: context,
      message: "Failed to clear logo: $e",
      color: Colors.red,
    );
  }
}






  
}