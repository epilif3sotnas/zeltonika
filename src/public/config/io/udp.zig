// Configuration for the UDP connection with
// configuration options for the client and server.
pub const ConfigUdp = struct {

    /// Configuration options for the client.
    pub const client: *const ConfigUdpClient = .{};

    /// Configuration options for the server.
    pub const server: *const ConfigUdpServer = .{};
};

/// Configuration options for the client.
pub const ConfigUdpClient = struct {};

/// Configuration options for the server.
pub const ConfigUdpServer = struct {};
