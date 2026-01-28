module io


// ConfigUdp is a configuration for the UDP connection with
// configuration options for the client and server.
pub struct ConfigUdp {
pub:
  // client contains configuration options for the client.
  client  ConfigUdpClient

  // server contains configuration options for the server.
  server  ConfigUdpServer
}

// ConfigUdpClient Configuration options for the client.
pub struct ConfigUdpClient {}

// ConfigUdpServer Configuration options for the server.
pub struct ConfigUdpServer {}
