import 'dart:io';
import 'package:dart_client/dart_client.dart';
import 'dart:typed_data';

void main(List<String> arguments) async {
  final msg = Header(info: Info(protocolVer: 150));

  Socket socket = await Socket.connect('localhost', 8765);
  print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

  socket.add(withLengthPrefix(msg.writeToBuffer()));
  print("Sent message: $msg");

  socket.transform(LengthPrefixDecoder()).listen((Uint8List data) {
    final msg = Header.fromBuffer(data);

    print('Received response: $msg');
  });

  await Future.delayed(Duration(seconds: 2));

  await socket.flush();
  await socket.close();
  socket.destroy();
}
