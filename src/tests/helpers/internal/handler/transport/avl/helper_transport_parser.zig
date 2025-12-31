// std
const std = @import("std");

// internal
const AvlData = @import("../../../../../../public/avl_data/avl_data_array.zig").AvlData;
const TcpAvlData = @import("../../../../../../public/avl_data/tcp.zig").TcpAvlData;
const UdpAvlData = @import("../../../../../../public/avl_data/udp.zig").UdpAvlData;
const CodecId = @import("../../../../../../public/avl_data/avl_data_array.zig").CodecId;
const Priority = @import("../../../../../../public/avl_data/avl_data_array.zig").Priority;


pub const TCP_DATA_BYTE_ARRAY = &[_]u8 {
    0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x36,
    0x08, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x13,
};

pub fn TCP_DATA() TcpAvlData {
    return .{
        .avl_data_packet_header = .{
            .zero_bytes = 0x00,
            .data_field_length = 0x36,
        },
        .avl_data_array = .{
            .codec_id = CodecId.Codec8,
            .data = &[_]AvlData {},
        },
        .crc_16 = .{
            .value = 0x13,
        },
        .response = .{
            .response = 0x00,
        },
    };
}

pub const UDP_DATA_BYTE_ARRAY = &[_]u8 {
    0x00, 0x3D, 0xCA, 0xFE, 0x00, 0x05, 0x00, 0x0F,
    0x33, 0x35, 0x32, 0x30, 0x39, 0x33, 0x30, 0x38, 0x36, 0x34, 0x30, 0x33, 0x36, 0x35, 0x35,
    0x08, 0x00, 0x00,
};

pub fn UDP_DATA() UdpAvlData {
    return .{
        .udp_channel_header = .{
            .length = 0x003D,
            .packet_id = 0xCAFE,
            .not_usable_byte = 0x00,
        },
        .avl_packet_header = .{
            .avl_packet_id = 0x05,
            .imei_length = 0x0F,
            .imei = &[_]u8 { 0x33, 0x35, 0x32, 0x30, 0x39, 0x33, 0x30, 0x38, 0x36, 0x34, 0x30, 0x33, 0x36, 0x35, 0x35 },
        },
        .avl_data_array = .{
            .codec_id = CodecId.Codec8,
            .data = &[_]AvlData {},
        },
        .response = .{
            .length = 0x003D,
            .packet_id = 0xCAFE,
            .not_usable_byte = 0x00,
            .avl_packet_id = 0x05,
            .num_accepted_data = 0x00,
        },
    };
}
