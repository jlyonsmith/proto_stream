use futures::{sink::SinkExt, stream::StreamExt};
use proto_stream::{ProstCodec, msg_schema::Header};
use tokio::net::TcpListener;
use tokio_util::codec::Framed;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let server_addr = "127.0.0.1:8765";
    let listener = TcpListener::bind(server_addr).await?;

    println!("Server running on {}", server_addr);

    loop {
        let (socket, _) = listener.accept().await?;

        tokio::spawn(async move {
            let mut framed = Framed::new(socket, ProstCodec::<Header>::new());

            // Process incoming messages (BytesMut frames)
            while let Some(frame) = framed.next().await {
                match frame {
                    Ok(msg) => {
                        println!("Received message: {:?}", msg);

                        // Echo the message back to the client
                        if let Err(e) = framed.send(msg).await {
                            eprintln!("Error sending frame: {}", e);
                            break;
                        }
                    }
                    Err(e) => {
                        eprintln!("Error reading frame: {}", e);
                        break;
                    }
                }
            }
        });
    }
}
