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

    const encoded_hex_tcp = "000000000000003608010000016B40D8EA30010000000000000000000000000000000105021503010101425E0F01F10000601A014E0000000000000000010000C7CF";
    const encoded_tcp_len = encoded_hex_tcp.len / 2;

    var encoded_tcp: [encoded_tcp_len]u8 = undefined;

    _ = try std.fmt.hexToBytes(&encoded_tcp, encoded_hex_tcp);

    const decoded_tcp = try zeltonika.decodeTcp(&encoded_tcp);

    std.debug.print("\nDecoded TCP data: {any}\n", .{ decoded_tcp });
}
