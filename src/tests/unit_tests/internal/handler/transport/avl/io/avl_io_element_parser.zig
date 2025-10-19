// std
const std = @import("std");

// internal
const AvlIoElementParser = @import("../../../../../../../internal/handler/transport/avl/io/AvlIoElementParser.zig").AvlIoElementParser;
const ByteBuffer = @import("../../../../../../../internal/utils/ByteBuffer.zig").ByteBuffer;
const AvlIoElement = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;
const AvlIoElementParserHelper = @import("avl_io_element_parser_helper.zig");


test "encodeBin should write to the byte buffer a valid codec 8 byte array" {
    const allocator = std.testing.allocator;

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    var input = try AvlIoElementParserHelper.CODEC_8_AVL_IO_ELEMENT(allocator);
    defer input.deinit();

    const expected = AvlIoElementParserHelper.CODEC_8_BYTE_ARRAY;

    try avl_io_element_parser.encodeBin(&input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "encodeBin should write to the byte buffer a valid codec 8e byte array" {
    const allocator = std.testing.allocator;

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    var input = try AvlIoElementParserHelper.CODEC_8E_AVL_IO_ELEMENT(allocator);
    defer input.deinit();

    const expected = AvlIoElementParserHelper.CODEC_8E_BYTE_ARRAY;

    try avl_io_element_parser.encodeBin(&input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "encodeBin should write to the byte buffer a valid codec 16 byte array" {
    const allocator = std.testing.allocator;

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    var input = try AvlIoElementParserHelper.CODEC_16_AVL_IO_ELEMENT(allocator);
    defer input.deinit();

    const expected = AvlIoElementParserHelper.CODEC_16_BYTE_ARRAY;

    try avl_io_element_parser.encodeBin(&input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "decodeBin should write to the byte buffer a valid codec 8 byte array" {
    const allocator = std.testing.allocator;

    const data_to_decode = AvlIoElementParserHelper.CODEC_8_BYTE_ARRAY;

    var buffer = try ByteBuffer.initBuffer(allocator, data_to_decode);
    defer buffer.deinit();
    buffer.resetPosition();

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var expected = try AvlIoElementParserHelper.CODEC_8_AVL_IO_ELEMENT(allocator);
    defer expected.deinit();
    var actual = try avl_io_element_parser.decodeBin(allocator, &buffer, CodecId.Codec8);
    defer actual.deinit();

    try std.testing.expectEqualSlices(u8, data_to_decode, buffer.array());
    try std.testing.expectEqual(expected.codec_id, actual.codec_id);
    try std.testing.expectEqual(expected.event_io_id, actual.event_io_id);
    try std.testing.expectEqual(expected.number_of_total_io, actual.number_of_total_io);
    try std.testing.expectEqual(expected.n1_elements.?.count(), actual.n1_elements.?.count());
    try std.testing.expectEqualSlices(u16, expected.n1_elements.?.keys(), actual.n1_elements.?.keys());
    try std.testing.expectEqualSlices([1]u8, expected.n1_elements.?.values(), actual.n1_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n2_elements.?.keys(), actual.n2_elements.?.keys());
    try std.testing.expectEqualSlices([2]u8, expected.n2_elements.?.values(), actual.n2_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n4_elements.?.keys(), actual.n4_elements.?.keys());
    try std.testing.expectEqualSlices([4]u8, expected.n4_elements.?.values(), actual.n4_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n8_elements.?.keys(), actual.n8_elements.?.keys());
    try std.testing.expectEqualSlices([8]u8, expected.n8_elements.?.values(), actual.n8_elements.?.values());
}

test "decodeBin should write to the byte buffer a valid codec 8e byte array" {
    const allocator = std.testing.allocator;

    const data_to_decode = AvlIoElementParserHelper.CODEC_8E_BYTE_ARRAY;

    var buffer = try ByteBuffer.initBuffer(allocator, data_to_decode);
    defer buffer.deinit();
    buffer.resetPosition();

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var expected = try AvlIoElementParserHelper.CODEC_8E_AVL_IO_ELEMENT(allocator);
    defer expected.deinit();
    var actual = try avl_io_element_parser.decodeBin(allocator, &buffer, CodecId.Codec8Extended);
    defer actual.deinit();

    try std.testing.expectEqualSlices(u8, data_to_decode, buffer.array());
    try std.testing.expectEqual(expected.codec_id, actual.codec_id);
    try std.testing.expectEqual(expected.event_io_id, actual.event_io_id);
    try std.testing.expectEqual(expected.number_of_total_io, actual.number_of_total_io);
    try std.testing.expectEqual(expected.n1_elements.?.count(), actual.n1_elements.?.count());
    try std.testing.expectEqualSlices(u16, expected.n1_elements.?.keys(), actual.n1_elements.?.keys());
    try std.testing.expectEqualSlices([1]u8, expected.n1_elements.?.values(), actual.n1_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n2_elements.?.keys(), actual.n2_elements.?.keys());
    try std.testing.expectEqualSlices([2]u8, expected.n2_elements.?.values(), actual.n2_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n4_elements.?.keys(), actual.n4_elements.?.keys());
    try std.testing.expectEqualSlices([4]u8, expected.n4_elements.?.values(), actual.n4_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n8_elements.?.keys(), actual.n8_elements.?.keys());
    try std.testing.expectEqualSlices([8]u8, expected.n8_elements.?.values(), actual.n8_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.nx_elements.?.keys(), actual.nx_elements.?.keys());
    try std.testing.expectEqualSlices([]const u8, expected.nx_elements.?.values(), actual.nx_elements.?.values());
}

test "decodeBin should write to the byte buffer a valid codec 16 byte array" {
    const allocator = std.testing.allocator;

    const data_to_decode = AvlIoElementParserHelper.CODEC_16_BYTE_ARRAY;

    var buffer = try ByteBuffer.initBuffer(allocator, data_to_decode);
    defer buffer.deinit();
    buffer.resetPosition();

    const avl_io_element_parser = AvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    var expected = try AvlIoElementParserHelper.CODEC_16_AVL_IO_ELEMENT(allocator);
    defer expected.deinit();
    var actual = try avl_io_element_parser.decodeBin(allocator, &buffer, CodecId.Codec16);
    defer actual.deinit();

    try std.testing.expectEqualSlices(u8, data_to_decode, buffer.array());
    try std.testing.expectEqual(expected.codec_id, actual.codec_id);
    try std.testing.expectEqual(expected.event_io_id, actual.event_io_id);
    try std.testing.expectEqual(expected.number_of_total_io, actual.number_of_total_io);
    try std.testing.expectEqual(expected.n1_elements.?.count(), actual.n1_elements.?.count());
    try std.testing.expectEqualSlices(u16, expected.n1_elements.?.keys(), actual.n1_elements.?.keys());
    try std.testing.expectEqualSlices([1]u8, expected.n1_elements.?.values(), actual.n1_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n2_elements.?.keys(), actual.n2_elements.?.keys());
    try std.testing.expectEqualSlices([2]u8, expected.n2_elements.?.values(), actual.n2_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n4_elements.?.keys(), actual.n4_elements.?.keys());
    try std.testing.expectEqualSlices([4]u8, expected.n4_elements.?.values(), actual.n4_elements.?.values());
    try std.testing.expectEqualSlices(u16, expected.n8_elements.?.keys(), actual.n8_elements.?.keys());
    try std.testing.expectEqualSlices([8]u8, expected.n8_elements.?.values(), actual.n8_elements.?.values());
}
