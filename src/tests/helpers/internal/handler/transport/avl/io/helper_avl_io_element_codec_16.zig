// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlIoElement = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;


pub const BYTE_ARRAY = &[_]u8{
    0x00, 0x0B, 0x05, 0x04, 0x02, 0x00, 0x01, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00,
    0x0B, 0x00, 0x26, 0x00, 0x42, 0x56, 0x3A, 0x00, 0x00,
};

pub fn AVL_IO_ELEMENT(allocator: Allocator) !AvlIoElement {
    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    try n1_elements.put(0x0001, [1]u8{0x00});
    try n1_elements.put(0x0003, [1]u8{0x00});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    try n2_elements.put(0x000B, [2]u8{ 0x00, 0x26 });
    try n2_elements.put(0x0042, [2]u8{ 0x56, 0x3A });

    const n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    const n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);

    return .{
        .codec_id = CodecId.Codec16,
        .event_io_id = 0x000B,
        .number_of_total_io = 0x04,
        .generation_type = .On_Change,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
    };
}
