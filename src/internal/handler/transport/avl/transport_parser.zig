// std
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

// internal
const TcpAvlData = @import("../../../../public/avl_data/tcp.zig").TcpAvlData;
const AvlDataPacketHeader = @import("../../../../public/avl_data/tcp.zig").AvlDataPacketHeader;
const Crc16 = @import("../../../../public/avl_data/tcp.zig").Crc16;
const UdpAvlData = @import("../../../../public/avl_data/udp.zig").UdpAvlData;
const AvlData = @import("../../../../public/avl_data/avl_data_array.zig").AvlData;
const CodecId = @import("../../../../public/avl_data/avl_data_array.zig").CodecId;
const ByteBuffer = @import("../../../utils/ByteBuffer.zig").ByteBuffer;
const IAvlBinParser = @import("bin/avl_bin_parser.zig").IAvlBinParser;
const AvlBinParser = @import("bin/avl_bin_parser.zig").AvlBinParser;
const ICrc = @import("../crc/crc.zig").ICrc;
const Crc = @import("../crc/crc.zig").Crc;

// external
const Interface = @import("interface").Interface;


pub const ITransportParser = Interface(.{
    .deinit = fn() void,
    .encodeTcp = fn (tcp_data: *const TcpAvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void,
    .encodeUdp = fn (udp_data: *const UdpAvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void,
    .decodeTcp = fn (allocator: Allocator, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!TcpAvlData,
    .decodeUdp = fn (allocator: Allocator, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!UdpAvlData,
}, null);


pub fn TransportParser() type {
    return TransportParserWithType(AvlBinParser(), Crc);
}

pub fn TransportParserWithType(comptime IAvlBinParserT: type, comptime ICrcT: type) type {
    return struct {
        const Self = @This();

        _avl_bin_parser: IAvlBinParser,
        _crc: ICrc,
        _allocator: Allocator,


        pub fn init(allocator: Allocator) Allocator.Error!Self {
            comptime ITransportParser.validation.satisfiedBy(Self);
            comptime IAvlBinParser.validation.satisfiedBy(IAvlBinParserT);
            comptime ICrc.validation.satisfiedBy(ICrcT);

            const avl_bin_parser = try allocator.create(IAvlBinParserT);
            avl_bin_parser.* = try IAvlBinParserT.init(allocator);

            const crc = try allocator.create(ICrcT);
            crc.* = ICrcT.init();

            return .{
                ._avl_bin_parser = IAvlBinParser.from(avl_bin_parser),
                ._crc = ICrc.from(crc),
                ._allocator = allocator,
            };
        }

        pub fn deinit(self: *const Self) void {
            self._avl_bin_parser.vtable.deinit(self._avl_bin_parser.ptr);
            self._crc.vtable.deinit(self._crc.ptr);

            const avl_bin_parser_ptr: *IAvlBinParserT = @ptrCast(@alignCast(self._avl_bin_parser.ptr));
            self._allocator.destroy(avl_bin_parser_ptr);

            const crc_ptr: *ICrcT = @ptrCast(@alignCast(self._crc.ptr));
            self._allocator.destroy(crc_ptr);
        }

        pub fn encodeTcp(self: *const Self, tcp_data: *const TcpAvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
            try buffer.put(tcp_data.avl_data_packet_header);

            try buffer.put(tcp_data.avl_data_array.codec_id);
            const crc_start = buffer.position() - 1;

            try buffer.put(@as(u8, @intCast(tcp_data.avl_data_array.data.len)));

            for (tcp_data.avl_data_array.data) |avl_data| {
                try self.encodeBinAvlData(&avl_data, buffer);
            }

            try buffer.put(@as(u8, @intCast(tcp_data.avl_data_array.data.len)));
            try buffer.setNewPosition(crc_start);

            const crc = self.crcCalculate(buffer.arrayFromPosition());

            buffer.resetPositionLast();
            try buffer.put(@as(u32, @intCast(crc)));
        }

        fn crcCalculate(self: *const Self, data: []const u8) u16 {
            return self._crc.vtable.calculate(self._crc.ptr, data);
        }

        pub fn encodeUdp(self: *const Self, udp_data: *const UdpAvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
            try buffer.put(udp_data.udp_channel_header);
            try buffer.put(udp_data.avl_packet_header);
            try buffer.put(udp_data.avl_data_array.codec_id);
            try buffer.put(@as(u8, @intCast(udp_data.avl_data_array.data.len)));

            for (udp_data.avl_data_array.data) |avl_data| {
                try self.encodeBinAvlData(&avl_data, buffer);
            }

            try buffer.put(@as(u8, @intCast(udp_data.avl_data_array.data.len)));
        }

        fn encodeBinAvlData(self: *const Self, avl_data: *const AvlData, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!void {
            try self._avl_bin_parser.vtable.encodeBin(self._avl_bin_parser.ptr, avl_data, buffer);
        }

        pub fn decodeTcp(self: *const Self, allocator: Allocator, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!TcpAvlData {
            const avl_data_packet_header = try buffer.get(AvlDataPacketHeader);

            const codec_id = try buffer.get(CodecId);
            const crc_start = buffer.position() - 1;

            const avl_data_num_elements = try buffer.get(u8);

            var avl_data_elements = ArrayList(AvlData).empty;
            var idx: usize = 1;
            while (idx <= avl_data_num_elements) : (idx += 1) {
                const avl_data = try self.decodeBinAvlData(allocator, buffer, codec_id);
                try avl_data_elements.append(allocator, avl_data);
            }

            _ = try buffer.get(u8);
            const crc = try buffer.get(Crc16);

            try buffer.setNewPosition(crc_start);
            const crc_calculated = self.crcCalculate(buffer.arrayFromPosition());
            buffer.resetPositionLast();

            return .{
                .avl_data_packet_header = avl_data_packet_header,
                .avl_data_array = .{
                    .codec_id = codec_id,
                    .data = avl_data_elements.items,
                },
                .crc_16 = crc,
                .response = .{
                    .response = avl_data_num_elements,
                },
            };
        }

        pub fn decodeUdp(self: *const Self, allocator: Allocator, buffer: *ByteBuffer) ByteBuffer.ByteBuferCombinedError!UdpAvlData {
            _ = self;
            _ = buffer;
            _ = allocator;

            return .{};
        }

        fn decodeBinAvlData(self: *const Self, allocator: Allocator, buffer: *ByteBuffer, codec_id: CodecId) ByteBuffer.ByteBuferCombinedError!AvlData {
            return try self._avl_bin_parser.vtable.decodeBin(self._avl_bin_parser.ptr, allocator, buffer, codec_id);
        }
    };
}
