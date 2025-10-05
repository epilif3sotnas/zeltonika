// std
const std = @import("std");

// internal
const Crc = @import("../../../../../../internal/handler/transport/crc/Crc.zig").Crc;


test "calculate should return a valid generated CRC16/IBM" {
    const crc = Crc.init();

    const data_hex = "08010000016B40D8EA30010000000000000000000000000000000105021503010101425E0F01F10000601A014E000000000000000001";
    const data_hex_len = data_hex.len / 2;

    var data: [data_hex_len]u8 = undefined;

    _ = try std.fmt.hexToBytes(&data, data_hex);

    const expected = 0x0000C7CF;
    const actual = crc.calculate(&data);

    try std.testing.expectEqual(expected, actual);
}

test "calculate should return the algorithm initial" {
    const crc = Crc.init();

    const expected = 0x0000;
    const actual = crc.calculate(&[_]u8{});

    try std.testing.expectEqual(expected, actual);
}

test "isValid should return true for valid CRC16/IBM and valid crc value" {
    const crc = Crc.init();

    const data_hex = "08010000016B40D8EA30010000000000000000000000000000000105021503010101425E0F01F10000601A014E000000000000000001";
    const data_hex_len = data_hex.len / 2;

    var data: [data_hex_len]u8 = undefined;

    _ = try std.fmt.hexToBytes(&data, data_hex);

    const expected = 0x0000C7CF;
    const actual = crc.isValid(&data, expected);

    try std.testing.expect(actual);
}

test "isValid should return false for invalid CRC16/IBM and different crc value" {
    const crc = Crc.init();

    const data_hex = "08010000016B40D8EA30010000000000000000000000000000000105021503010101425E0F01F10000601A014E000000000000000001";
    const data_hex_len = data_hex.len / 2;

    var data: [data_hex_len]u8 = undefined;

    _ = try std.fmt.hexToBytes(&data, data_hex);

    const expected = 0x0000000;
    const actual = crc.isValid(&data, expected);

    try std.testing.expect(!actual);
}
