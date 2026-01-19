module io


// ConfigTcp is a configuration for the TCP connection with
// configuration options for the client and server.
pub struct ConfigTcp {
pub:
  // client contains configuration options for the client.
  client  ConfigTcpClient

  // server contains configuration options for the server.
  server  ConfigTcpServer
}

// ConfigTcpClient Configuration options for the client.
pub struct ConfigTcpClient {}

// ConfigTcpServer Configuration options for the server.
pub struct ConfigTcpServer {}
