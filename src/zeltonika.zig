//! Zeltonika is a library whose main goal is handling the data of the Teltonika trackers,
//! which have 2 different types of data codification: JSON and binary (Teltonika Binary codecs and Teltonika JSON codec).
//! This library is lightweight and simple to use as a decoder and encoder for these data formats.
//!
//! Example usage:
//!
//! TODO: Add example usage

// main structs
pub const ZeltonikaConfig = @import("public/config/config.zig").ZeltonikaConfig;
pub const ZeltonikaError = @import("public/errors.zig").ZeltonikaError;
pub const TcpAvlData = @import("public/avl_data/tcp.zig").TcpAvlData;
pub const UdpAvlData = @import("public/avl_data/udp.zig").UdpAvlData;

// aux structs
pub const ConfigLogging = @import("public/config/logging.zig").ConfigLogging;
pub const ConfigParallel = @import("public/config/parallel.zig").ConfigParallel;
pub const ConfigAvlData = @import("public/config/avl_data.zig").ConfigAvlData;
pub const ConfigIoConn = @import("public/config/io/io.zig").ConfigIoConn;
pub const ConfigTcp = @import("public/config/io/tcp.zig").ConfigTcp;
pub const ConfigTcpClient = @import("public/config/io/tcp.zig").ConfigTcpClient;
pub const ConfigTcpServer = @import("public/config/io/tcp.zig").ConfigTcpServer;
pub const ConfigUdp = @import("public/config/io/udp.zig").ConfigUdp;
pub const ConfigUdpClient = @import("public/config/io/udp.zig").ConfigUdpClient;
pub const ConfigUdpServer = @import("public/config/io/udp.zig").ConfigUdpServer;

pub const CodecId = @import("public/avl_data/avl_data_array.zig").CodecId;
pub const AvlDataArray = @import("public/avl_data/avl_data_array.zig").AvlDataArray;
pub const Priority = @import("public/avl_data/avl_data_array.zig").Priority;
pub const AvlData = @import("public/avl_data/avl_data_array.zig").AvlData;
pub const GpsElement = @import("public/avl_data/avl_data_array.zig").GpsElement;
pub const Generation = @import("public/avl_data/avl_data_array.zig").Generation;
pub const AvlIoElement = @import("public/avl_data/avl_data_array.zig").AvlIoElement;

pub const AvlDataPacketHeader = @import("public/avl_data/tcp.zig").AvlDataPacketHeader;
pub const Crc16 = @import("public/avl_data/tcp.zig").Crc16;
pub const TcpAvlResponse = @import("public/avl_data/tcp.zig").TcpAvlResponse;

pub const UdpChannelHeader = @import("public/avl_data/udp.zig").UdpChannelHeader;
pub const AvlPacketHeader = @import("public/avl_data/udp.zig").AvlPacketHeader;
pub const UdpAvlResponse = @import("public/avl_data/udp.zig").UdpAvlResponse;

// API
pub const Zeltonika = @import("public/zeltonika.zig").Zeltonika;
