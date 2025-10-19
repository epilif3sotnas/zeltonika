// std
const std = @import("std");


test "Root of unit tests" {
    // AVL IO Module
    _ = @import("internal/handler/transport/avl/io/avl_io_elment_parser.zig");

    // CRC Module
    _ = @import("internal/handler/transport/crc/crc.zig");

    // Byte Byter Module
    _ = @import("internal/utils/byte_buffer.zig");
}
