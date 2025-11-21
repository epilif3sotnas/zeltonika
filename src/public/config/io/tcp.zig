/// Configuration for the TCP connection with
/// configuration options for the client and server.
pub const ConfigTcp = struct {

    /// Configuration options for the client.
    client: ConfigTcpClient = .{},

    /// Configuration options for the server.
    server: ConfigTcpServer = .{},
};

/// Configuration options for the client.
pub const ConfigTcpClient = struct {};

/// Configuration options for the server.
pub const ConfigTcpServer = struct {};
