// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const IAvlBinParser = @import("../../../../../../../internal/handler/transport/avl/bin/avl_bin_parser.zig").IAvlBinParser;
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;
const Priority = @import("../../../../../../../public/avl_data/avl_data_array.zig").Priority;
const AvlData = @import("../../../../../../../public/avl_data/avl_data_array.zig").AvlData;
const ByteBuffer = @import("../../../../../../../internal/utils/ByteBuffer.zig");
const HelperNoOpAvlIoElementParser = @import("../io/HelperNoOpAvlIoElementParser.zig");


const HelperNoOpAvlBinParser = @This();

_avl_io_element_parser: HelperNoOpAvlIoElementParser = HelperNoOpAvlIoElementParser.init(),

pub fn init(_: Allocator) !HelperNoOpAvlBinParser {
    const helper_no_op_avl_bin_parser = HelperNoOpAvlBinParser{};
    comptime IAvlBinParser.validation.satisfiedBy(@TypeOf(helper_no_op_avl_bin_parser));

    return helper_no_op_avl_bin_parser;
}

pub fn deinit(_: *const HelperNoOpAvlBinParser) void {}

pub fn encodeBin(_: *const HelperNoOpAvlBinParser, _: *const AvlData, _: *ByteBuffer) !void {}

pub fn decodeBin(self: *const HelperNoOpAvlBinParser, allocator: Allocator, byte_buffer: *ByteBuffer, codec_id: CodecId) !AvlData {
    return .{
        .timestamp = 0,
        .priority = Priority.Low,
        .gps_element = .{
            .longitude = 0.0,
            .latitude = 0.0,
            .altitude = 0,
            .angle = 0,
            .satellites = 0,
            .speed = 0,
        },
        .io_element = try self._avl_io_element_parser.decodeBin(allocator, byte_buffer, codec_id),
    };
}
