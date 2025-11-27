use futures::sink::SinkExt;
use proto_stream::{ProstCodec, msg_schema::Header};
use tokio::net::TcpStream;
use tokio_util::codec::Framed;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let stream = TcpStream::connect("127.0.0.1:8765").await?;
    let mut framed = Framed::new(stream, ProstCodec::<Header>::new());
    let message = Header {
        msg: Some(proto_stream::msg_schema::header::Msg::Error(
            proto_stream::msg_schema::Error {
                error_no: 1,
                error_msg: "Test error".to_string(),
            },
        )),
    };

    framed.send(message).await?;

    println!("Sent Protobuf message");

    Ok(())
}
