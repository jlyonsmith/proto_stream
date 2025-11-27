import 'dart:async';
import 'dart:typed_data';

Uint8List withLengthPrefix(Uint8List message) {
  final length = message.length;
  final byteData = ByteData(4 + length);

  // Write the 32-bit integer length using big-endian byte order
  byteData.setUint32(0, length, Endian.big);

  // Copy the message bytes after the length prefix
  for (int i = 0; i < length; i++) {
    byteData.setUint8(4 + i, message[i]);
  }

  return byteData.buffer.asUint8List();
}

/// A StreamTransformer that decodes a stream of Uint8List chunks into
/// complete messages based on a 4-byte big-endian length prefix.
class LengthPrefixDecoder extends StreamTransformerBase<Uint8List, Uint8List> {
  @override
  Stream<Uint8List> bind(Stream<Uint8List> stream) {
    return Stream.eventTransformed(
      stream,
      (sink) => _LengthPrefixDecoderSink(sink),
    );
  }
}

class _LengthPrefixDecoderSink implements EventSink<Uint8List> {
  final EventSink<Uint8List> _outputSink;
  final BytesBuilder _buffer = BytesBuilder();
  int? _messageLength;

  _LengthPrefixDecoderSink(this._outputSink);

  @override
  void add(Uint8List data) {
    _buffer.add(data);

    // Continuously process the buffer as long as complete messages can be extracted
    while (true) {
      if (_messageLength == null) {
        // Need at least 4 bytes to read the length prefix
        if (_buffer.length >= 4) {
          final bytes = _buffer.toBytes();
          final byteData = ByteData.sublistView(bytes);
          // Read the 32-bit integer length using big-endian byte order
          _messageLength = byteData.getUint32(0, Endian.big);
        } else {
          // Not enough data for the length, wait for more
          break;
        }
      }

      if (_messageLength != null) {
        final totalLength = 4 + _messageLength!;
        // Check if the entire message (length prefix + payload) is in the buffer
        if (_buffer.length >= totalLength) {
          final bytes = _buffer.toBytes();
          // Extract the payload (after the 4-byte prefix)
          final payload = Uint8List.view(
            bytes.buffer,
            bytes.offsetInBytes + 4,
            _messageLength!,
          );
          _outputSink.add(payload);

          // Remove the processed message from the buffer
          if (_buffer.length == totalLength) {
            _buffer.clear();
          } else {
            // Keep the remaining bytes for the next message
            final remaining = Uint8List.view(
              bytes.buffer,
              bytes.offsetInBytes + totalLength,
            );
            _buffer.clear();
            _buffer.add(remaining);
          }
          _messageLength = null; // Reset length for the next message
        } else {
          // Not enough data for the full message, wait for more
          break;
        }
      }
    }
  }

  @override
  void addError(errorEvent, [StackTrace? stackTrace]) {
    _outputSink.addError(errorEvent, stackTrace);
  }

  @override
  void close() {
    if (_buffer.length > 0) {
      _outputSink.addError(
        'Connection closed with unprocessed data in buffer: ${_buffer.length} bytes.',
      );
    }
    _outputSink.close();
  }
}
