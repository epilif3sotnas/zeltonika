// std
const std = @import("std");

// external
const Zeltonika = @import("zeltonika").Zeltonika;
const ZeltonikaConfig = @import("zeltonika").ZeltonikaConfig;
const TcpAvlData = @import("zeltonika").TcpAvlData;
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

    const data_tcp = &TcpAvlData {
        .avl_data_packet_header = &.{
            .zero_bytes = 0x00,
            .data_field_length = 0x20,
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

        .crc_16 = &.{
            .value = 0x0001,
        },

        .response = &.{
            .response = 0x01,
        },
    };

    const encoded_tcp = try zeltonika.encodeTcp(data_tcp);
    const encoded_buffer = try allocator.alloc(u8, encoded_tcp.len * 2);
    defer allocator.free(encoded_buffer);
    const encoded_tcp_hex = try std.fmt.bufPrint(encoded_buffer, "{}", .{ std.fmt.fmtSliceHexLower(encoded_tcp) });

    std.debug.print("\nEncoded TCP Hex string: {s}\n", .{ encoded_tcp_hex });
}
