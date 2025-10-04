// internal
const ConfigTcp = @import("tcp.zig").ConfigTcp;
const ConfigUdp = @import("udp.zig").ConfigUdp;


/// Configuration for the IO connection.
/// This configuration has two types: TCP and UDP.
pub const ConfigIoConn = struct {

   /// Configuration for the TCP connection.
    const tcp: *const ConfigTcp = .{};

    /// Configuration for the UDP connection.
    const udp: *const ConfigUdp = .{};
};
