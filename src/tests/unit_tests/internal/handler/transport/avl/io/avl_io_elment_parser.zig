// std
const std = @import("std");

// internal
const AvlIoElementParser = @import("../../../../../../../internal/handler/transport/avl/io/AvlIoElementParser.zig").AvlIoElementParser;
const ByteBuffer = @import("../../../../../../../internal/utils/ByteBuffer.zig").ByteBuffer;
const AvlIoElement = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;
const Priority = @import("../../../../../../../public/avl_data/avl_data_array.zig").Priority;


test "encodeBin should write to the byte buffer a valid codec 8 byte array" {
    const allocator = std.testing.allocator;

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    defer n1_elements.deinit();

    try n1_elements.put(0x15, [1]u8{0x03});
    try n1_elements.put(0x01, [1]u8{0x01});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    defer n2_elements.deinit();

    try n2_elements.put(0x42, [2]u8{ 0x5E, 0x0F });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    defer n4_elements.deinit();

    try n4_elements.put(0xf1, [4]u8{ 0x00, 0x00, 0x60, 0x1A });

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    defer n8_elements.deinit();

    try n8_elements.put(0x4E, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 });

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input: *const AvlIoElement = &.{
        .codec_id = CodecId.Codec8,
        .event_io_id = 0x01,
        .number_of_total_io = 0x05,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
    };

    const expected = &[_]u8{
        0x01, 0x05, 0x02, 0x15, 0x03, 0x01, 0x01, 0x01, 0x42, 0x5E, 0x0F, 0x01,
        0xF1, 0x00, 0x00, 0x60, 0x1A, 0x01, 0x4E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    };

    try avl_io_element_parser.encodeBin(input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "encodeBin should write to the byte buffer a valid codec 8e byte array" {
    const allocator = std.testing.allocator;

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    defer n1_elements.deinit();

    try n1_elements.put(0x0001, [1]u8{0x01});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    defer n2_elements.deinit();

    try n2_elements.put(0x0011, [2]u8{ 0x00, 0x1D });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    defer n4_elements.deinit();

    try n4_elements.put(0x0010, [4]u8{ 0x01, 0x5E, 0x2C, 0x88 });

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    defer n8_elements.deinit();

    try n8_elements.put(0x000B, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A });
    try n8_elements.put(0x000E, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A });

    var nx_elements = std.AutoArrayHashMap(u16, []const u8).init(allocator);
    defer nx_elements.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input: *const AvlIoElement = &.{
        .codec_id = CodecId.Codec8Extended,
        .event_io_id = 0x0001,
        .number_of_total_io = 0x0005,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
        .nx_elements = nx_elements,
    };

    const expected = &[_]u8{
        0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x01, 0x00, 0x01, 0x00, 0x11,
        0x00, 0x1D, 0x00, 0x01, 0x00, 0x10, 0x01, 0x5E, 0x2C, 0x88, 0x00, 0x02, 0x00,
        0x0B, 0x00, 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A, 0x00, 0x0E, 0x00, 0x00,
        0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A, 0x00, 0x00,
    };

    try avl_io_element_parser.encodeBin(input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "encodeBin should write to the byte buffer a valid codec 16 byte array" {
    const allocator = std.testing.allocator;

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    defer n1_elements.deinit();

    try n1_elements.put(0x0001, [1]u8{0x00});
    try n1_elements.put(0x0003, [1]u8{0x00});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    defer n2_elements.deinit();

    try n2_elements.put(0x000B, [2]u8{ 0x00, 0x26 });
    try n2_elements.put(0x0042, [2]u8{ 0x56, 0x3A });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    defer n4_elements.deinit();

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    defer n8_elements.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input: *const AvlIoElement = &.{
        .codec_id = CodecId.Codec16,
        .event_io_id = 0x000B,
        .number_of_total_io = 0x04,
        .generation_type = .On_Change,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
    };

    const expected = &[_]u8{
        0x00, 0x0B, 0x05, 0x04, 0x02, 0x00, 0x01, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00,
        0x0B, 0x00, 0x26, 0x00, 0x42, 0x56, 0x3A, 0x00, 0x00,
    };

    try avl_io_element_parser.encodeBin(input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "decodeBin should write to the byte buffer a valid codec 8 byte array" {
    const allocator = std.testing.allocator;

    const data_to_decode = &[_]u8{
        0x01, 0x05, 0x02, 0x15, 0x03, 0x01, 0x01, 0x01, 0x42, 0x5E, 0x0F, 0x01,
        0xF1, 0x00, 0x00, 0x60, 0x1A, 0x01, 0x4E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
    };

    var buffer = try ByteBuffer.initBuffer(allocator, data_to_decode);
    defer buffer.deinit();
    buffer.resetPosition();

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    defer n1_elements.deinit();

    try n1_elements.put(0x15, [1]u8{0x03});
    try n1_elements.put(0x01, [1]u8{0x01});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    defer n2_elements.deinit();

    try n2_elements.put(0x42, [2]u8{ 0x5E, 0x0F });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    defer n4_elements.deinit();

    try n4_elements.put(0xf1, [4]u8{ 0x00, 0x00, 0x60, 0x1A });

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    defer n8_elements.deinit();

    try n8_elements.put(0x4E, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 });

    const expected: *const AvlIoElement = &.{
        .codec_id = CodecId.Codec8,
        .event_io_id = 0x01,
        .number_of_total_io = 0x05,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
    };
    var actual = try avl_io_element_parser.decodeBin(allocator, &buffer, CodecId.Codec8);
    defer actual.deinit();

    try std.testing.expectEqualSlices(u8, data_to_decode, buffer.array());
    try std.testing.expectEqual(expected.*.codec_id, actual.codec_id);
    try std.testing.expectEqual(expected.*.event_io_id, actual.event_io_id);
    try std.testing.expectEqual(expected.*.number_of_total_io, actual.number_of_total_io);
    try std.testing.expectEqual(expected.*.n1_elements.?.count(), actual.n1_elements.?.count());
    try std.testing.expectEqualSlices(u16, expected.*.n1_elements.?.keys(), actual.n1_elements.?.keys());
    try std.testing.expectEqualSlices([1]u8, expected.*.n1_elements.?.values(), actual.n1_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n2_elements.?.keys(), actual.n2_elements.?.keys());
    try std.testing.expectEqualSlices([2]u8, expected.*.n2_elements.?.values(), actual.n2_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n4_elements.?.keys(), actual.n4_elements.?.keys());
    try std.testing.expectEqualSlices([4]u8, expected.*.n4_elements.?.values(), actual.n4_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n8_elements.?.keys(), actual.n8_elements.?.keys());
    try std.testing.expectEqualSlices([8]u8, expected.*.n8_elements.?.values(), actual.n8_elements.?.values());
}

test "decodeBin should write to the byte buffer a valid codec 8e byte array" {
    const allocator = std.testing.allocator;

    const data_to_decode = &[_]u8{
        0x00, 0x01, 0x00, 0x05, 0x00, 0x01, 0x00, 0x01, 0x01, 0x00, 0x01, 0x00, 0x11,
        0x00, 0x1D, 0x00, 0x01, 0x00, 0x10, 0x01, 0x5E, 0x2C, 0x88, 0x00, 0x02, 0x00,
        0x0B, 0x00, 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A, 0x00, 0x0E, 0x00, 0x00,
        0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A, 0x00, 0x00,
    };

    var buffer = try ByteBuffer.initBuffer(allocator, data_to_decode);
    defer buffer.deinit();
    buffer.resetPosition();

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    defer n1_elements.deinit();

    try n1_elements.put(0x0001, [1]u8{0x01});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    defer n2_elements.deinit();

    try n2_elements.put(0x0011, [2]u8{ 0x00, 0x1D });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    defer n4_elements.deinit();

    try n4_elements.put(0x0010, [4]u8{ 0x01, 0x5E, 0x2C, 0x88 });

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    defer n8_elements.deinit();

    try n8_elements.put(0x000B, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A });
    try n8_elements.put(0x000E, [8]u8{ 0x00, 0x00, 0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A });

    var nx_elements = std.AutoArrayHashMap(u16, []const u8).init(allocator);
    defer nx_elements.deinit();

    const expected: *const AvlIoElement = &.{
        .codec_id = CodecId.Codec8Extended,
        .event_io_id = 0x0001,
        .number_of_total_io = 0x0005,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
        .nx_elements = nx_elements,
    };
    var actual = try avl_io_element_parser.decodeBin(allocator, &buffer, CodecId.Codec8Extended);
    defer actual.deinit();

    try std.testing.expectEqualSlices(u8, data_to_decode, buffer.array());
    try std.testing.expectEqual(expected.*.codec_id, actual.codec_id);
    try std.testing.expectEqual(expected.*.event_io_id, actual.event_io_id);
    try std.testing.expectEqual(expected.*.number_of_total_io, actual.number_of_total_io);
    try std.testing.expectEqual(expected.*.n1_elements.?.count(), actual.n1_elements.?.count());
    try std.testing.expectEqualSlices(u16, expected.*.n1_elements.?.keys(), actual.n1_elements.?.keys());
    try std.testing.expectEqualSlices([1]u8, expected.*.n1_elements.?.values(), actual.n1_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n2_elements.?.keys(), actual.n2_elements.?.keys());
    try std.testing.expectEqualSlices([2]u8, expected.*.n2_elements.?.values(), actual.n2_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n4_elements.?.keys(), actual.n4_elements.?.keys());
    try std.testing.expectEqualSlices([4]u8, expected.*.n4_elements.?.values(), actual.n4_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n8_elements.?.keys(), actual.n8_elements.?.keys());
    try std.testing.expectEqualSlices([8]u8, expected.*.n8_elements.?.values(), actual.n8_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.nx_elements.?.keys(), actual.nx_elements.?.keys());
    try std.testing.expectEqualSlices([]const u8, expected.*.nx_elements.?.values(), actual.nx_elements.?.values());
}

test "decodeBin should write to the byte buffer a valid codec 16 byte array" {
    const allocator = std.testing.allocator;

    const data_to_decode = &[_]u8{
        0x00, 0x0B, 0x05, 0x04, 0x02, 0x00, 0x01, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00,
        0x0B, 0x00, 0x26, 0x00, 0x42, 0x56, 0x3A, 0x00, 0x00,
    };

    var buffer = try ByteBuffer.initBuffer(allocator, data_to_decode);
    defer buffer.deinit();
    buffer.resetPosition();

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var n1_elements = std.AutoArrayHashMap(u16, [1]u8).init(allocator);
    defer n1_elements.deinit();

    try n1_elements.put(0x0001, [1]u8{0x00});
    try n1_elements.put(0x0003, [1]u8{0x00});

    var n2_elements = std.AutoArrayHashMap(u16, [2]u8).init(allocator);
    defer n2_elements.deinit();

    try n2_elements.put(0x000B, [2]u8{ 0x00, 0x26 });
    try n2_elements.put(0x0042, [2]u8{ 0x56, 0x3A });

    var n4_elements = std.AutoArrayHashMap(u16, [4]u8).init(allocator);
    defer n4_elements.deinit();

    var n8_elements = std.AutoArrayHashMap(u16, [8]u8).init(allocator);
    defer n8_elements.deinit();

    const expected: *const AvlIoElement = &.{
        .codec_id = CodecId.Codec16,
        .event_io_id = 0x000B,
        .number_of_total_io = 0x04,
        .generation_type = .On_Change,
        .n1_elements = n1_elements,
        .n2_elements = n2_elements,
        .n4_elements = n4_elements,
        .n8_elements = n8_elements,
    };
    var actual = try avl_io_element_parser.decodeBin(allocator, &buffer, CodecId.Codec16);
    defer actual.deinit();

    try std.testing.expectEqualSlices(u8, data_to_decode, buffer.array());
    try std.testing.expectEqual(expected.*.codec_id, actual.codec_id);
    try std.testing.expectEqual(expected.*.event_io_id, actual.event_io_id);
    try std.testing.expectEqual(expected.*.number_of_total_io, actual.number_of_total_io);
    try std.testing.expectEqual(expected.*.n1_elements.?.count(), actual.n1_elements.?.count());
    try std.testing.expectEqualSlices(u16, expected.*.n1_elements.?.keys(), actual.n1_elements.?.keys());
    try std.testing.expectEqualSlices([1]u8, expected.*.n1_elements.?.values(), actual.n1_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n2_elements.?.keys(), actual.n2_elements.?.keys());
    try std.testing.expectEqualSlices([2]u8, expected.*.n2_elements.?.values(), actual.n2_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n4_elements.?.keys(), actual.n4_elements.?.keys());
    try std.testing.expectEqualSlices([4]u8, expected.*.n4_elements.?.values(), actual.n4_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.*.n8_elements.?.keys(), actual.n8_elements.?.keys());
    try std.testing.expectEqualSlices([8]u8, expected.*.n8_elements.?.values(), actual.n8_elements.?.values());
}
