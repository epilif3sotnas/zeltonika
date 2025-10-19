// std
const std = @import("std");


pub const Crc = @This();


/// CRC16/IBM used by Teltonika
const TeltonikaCrc = std.hash.crc.Crc(
    u16,
    .{
        .polynomial = 0x8005,
        .initial = 0x0000,
        .reflect_input = true,
        .reflect_output = true,
        .xor_output = 0x0000,
    },
);


pub fn init() Crc {
    return .{};
}

pub fn deinit(_: *const Crc) void {}

pub fn calculate(_: *const Crc, data: []const u8) u16 {
    return TeltonikaCrc.hash(data);
}

pub fn isValid(self: *const Crc, data: []const u8, crc: u16) bool {
    return crc == self.calculate(data);
}
