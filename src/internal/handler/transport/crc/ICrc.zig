// external
const Inteface = @import("interface").Interface;


pub const ICrc = Inteface(.{
    .deinit = fn() void,
    .calculate = fn (data: []const u8) u16,
    .isValid = fn (data: []const u8, crc: u16) bool,
}, null);
