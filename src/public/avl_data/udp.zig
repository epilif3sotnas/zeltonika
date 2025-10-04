// internal
const AvlDataArray = @import("avl_data_array.zig").AvlDataArray;


/// UdpAvlData represents the data contained when
/// the UDP AVL data packet is received plus the response
/// that should be returned to the device in the response field.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const UdpAvlData = struct {

    /// Data containing the UDP channel header.
    udp_channel_header: *const UdpChannelHeader,

    /// Data containing the AVL packet header.
    avl_packet_header: *const AvlPacketHeader,

    /// Data containing the AVL data array.
    avl_data_array: *const AvlDataArray,

    /// Data containing the response to be sent back to the device.
    response: *const UdpAvlResponse,
};

/// UdpChannelHeader represents the data contained in
/// the packet received via UDP protocol.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const UdpChannelHeader = struct {

    /// Length of the packet received.
    length: u16,

    /// Packed identifier of the packet received.
    packet_id: u16,

    /// Not used byte.
    not_usable_byte: u8,
};

/// AvlPacketHeader represents the header of an UDP data packet.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const AvlPacketHeader = struct {

    /// AVL packet identifier.
    avl_packet_id: u8,

    /// IMEI length that it is used to parse the IMEI.
    imei_length: u16,

    // International Mobile Equipment Identity
    imei: []const u8,
};

/// UdpAvlResponse represents the response to be sent back to the device
/// for the given data.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const UdpAvlResponse = struct {

    /// Length of the packet received.
    length: u16,

    /// Packed identifier of the packet received.
    packet_id: u16,

    /// Not used byte.
    not_usable_byte: u8,

    /// AVL packet identifier.
    avl_packet_id: u8,

    /// Number of accepted AVL data.
    num_accepted_data: u8,
};
