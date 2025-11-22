// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const AvlData = @import("../../../../../public/avl_data/avl_data_array.zig").AvlData;
const CodecId = @import("../../../../../public/avl_data/avl_data_array.zig").CodecId;
const ByteBuffer = @import("../../../../utils/ByteBuffer.zig").ByteBuffer;

// external
const Inteface = @import("interface").Interface;


pub const IAvlBinParser = Inteface(.{
    .deinit = fn() void,
    .encodeBin = fn (avl_data: *const AvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void,
    .decodeBin = fn (allocator: Allocator, buffer: *ByteBuffer, codec_id: CodecId) ByteBuffer.ByteBuferCombinedError!AvlData,
}, null);
