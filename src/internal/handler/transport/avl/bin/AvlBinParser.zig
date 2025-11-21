// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const IAvlBinParser = @import("avl_bin_parser.zig").IAvlBinParser;
const AvlBinData = @import("models/AvlBinData.zig").AvlBinData;
const IAvlIoElementParser = @import("../io/avl_io_element_parser.zig").IAvlIoElementParser;
const AvlIoElementParser = @import("../io/AvlIoElementParser.zig").AvlIoElementParser;
const ByteBuffer = @import("../../../../utils/ByteBuffer.zig");
const coordinate_math = @import("../../../../utils/coordinate_math.zig");
const AvlData = @import("../../../../../public/avl_data/avl_data_array.zig").AvlData;
const AvlIoElement = @import("../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../public/avl_data/avl_data_array.zig").CodecId;


pub const AvlBinParser = @This();


_avl_io_element_parser: IAvlIoElementParser,


pub fn init() AvlBinParser {
    var avl_io_element_parser = AvlIoElementParser{};
    comptime IAvlIoElementParser.validation.satisfiedBy(@TypeOf(avl_io_element_parser));

    const avl_bin_parser = AvlBinParser{ ._avl_io_element_parser = IAvlIoElementParser.from(&avl_io_element_parser) };
    comptime IAvlBinParser.validation.satisfiedBy(@TypeOf(avl_bin_parser));

    return avl_bin_parser;
}

pub fn initTest(avl_io_element_parser: IAvlIoElementParser) AvlBinParser {
    const avl_bin_parser = AvlBinParser{ ._avl_io_element_parser = avl_io_element_parser };
    comptime IAvlBinParser.validation.satisfiedBy(@TypeOf(avl_bin_parser));

    return avl_bin_parser;
}

pub fn deinit(self: *const AvlBinParser) void {
    self._avl_io_element_parser.vtable.deinit(self._avl_io_element_parser.ptr);
}

pub fn encodeBin(self: *const AvlBinParser, avl_data: *const AvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
    const avl_bin_data = AvlBinData {
        .timestamp = avl_data.timestamp,
        .priority = avl_data.priority,
        .gps_element = .{
            .latitude = coordinate_math.convertCoordinateToTeltonikaFormat(avl_data.gps_element.latitude),
            .longitude = coordinate_math.convertCoordinateToTeltonikaFormat(avl_data.gps_element.longitude),
            .altitude = avl_data.gps_element.altitude,
            .angle = avl_data.gps_element.angle,
            .satellites = avl_data.gps_element.satellites,
            .speed = avl_data.gps_element.speed,
        },
    };

    try buffer.put(avl_bin_data);

    try self.encodeBinIoElement(&avl_data.io_element, buffer);
}

fn encodeBinIoElement(self: *const AvlBinParser, avl_io_element: *const AvlIoElement, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
    try self._avl_io_element_parser.vtable.encodeBin(self._avl_io_element_parser.ptr, avl_io_element, buffer);
}

pub fn decodeBin(self: *const AvlBinParser, allocator: Allocator, buffer: *ByteBuffer, codec_id: CodecId) ByteBuffer.ByteBuferCombinedError!AvlData {
    const avl_data = try buffer.get(AvlBinData);
    const avl_io_element = try self.decodeBinIoElement(allocator, buffer, codec_id);

    return .{
        .timestamp = avl_data.timestamp,
        .priority = avl_data.priority,
        .gps_element = .{
            .latitude = coordinate_math.convertTeltonikaFormatToFloat(avl_data.gps_element.latitude),
            .longitude = coordinate_math.convertTeltonikaFormatToFloat(avl_data.gps_element.longitude),
            .altitude = avl_data.gps_element.altitude,
            .angle = avl_data.gps_element.angle,
            .satellites = avl_data.gps_element.satellites,
            .speed = avl_data.gps_element.speed,
        },
        .io_element = avl_io_element,
    };
}

fn decodeBinIoElement(
    self: *const AvlBinParser,
    allocator: Allocator,
    buffer: *ByteBuffer,
    codec_id: CodecId,
) ByteBuffer.ByteBuferCombinedError!AvlIoElement {
    return try self._avl_io_element_parser.vtable.decodeBin(self._avl_io_element_parser.ptr, allocator, buffer, codec_id);
}
