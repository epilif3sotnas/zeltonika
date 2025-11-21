// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlIoElement = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;


pub const BYTE_ARRAY = &[_]u8{
    0x01, 0x05, 0x02, 0x15, 0x03, 0x01, 0x01, 0x01, 0x42, 0x5E, 0x0F, 0x01,
    0xF1, 0x00, 0x00, 0x60, 0x1A, 0x01, 0x4E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

pub fn AVL_IO_ELEMENT(allocator: Allocator) !AvlIoElement {
    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    try n1_elements.put(0x15, [1]u8{0x03});
    try n1_elements.put(0x01, [1]u8{0x01});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    try n2_elements.put(0x42, [2]u8{ 0x5E, 0x0F });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    try n4_elements.put(0xf1, [4]u8{ 0x00, 0x00, 0x60, 0x1A });

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    try n8_elements.put(0x4E, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 });

    return .{
        .codec_id = CodecId.Codec8,
        .event_io_id = 0x01,
        .number_of_total_io = 0x05,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
    };
}
