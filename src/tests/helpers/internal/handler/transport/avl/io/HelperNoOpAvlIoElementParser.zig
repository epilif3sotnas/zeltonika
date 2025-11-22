// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const IAvlIoElementParser = @import("../../../../../../../internal/handler/transport/avl/io/avl_io_element_parser.zig").IAvlIoElementParser;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;
const AvlIoElement = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const ByteBuffer = @import("../../../../../../../internal/utils/ByteBuffer.zig");


const HelperNoOpAvlIoElementParser = @This();


pub fn init() HelperNoOpAvlIoElementParser {
    const helper_no_op_avl_io_element_parser = HelperNoOpAvlIoElementParser{};
    comptime IAvlIoElementParser.validation.satisfiedBy(@TypeOf(helper_no_op_avl_io_element_parser));

    return helper_no_op_avl_io_element_parser;
}

pub fn deinit(_: *const HelperNoOpAvlIoElementParser) void {}

pub fn encodeBin(_: *const HelperNoOpAvlIoElementParser, _: *const AvlIoElement, _: *ByteBuffer) !void {}

pub fn decodeBin(_: *const HelperNoOpAvlIoElementParser, _: Allocator, _: *ByteBuffer, _: CodecId) !AvlIoElement {
    return .{
        .codec_id = CodecId.Codec8,
        .event_io_id = 0x01,
        .number_of_total_io = 0x00,
    };
}
