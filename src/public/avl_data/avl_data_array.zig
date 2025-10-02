// std
const std = @import("std");


/// Codec identifier with its value associated
/// defined by the Teltonika codec documentation.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const CodecId = enum(u8) {
    Codec8 = 0x08,
    Codec8Extended = 0x8E,
    Codec16 = 0x10,
};

/// AvlDataArray represents an array of AVL data.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const AvlDataArray = struct {

    /// Codec identifier for the AVL data array.
    codec_id: CodecId,

    /// Array of AVL data elements.
    data: []const *const AvlData,
};

/// Enum which defines AVL data priority.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const Priority = enum(u8) {
    Low = 0,
    High = 1,
    Panic = 2,
};

/// AvlData represents an AVL data element.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const AvlData = struct {

    /// Timestamp of the AVL data element (unix timestamp in milliseconds).
    timestamp: u64,

    /// Priority of the AVL data element.
    priority: Priority,

    /// GPS element of the AVL data element.
    gps_element: *const GpsElement,

    /// I/O element of the AVL data element.
    io_element: *const AvlIoElement,
};

/// GpsElement represents all the fields that the
/// GPS element contains.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const GpsElement = struct {

    /// Longitude of the GPS element.
    longitude: f64,

    /// Latitude of the GPS element.
    latitude: f64,

    /// Altitude of the GPS element.
    altitude: i16,

    /// Angle of the GPS element.
    angle: u16,

    /// Number of satellites of the GPS element.
    satellites: u8,

    /// Speed of the GPS element.
    speed: u16,
};

/// Generation type of the AVL IO element that
/// it is only present on the Codec 16.
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const Generation = enum(u8) {
    On_Exit = 0,
    On_Entrance = 1,
    On_Both = 2,
    Reserved = 3,
    Hysteresis = 4,
    On_Change = 5,
    Eventual = 6,
    Periodical = 7,
};

/// I/O element of the AVL data element. This struct has mandatory fields
/// as codec_id, event_io_id, and number_of_total_io that are required
/// across all Codecs for device data sending. Then, there are the other
/// elements that depending on the codec are populated or not
///
/// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub const AvlIoElement = struct {

    /// Codec ID of the I/O element.
    codec_id: CodecId,

    /// Event I/O ID of the I/O element.
    event_io_id: u16,

    /// Number of total I/O elements.
    number_of_total_io: u16,

    /// Generation type of the I/O element.
    pub const generation_type: ?Generation = null;

    /// N1 elements of the I/O element.
    pub const n1_elements: ?std.AutoHashMap(u16, [1]u8) = null;

    /// N2 elements of the I/O element.
    pub const n2_elements: ?std.AutoHashMap(u16, [2]u8) = null;

    /// N4 elements of the I/O element.
    pub const n4_elements: ?std.AutoHashMap(u16, [4]u8) = null;

    /// N8 elements of the I/O element.
    pub const n8_elements: ?std.AutoHashMap(u16, [8]u8) = null;

    /// Nx elements of the I/O element.
    pub const nx_elements: ?std.AutoHashMap(u16, []const u8) = null;
};
