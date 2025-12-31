// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const ICrc = @import("../../../../../../internal/handler/transport/crc/crc.zig").ICrc;


const HelperNoOpCrc = @This();


pub fn init() HelperNoOpCrc {
    const helper_no_op_crc = HelperNoOpCrc{};
    comptime ICrc.validation.satisfiedBy(@TypeOf(helper_no_op_crc));

    return helper_no_op_crc;
}

pub fn deinit(_: *const HelperNoOpCrc) void {}

pub fn calculate(_: *const HelperNoOpCrc, _: []const u8) u16 {
    return 0x13;
}

pub fn isValid(_: *const HelperNoOpCrc, _: []const u8, _: u16) bool {
    return true;
}
