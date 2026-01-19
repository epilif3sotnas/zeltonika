module config


// internal
import api.config.io


/// ConfigIoConn Configuration for the IO connection.
/// This configuration has two types: TCP and UDP.
pub struct ConfigIoConn {
pub:
  /// tcp Configuration for the TCP connection.
  tcp   io.ConfigTcp

  /// udp Configuration for the UDP connection.
  udp   io.ConfigUdp
}
