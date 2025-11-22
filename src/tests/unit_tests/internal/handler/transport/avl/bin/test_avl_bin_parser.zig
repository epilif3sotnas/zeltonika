// std
const std = @import("std");

// internal
const CodecId = @import("../../../../../../../public/avl_data/avl_data_array.zig").CodecId;
const ByteBuffer = @import("../../../../../../../internal/utils/ByteBuffer.zig");
const AvlBinParser = @import("../../../../../../../internal/handler/transport/avl/bin/AvlBinParser.zig").AvlBinParser;
const IAvlIoElementParser = @import("../../../../../../../internal/handler/transport/avl/io/avl_io_element_parser.zig").IAvlIoElementParser;
const HelperNoOpAvlIoElementParser = @import("../../../../../../helpers/internal/handler/transport/avl/io/HelperNoOpAvlIoElementParser.zig");
const HelperAvlData = @import("../../../../../../helpers/internal/handler/transport/avl/bin/helper_avl_data.zig");


test "AvlBinParser.init - smoke test" {
    const avl_bin_parser = AvlBinParser.init();
    defer avl_bin_parser.deinit();
}

test "AvlBinParser.encodeBin - should write to the buffer AVL Data" {
    const allocator = std.testing.allocator;

    var avl_io_element_parser = HelperNoOpAvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    const avl_bin_parser = AvlBinParser.initTest(IAvlIoElementParser.from(&avl_io_element_parser));
    defer avl_bin_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    var input = try HelperAvlData.AVL_DATA();

    const expected = HelperAvlData.BYTE_ARRAY;

    try avl_bin_parser.encodeBin(&input, &buffer);
    const actual = buffer.array();

    try std.testing.expectEqualSlices(u8, expected, actual);
}

test "AvlBinParser.decodeBin - should read from buffer the AVL Data" {
    const allocator = std.testing.allocator;

    var avl_io_element_parser = HelperNoOpAvlIoElementParser.init();
    defer avl_io_element_parser.deinit();

    const avl_bin_parser = AvlBinParser.initTest(IAvlIoElementParser.from(&avl_io_element_parser));
    defer avl_bin_parser.deinit();

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input = HelperAvlData.BYTE_ARRAY;
    try buffer.put(input);
    buffer.resetPosition();

    const expected = try HelperAvlData.AVL_DATA();
    const actual = try avl_bin_parser.decodeBin(allocator, &buffer, CodecId.Codec8);

    try std.testing.expectEqual(expected, actual);
}
