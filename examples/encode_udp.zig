// std
const std = @import("std");

// external
const Zeltonika = @import("zeltonika").Zeltonika;
const ZeltonikaConfig = @import("zeltonika").ZeltonikaConfig;
const UdpAvlData = @import("zeltonika").UdpAvlData;
const AvlData = @import("zeltonika").AvlData;
const CodecId = @import("zeltonika").CodecId;
const Priority = @import("zeltonika").Priority;
const AvlIoElement = @import("zeltonika").AvlIoElement;


pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const config: *const ZeltonikaConfig = &.{};

    const zeltonika = try Zeltonika.init(allocator, config);
    defer zeltonika.deinit();

    const data_udp = &UdpAvlData {
        .udp_channel_header = &.{
            .length = 0x30,
            .packet_id = 0x24,
            .not_usable_byte = 0x01,
        },

        .avl_packet_header = &.{
            .avl_packet_id = 0x01,
            .imei_length = 15,
            .imei = &[_]u8 { 0x11, 0x22, 0x33, 0x44, 0x55 },
        },

        .avl_data_array = &.{
            .codec_id = CodecId.Codec8,
            .data = &[_]*const AvlData {
                &.{
                    .timestamp = 1759344040000,
                    .priority = Priority.Low,
                    .gps_element = &.{
                        .latitude = 38.7369,
                        .longitude = -9.1428,
                        .altitude = 10,
                        .angle = 23,
                        .satellites = 3,
                        .speed = 123,
                    },
                    .io_element = &.{
                        .codec_id = CodecId.Codec8,
                        .event_io_id = 0x01,
                        .number_of_total_io = 0x00,
                    },
                }
            },
        },

        .response = &.{
            .length = 0x30,
            .packet_id = 0x24,
            .not_usable_byte = 0x01,
            .avl_packet_id = 0x01,
            .num_accepted_data = 1,
        },
    };

    const encoded_udp = try zeltonika.encodeUdp(data_udp);
    const encoded_buffer = try allocator.alloc(u8, encoded_udp.len * 2);
    defer allocator.free(encoded_buffer);
    const encoded_udp_hex = try std.fmt.bufPrint(encoded_buffer, "{f}", .{ std.ascii.hexEscape(encoded_udp, std.fmt.Case.lower) });

    std.debug.print("\nEncoded UDP Hex string: {s}\n", .{ encoded_udp_hex });
}
