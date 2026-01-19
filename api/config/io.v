module config


// internal
import api.config.io


pub struct ConfigIoConn {
  tcp   io.ConfigTcp
  udp   io.ConfigUdp
}
