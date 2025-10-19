// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlIoElement = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;


pub const CODEC_8_BYTE_ARRAY = &[_]u8{
    0x01, 0x05, 0x02, 0x15, 0x03, 0x01, 0x01, 0x01, 0x42, 0x5E, 0x0F, 0x01,
    0xF1, 0x00, 0x00, 0x60, 0x1A, 0x01, 0x4E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
};

pub const CODEC_8E_BYTE_ARRAY = &[_]u8{
    0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x01, 0x00, 0x01, 0x00, 0x11,
    0x00, 0x1D, 0x00, 0x01, 0x00, 0x10, 0x01, 0x5E, 0x2C, 0x88, 0x00, 0x02, 0x00,
    0x0B, 0x00, 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A, 0x00, 0x0E, 0x00, 0x00,
    0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A, 0x00, 0x00,
};

pub const CODEC_16_BYTE_ARRAY = &[_]u8{
    0x00, 0x0B, 0x05, 0x04, 0x02, 0x00, 0x01, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00,
    0x0B, 0x00, 0x26, 0x00, 0x42, 0x56, 0x3A, 0x00, 0x00,
};

pub fn CODEC_8_AVL_IO_ELEMENT(allocator: Allocator) !AvlIoElement {
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

pub fn CODEC_8E_AVL_IO_ELEMENT(allocator: Allocator) !AvlIoElement {
    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    try n1_elements.put(0x0001, [1]u8{0x01});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    try n2_elements.put(0x0011, [2]u8{ 0x00, 0x1D });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    try n4_elements.put(0x0010, [4]u8{ 0x01, 0x5E, 0x2C, 0x88 });

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    try n8_elements.put(0x000B, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A });
    try n8_elements.put(0x000E, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A });

    const nx_elements = std.AutoArrayHashMap(u16, []const u8).init(allocator);

    return .{
        .codec_id = CodecId.Codec8Extended,
        .event_io_id = 0x0001,
        .number_of_total_io = 0x0005,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
        .nx_elements = nx_elements,
    };
}

pub fn CODEC_16_AVL_IO_ELEMENT(allocator: Allocator) !AvlIoElement {
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
