// std
const std = @import("std");


test "Root of unit tests" {
    // AVL Bin Module
    _ = @import("internal/handler/transport/avl/bin/test_avl_bin_parser.zig");

    // AVL IO Module
    _ = @import("internal/handler/transport/avl/io/test_avl_io_element_parser.zig");

    // CRC Module
    _ = @import("internal/handler/transport/crc/test_crc.zig");

    // Utils Module
    _ = @import("internal/utils/test_byte_buffer.zig");
    _ = @import("internal/utils/test_coordinate_math.zig");
}
