// std
const std = @import("std");

// external
const Zeltonika = @import("zeltonika").Zeltonika;
const ZeltonikaConfig = @import("zeltonika").ZeltonikaConfig;


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const config: *const ZeltonikaConfig = &.{};

    const zeltonika = try Zeltonika.init(allocator, config);
    defer zeltonika.deinit();

    const encoded_hex_udp = "003DCAFE0105000F33353230393330383634303336353508010000016B4F815B30010000000000000000000000000000000103021503010101425DBC000001";
    const encoded_udp_len = encoded_hex_udp.len / 2;

    var encoded_udp: [encoded_udp_len]u8 = undefined;

    _ = try std.fmt.hexToBytes(&encoded_udp, encoded_hex_udp);

    const decoded_udp = try zeltonika.decodeUdp(&encoded_udp);

    std.debug.print("\nDecoded UDP data: {any}\n", .{ decoded_udp });
}
