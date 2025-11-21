// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlIoElement = @import("../../../../../public/avl_data/avl_data_array.zig").AvlIoElement;
const CodecId = @import("../../../../../public/avl_data/avl_data_array.zig").CodecId;
const ByteBuffer = @import("../../../../utils/ByteBuffer.zig").ByteBuffer;

// external
const Inteface = @import("interface").Interface;


pub const IAvlIoElementParser = Inteface(.{
    .deinit = fn() void,
    .encodeBin = fn (avl_io_element: *const AvlIoElement, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void,
    .decodeBin = fn (allocator: Allocator, buffer: *ByteBuffer, codec_id: CodecId) ByteBuffer.ByteBuferCombinedError!AvlIoElement,
}, null);
