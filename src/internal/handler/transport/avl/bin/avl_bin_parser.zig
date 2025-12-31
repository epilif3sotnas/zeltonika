// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlBinData = @import("models/AvlBinData.zig").AvlBinData;
const IAvlIoElementParser = @import("../io/avl_io_element_parser.zig").IAvlIoElementParser;
const AvlIoElementParser = @import("../io/avl_io_element_parser.zig").AvlIoElementParser;
const ByteBuffer = @import("../../../../utils/ByteBuffer.zig");
const coordinate_math = @import("../../../../utils/coordinate_math.zig");
const AvlData = @import("../../../../../public/avl_data/avl_data_array.zig").AvlData;
const AvlIoElement = @import("../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../public/avl_data/avl_data_array.zig").CodecId;

// external
const Interface = @import("interface").Interface;


pub const IAvlBinParser = Interface(.{
    .deinit = fn() void,
    .encodeBin = fn (avl_data: *const AvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void,
    .decodeBin = fn (allocator: Allocator, buffer: *ByteBuffer, codec_id: CodecId) ByteBuffer.ByteBuferCombinedError!AvlData,
}, null);


pub fn AvlBinParser() type {
    return AvlBinParserWithType(AvlIoElementParser);
}

pub fn AvlBinParserWithType(comptime T: type) type {
    return struct {
        pub const Self = @This();


        _avl_io_element_parser: IAvlIoElementParser,
        _allocator: Allocator,


        pub fn init(allocator: Allocator) Allocator.Error!Self {
            comptime IAvlBinParser.validation.satisfiedBy(Self);
            comptime IAvlIoElementParser.validation.satisfiedBy(T);

            const avl_io_element_parser = try allocator.create(T);
            avl_io_element_parser.* = T.init();

            return .{
                ._avl_io_element_parser = IAvlIoElementParser.from(avl_io_element_parser),
                ._allocator = allocator,
            };
        }

        pub fn deinit(self: *const Self) void {
            self._avl_io_element_parser.vtable.deinit(self._avl_io_element_parser.ptr);

            const avl_io_element_parser_ptr: *T = @ptrCast(@alignCast(self._avl_io_element_parser.ptr));
            self._allocator.destroy(avl_io_element_parser_ptr);
        }

        pub fn encodeBin(self: *const Self, avl_data: *const AvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
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

        fn encodeBinIoElement(self: *const Self, avl_io_element: *const AvlIoElement, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
            try self._avl_io_element_parser.vtable.encodeBin(self._avl_io_element_parser.ptr, avl_io_element, buffer);
        }

        pub fn decodeBin(self: *const Self, allocator: Allocator, buffer: *ByteBuffer, codec_id: CodecId) ByteBuffer.ByteBuferCombinedError!AvlData {
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
            self: *const Self,
            allocator: Allocator,
            buffer: *ByteBuffer,
            codec_id: CodecId,
        ) ByteBuffer.ByteBuferCombinedError!AvlIoElement {
            return try self._avl_io_element_parser.vtable.decodeBin(self._avl_io_element_parser.ptr, allocator, buffer, codec_id);
        }
    };
}
