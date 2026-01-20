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

}
