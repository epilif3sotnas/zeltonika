// internal
const ConfigTcp = @import("tcp.zig").ConfigTcp;
const ConfigUdp = @import("udp.zig").ConfigUdp;


/// Configuration for the IO connection.
/// This configuration has two types: TCP and UDP.
pub const ConfigIoConn = struct {

   /// Configuration for the TCP connection.
    tcp: ConfigTcp = .{},

    /// Configuration for the UDP connection.
    udp: ConfigUdp = .{},
};
