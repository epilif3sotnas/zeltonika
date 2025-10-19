// Configuration for the UDP connection with
// configuration options for the client and server.
pub const ConfigUdp = struct {

    /// Configuration options for the client.
    client: *const ConfigUdpClient = &ConfigUdpClient{},

    /// Configuration options for the server.
    server: *const ConfigUdpServer = &ConfigUdpServer{},
};

/// Configuration options for the client.
pub const ConfigUdpClient = struct {};

/// Configuration options for the server.
pub const ConfigUdpServer = struct {};
