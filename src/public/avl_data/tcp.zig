// internal
const AvlDataArray = @import("avl_data_array.zig").AvlDataArray;


/// TcpAvlData represents the data contained when
/// the TCP AVL data packet is received plus the response
/// that should be returned to the device in the response field.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const TcpAvlData = struct {

    /// AvlDataPacketHeader represents the header of an TCP data packet.
    avl_data_packet_header: *const AvlDataPacketHeader,

    /// AvlDataArray represents the array of AVL data.
    avl_data_array: *const AvlDataArray,

    /// CRC16 checksum of the data.
    crc_16: *const Crc16,

    /// Data containing the response to be sent back to the device.
    response: *const TcpAvlResponse,
};

/// AvlDataPacketHeader represents the header of an TCP data packet.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const AvlDataPacketHeader = struct {

    /// 4 bytes with value of Zero.
    zero_bytes: u32,

    /// Length of the data field.
    data_field_length: u32,
};

/// CRC (Cyclic Redundancy Check) is an error-detecting code using for detect accidental changes to RAW data.
///
/// CRC16 represents the CRC16 checksum of the data.
/// It is calculated from the Codec ID to the Second Number of Data.
///
/// For calculation we are using CRC-16/IBM.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const Crc16 = struct {

    /// CRC16 checksum of the data.
    value: u32,
};

/// TcpAvlResponse represents the response to be sent back to the device
/// for the given data.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const TcpAvlResponse = struct {

    /// Number of received AVL data.
    response: u32,
};
