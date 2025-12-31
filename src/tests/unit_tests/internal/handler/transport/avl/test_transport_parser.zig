// std
const std = @import("std");
const testing = std.testing;
const allocator = testing.allocator;

// internal
const ByteBuffer = @import("../../../../../../internal/utils/ByteBuffer.zig");
const TransportParser = @import("../../../../../../internal/handler/transport/avl/transport_parser.zig").TransportParser;
const TransportParserWithType = @import("../../../../../../internal/handler/transport/avl/transport_parser.zig").TransportParserWithType;
const HelperTransportData = @import("../../../../../helpers/internal/handler/transport/avl/helper_transport_parser.zig");
const HelperNoOpAvlBinParser = @import("../../../../../helpers/internal/handler/transport/avl/bin/HelperNoOpAvlBinParser.zig");
const HelperNoOpCrc = @import("../../../../../helpers/internal/handler/transport/crc/HelperNoOpCrc.zig");


test "TransportParser.init - smoke test" {
    const transport_parser = try TransportParser().init(allocator);
    defer transport_parser.deinit();
}

test "TransportParser.encodeTcp - should write to the buffer TCP AVL Data" {
    const transport_parser = try TransportParserWithType(HelperNoOpAvlBinParser, HelperNoOpCrc)
        .init(allocator);
    defer transport_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    var input = HelperTransportData.TCP_DATA();

    const expected = HelperTransportData.TCP_DATA_BYTE_ARRAY;

    try transport_parser.encodeTcp(&input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "TransportParser.encodeUdp - should write to the buffer Udp AVL Data" {
    const transport_parser = try TransportParserWithType(HelperNoOpAvlBinParser, HelperNoOpCrc)
        .init(allocator);
    defer transport_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    var input = HelperTransportData.UDP_DATA();

    const expected = HelperTransportData.UDP_DATA_BYTE_ARRAY;

    try transport_parser.encodeUdp(&input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}
