import 'dart:io';
import 'package:dart_client/dart_client.dart';

void main(List<String> arguments) async {
  final msg = Header(info: Info(protocolVer: 150));

  Socket socket = await Socket.connect('localhost', 8765);
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  // NOTE: Use .fromBuffer(bytes) to deserialize
  socket.add(withLengthPrefix(msg.writeToBuffer()));

  await socket.flush();
  await socket.close();
  socket.destroy();
}
