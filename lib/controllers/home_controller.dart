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


  Future<void> setRefreshForSlaves(BuildContext context) async {
  try {
    final rigs = int.tryParse(settingsController.lgRigsNum ?? "3") ?? 3;
    final pass = settingsController.lgPassword;

    
    for (int i = 2; i <= rigs; i++) {
      // Add refresh tags right after the href for that slave file
      final search = '<href>##LG_PHPIFACE##kml\\/slave_$i.kml<\\/href>';
      final replace =
          '<href>##LG_PHPIFACE##kml\\/slave_$i.kml<\\/href>'
          '<refreshMode>onInterval<\\/refreshMode>'
          '<refreshInterval>2<\\/refreshInterval>';

      final cmd = """
sshpass -p '$pass' ssh -o StrictHostKeyChecking=no -t lg$i '
  echo '$pass' | sudo -S sed -i "s/$replace/$search/g"  ~/earth/kml/slave/myplaces.kml;
  echo '$pass' | sudo -S sed -i "s/$search/$replace/g"  ~/earth/kml/slave/myplaces.kml;
'
""";

      await sshController.runCommand(cmd);
    }

    showSnackBar(
      context: context,
      message: "Refresh enabled on slaves (2s interval)",
      color: Colors.green,
    );
  } catch (e) {
    showSnackBar(
      context: context,
      message: "setRefresh failed: $e",
      color: Colors.red,
    );
  }
}


  Future<void> sendLogoToLeftScreen(BuildContext context, int slaveNo) async {
    try {
      final rigCount = int.tryParse(settingsController.lgRigsNum ?? "3") ?? 3;
      final leftRig = (rigCount / 2).floor() + 2;
      
      final leftSlaveKmlPath = "/var/www/html/kml/slave_$leftRig.kml";

      final kml = KmlHelper.logoScreenOverlay(
        "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgXmdNgBTXup6bdWew5RzgCmC9pPb7rK487CpiscWB2S8OlhwFHmeeACHIIjx4B5-Iv-t95mNUx0JhB_oATG3-Tq1gs8Uj0-Xb9Njye6rHtKKsnJQJlzZqJxMDnj_2TXX3eA5x6VSgc8aw/s320-rw/LOGO+LIQUID+GALAXY-sq1000-+OKnoline.png"
      );

      await sshController.runCommand("""
bash -lc 'cat > $leftSlaveKmlPath << "EOF"
$kml
EOF'
""");

      await setRefreshForSlaves(context);

      final verify = await sshController.runCommand("head -n 8 $leftSlaveKmlPath");
      

      showSnackBar(context: context, message: "Logo written to left screen KML", color: Colors.green);
    } catch (e) {
      showSnackBar(context: context, message: "Logo failed: $e", color: Colors.red);
    }
  }

  Future<void> cleanLogo(BuildContext context, int slaveNo) async {
    try {
      String res = await sshController.runCommand(
        "echo '${KmlHelper.getSlaveDefaultKml(slaveNo)}' > /var/www/html/kml/slave_$slaveNo.kml",
      );
      
      await setRefreshForSlaves(context);

      dispatchQuery(context, '');
      showSnackBar(
        context: context,
        message: 'Clearing KML on slave',
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

  /// Clear all KML content - properly clears kmls.txt
  Future<void> cleanKml(BuildContext context) async {
    try {
      
      await sshController.runCommand(
        "echo '' > /var/www/html/kmls.txt",
      );

      

      
      await sshController.runCommand(
        "echo '' > /tmp/query.txt",
      );

      
      await sshController.runCommand(
        "rm -f /var/www/html/pyramid.kml 2>/dev/null || true",
      );

      showSnackBar(
        context: context,
        message: "All KML content cleared",
        color: Colors.green,
      );

      
    } catch (e) {
      showSnackBar(
        context: context,
        message: "Failed to clear KML: $e",
        color: Colors.red,
      );
      
    }
  }


  Future<void> sendPyramidKml() async {
  
  final host = settingsController.lgIp; 
  const webPort = 81;

  
  final kmlBody = KmlHelper.pyramidKml(lat: 18.5246, lon: 73.8786);

  

  const remoteKmlPath = "/var/www/html/kml/pyramid.kml";
  final url = "http://$host:$webPort/kml/pyramid.kml";

  
  await sshController.runCommand(
    '''bash -lc 'cat > "$remoteKmlPath" << "EOF"\n$kmlBody\nEOF' ''',
  );

  
  await sshController.runCommand(
    '''bash -lc 'echo "$url" > /var/www/html/kmls.txt' ''',
  );

  
  await Future.delayed(const Duration(milliseconds: 300));

}

}