import 'package:dartssh2/dartssh2.dart';
// import 'dart:io';

class LGService {
  SSHClient? _client;

  bool get isConnected => _client != null;

  Future<bool> connect({
    required String host,
    required int port,
    required String username,
    required String password,
  }) async {
    try {
      final socket = await SSHSocket.connect(host, port);
      _client = SSHClient(
        socket,
        username: username,
        onPasswordRequest: () => password,
      );

      return true;
    } catch (e) {
      print("SSH connect error: $e");
      return false;
    }
  }

  Future<String> exec(String command) async {
    final result = await _client!.run(command);
    return String.fromCharCodes(result);
  }

  void disconnect() {
    _client?.close();
    _client = null;
  }

  Future<void> flyToHomeViaMyPlaces({
  required double lat,
  required double lon,
  double range = 8000,
  double tilt = 45,
  double heading = 0,
}) async {
  final kml = '''
<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2"
     xmlns:gx="http://www.google.com/kml/ext/2.2">
  <Document>
    <name>FlyTo Home</name>

    <gx:Tour>
      <name>FlyTo</name>
      <gx:Playlist>
        <gx:FlyTo>
          <gx:duration>1.2</gx:duration>
          <gx:flyToMode>smooth</gx:flyToMode>
          <LookAt>
            <longitude>$lon</longitude>
            <latitude>$lat</latitude>
            <range>$range</range>
            <tilt>$tilt</tilt>
            <heading>$heading</heading>
            <altitudeMode>relativeToGround</altitudeMode>
          </LookAt>
        </gx:FlyTo>
      </gx:Playlist>
    </gx:Tour>

  </Document>
</kml>
''';

  const target = "/tmp/query.txt";

  final cmd = """
cat > $target << 'EOF'
$kml
EOF
touch $target


""";

  await exec(cmd);
}
}




