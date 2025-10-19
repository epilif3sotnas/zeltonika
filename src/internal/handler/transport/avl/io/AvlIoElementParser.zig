// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlIoCodec8 = @import("models/AvlIoCodec8.zig").AvlIoCodec8;
const AvlIoCodec8e = @import("models/AvlIoCodec8e.zig").AvlIoCodec8e;
const AvlIoCodec16 = @import("models/AvlIoCodec16.zig").AvlIoCodec16;
const AvlIoElement = @import("../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../public/avl_data/avl_data_array.zig").CodecId;
const ByteBuffer = @import("../../../../utils/ByteBuffer.zig").ByteBuffer;


pub const AvlIoElementParser = @This();


const AvlIoType = enum {
    Codec8, Codec8e, Codec16,
};

const AvlIo = union(AvlIoType) {
    Codec8: AvlIoCodec8,
    Codec8e: AvlIoCodec8e,
    Codec16: AvlIoCodec16,
};


pub fn init() AvlIoElementParser {
    return .{};
}

pub fn deinit(_: *const AvlIoElementParser) void {}

pub fn encodeBin(self: *const AvlIoElementParser, avl_io_element: *const AvlIoElement, buffer: *ByteBuffer) !void {
    const avl_io: *const AvlIo = switch (avl_io_element.codec_id) {
        CodecId.Codec8 => &.{
            .Codec8 = .{
                .event_io_id = @intCast(avl_io_element.event_io_id),
                .number_of_total_io = @intCast(avl_io_element.number_of_total_io),
            }
        },
        CodecId.Codec8Extended => &.{
            .Codec8e = .{
                .event_io_id = @intCast(avl_io_element.event_io_id),
                .number_of_total_io = @intCast(avl_io_element.number_of_total_io),
            }
        },
        CodecId.Codec16 => &.{
            .Codec16 = .{
                .event_io_id = @intCast(avl_io_element.event_io_id),
                .number_of_total_io = @intCast(avl_io_element.number_of_total_io),
                .generation_type = avl_io_element.generation_type.?,
            }
        },
    };

    switch (avl_io_element.codec_id) {
        CodecId.Codec8 => try self.encodeBinCodec8(avl_io_element, avl_io, buffer),
        CodecId.Codec8Extended => try self.encodeBinCodec8e(avl_io_element, avl_io, buffer),
        CodecId.Codec16 => try self.encodeBinCodec16(avl_io_element, avl_io, buffer),
    }
}

fn encodeBinCodec8(self: *const AvlIoElementParser, avl_io_element: *const AvlIoElement, avl_io: *const AvlIo, buffer: *ByteBuffer) !void {
    try self.encodeBinIoElementCommon(avl_io, buffer);
    try self.encodeBinNIoElements(u8, u8, [1]u8, avl_io_element.n1_elements.?, buffer);
    try self.encodeBinNIoElements(u8, u8, [2]u8, avl_io_element.n2_elements.?, buffer);
    try self.encodeBinNIoElements(u8, u8, [4]u8, avl_io_element.n4_elements.?, buffer);
    try self.encodeBinNIoElements(u8, u8, [8]u8, avl_io_element.n8_elements.?, buffer);
}

fn encodeBinCodec8e(self: *const AvlIoElementParser, avl_io_element: *const AvlIoElement, avl_io: *const AvlIo, buffer: *ByteBuffer) !void {
    try self.encodeBinIoElementCommon(avl_io, buffer);
    try self.encodeBinNIoElements(u16, u16, [1]u8, avl_io_element.n1_elements.?, buffer);
    try self.encodeBinNIoElements(u16, u16, [2]u8, avl_io_element.n2_elements.?, buffer);
    try self.encodeBinNIoElements(u16, u16, [4]u8, avl_io_element.n4_elements.?, buffer);
    try self.encodeBinNIoElements(u16, u16, [8]u8, avl_io_element.n8_elements.?, buffer);
    try self.encodeBinNIoElements(u16, u16, []const u8, avl_io_element.nx_elements.?, buffer);
}

fn encodeBinCodec16(self: *const AvlIoElementParser, avl_io_element: *const AvlIoElement, avl_io: *const AvlIo, buffer: *ByteBuffer) !void {
    try self.encodeBinIoElementCommon(avl_io, buffer);
    try self.encodeBinNIoElements(u8, u16, [1]u8, avl_io_element.n1_elements.?, buffer);
    try self.encodeBinNIoElements(u8, u16, [2]u8, avl_io_element.n2_elements.?, buffer);
    try self.encodeBinNIoElements(u8, u16, [4]u8, avl_io_element.n4_elements.?, buffer);
    try self.encodeBinNIoElements(u8, u16, [8]u8, avl_io_element.n8_elements.?, buffer);
}

fn encodeBinIoElementCommon(_: *const AvlIoElementParser, avl_io: *const AvlIo, buffer: *ByteBuffer) !void {
    switch (avl_io.*) {
        .Codec8 => try buffer.put(avl_io.Codec8),
        .Codec8e => try buffer.put(avl_io.Codec8e),
        .Codec16 => try buffer.put(avl_io.Codec16),
    }
}

fn encodeBinNIoElements(
    _: *const AvlIoElementParser,
    comptime N: type,
    comptime K: type,
    comptime V: type,
    avl_n_element: std.AutoArrayHashMap(u16, V),
    buffer: *ByteBuffer,
) !void {
    try buffer.put(@as(N, @intCast(avl_n_element.count())));

    if (avl_n_element.count() > 0) {
        var iterator = avl_n_element.iterator();

        while (iterator.next()) |entry| {
            try buffer.put(@as(K, @intCast(entry.key_ptr.*)));
            try buffer.put(entry.value_ptr);
        }
    }
}

pub fn decodeBin(
    self: *const AvlIoElementParser,
    allocator: Allocator,
    buffer: *ByteBuffer,
    codec_id: CodecId,
) !AvlIoElement {
    return switch (codec_id) {
        .Codec8 => self.decodeBinCodec8(allocator, buffer, codec_id),
        .Codec8Extended => self.decodeBinCodec8e(allocator, buffer, codec_id),
        .Codec16 => self.decodeBinCodec16(allocator, buffer, codec_id),
    };
}

fn decodeBinCodec8(
    self: *const AvlIoElementParser,
    allocator: Allocator,
    buffer: *ByteBuffer,
    codec_id: CodecId,
) !AvlIoElement {
    const io_element_common = try self.decodeBinIoElementCommon(buffer, codec_id);
    return .{
        .codec_id = codec_id,
        .event_io_id = io_element_common.Codec8.event_io_id,
        .number_of_total_io = io_element_common.Codec8.number_of_total_io,
        .n1_elements = try self.decodeBinNIoElement(allocator, u8, u8, [1]u8, buffer),
        .n2_elements = try self.decodeBinNIoElement(allocator, u8, u8, [2]u8, buffer),
        .n4_elements = try self.decodeBinNIoElement(allocator, u8, u8, [4]u8, buffer),
        .n8_elements = try self.decodeBinNIoElement(allocator, u8, u8, [8]u8, buffer),
    };
}

fn decodeBinCodec8e(
    self: *const AvlIoElementParser,
    allocator: Allocator,
    buffer: *ByteBuffer,
    codec_id: CodecId,
) !AvlIoElement {
    const io_element_common = try self.decodeBinIoElementCommon(buffer, codec_id);
    return .{
        .codec_id = codec_id,
        .event_io_id = io_element_common.Codec8e.event_io_id,
        .number_of_total_io = io_element_common.Codec8e.number_of_total_io,
        .n1_elements = try self.decodeBinNIoElement(allocator, u16, u16, [1]u8, buffer),
        .n2_elements = try self.decodeBinNIoElement(allocator, u16, u16, [2]u8, buffer),
        .n4_elements = try self.decodeBinNIoElement(allocator, u16, u16, [4]u8, buffer),
        .n8_elements = try self.decodeBinNIoElement(allocator, u16, u16, [8]u8, buffer),
        .nx_elements = try self.decodeBinNIoElement(allocator, u16, u16, []const u8, buffer),
    };
}

fn decodeBinCodec16(
    self: *const AvlIoElementParser,
    allocator: Allocator,
    buffer: *ByteBuffer,
    codec_id: CodecId,
) !AvlIoElement {
    const io_element_common = try self.decodeBinIoElementCommon(buffer, codec_id);
    return .{
        .codec_id = codec_id,
        .event_io_id = io_element_common.Codec16.event_io_id,
        .generation_type = io_element_common.Codec16.generation_type,
        .number_of_total_io = io_element_common.Codec16.number_of_total_io,
        .n1_elements = try self.decodeBinNIoElement(allocator, u8, u16, [1]u8, buffer),
        .n2_elements = try self.decodeBinNIoElement(allocator, u8, u16, [2]u8, buffer),
        .n4_elements = try self.decodeBinNIoElement(allocator, u8, u16, [4]u8, buffer),
        .n8_elements = try self.decodeBinNIoElement(allocator, u8, u16, [8]u8, buffer),
    };
}

fn decodeBinIoElementCommon(_: *const AvlIoElementParser, buffer: *ByteBuffer, codec_id: CodecId) !AvlIo {
    return switch (codec_id) {
        .Codec8 => .{ .Codec8 = try buffer.get(AvlIoCodec8) },
        .Codec8Extended => .{ .Codec8e = try buffer.get(AvlIoCodec8e) },
        .Codec16 => .{ .Codec16 = try buffer.get(AvlIoCodec16) },
    };
}

fn decodeBinNIoElement(
    _: *const AvlIoElementParser,
    allocator: Allocator,
    comptime N: type,
    comptime K: type,
    comptime V: type,
    buffer: *ByteBuffer,
) !std.AutoArrayHashMap(u16, V) {
    var n_io_elements = std.AutoArrayHashMap(u16, V).init(allocator);

    const n_elements = try buffer.get(N);

    switch (n_elements) {
        0 => return n_io_elements,
        else => {
            var i: usize = 0;
            while (i < n_elements) : (i += 1) {
                const key = try buffer.get(K);
                const value = try buffer.get(V);
                try n_io_elements.put(@as(u16, @intCast(key)), value);
            }
            return n_io_elements;
        }
    }
}
