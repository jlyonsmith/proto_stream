# Rust and Dart Protocol Buffers Stream Example

This is example program shows how to stream [ProtoBuf](https://protobuf.dev/) messages over a `TcpStream` in Rust and Dart.

- Has separate client and server binaries for Rust, and a client for Dart
- Uses the [`prost`](https://crates.io/crates/prost) crate for ProtoBuf support in Rust.
- Uses [`tokio_util`](https://docs.rs/tokio-util/latest/tokio_util/) and the [`LengthDelimetedCodec`](https://docs.rs/tokio-util/latest/tokio_util/codec/length_delimited/struct.LengthDelimitedCodec.html) to frame streamed FlatBuffer messages with a length prefix.
- Implements a `PostCode` to handle `encode` and `decode` hiding all `Sink` and `Stream` operations for clean framing of messages.
- Shows how to setup the `build.rs` to compile an arbitrary number of `.proto` files in a `schemas/` directory.
- Demonstrates how to differentiate a collection of ProtoBuf messages with a message header.
- Includes a Dart program that sends and receives the same `.proto` messages.
- Shows how to generate the `.proto` messages for Dart programs.
- Includes a `withLengthPrefix` for encoding messages and a `LengthPrefixDecoder` to `transform` received messages with a length prefix.

This was the best way that I could figure out to work with ProtoBuf messages in Rust and Dart, the goal being to hide as much as possible the guts of working with framing and working with Protocol Buffers. *If you know a better way, I'd love to hear about it!*

> Note that if you use a higher level network messaging protocol such as [NATS](https://nats.io/) you don't need all the stream framing logic.
