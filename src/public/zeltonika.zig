// std
const std = @import("std");
const Allocator = std.mem.Allocator;

// internal
const ZeltonikaConfig = @import("config/config.zig").ZeltonikaConfig;
const ZeltonikaError = @import("errors.zig").ZeltonikaError;
const TcpAvlData = @import("avl_data/tcp.zig").TcpAvlData;
const UdpAvlData = @import("avl_data/udp.zig").UdpAvlData;


// TODO: imports to remove
const CodecId = @import("avl_data/avl_data_array.zig").CodecId;
const Priority   = @import("avl_data/avl_data_array.zig").Priority;
const AvlData = @import("avl_data/avl_data_array.zig").AvlData;


/// Zeltonika is a library whose main goal is handling the data of the Teltonika trackers,
/// which have 2 different types of data codification: JSON and binary (Teltonika Binary codecs and Teltonika JSON codec).
/// This library is lightweight and simple to use as a decoder and encoder for these data formats.
pub const Zeltonika = struct {

    /// The allocator to use for memory allocation.
    allocator: Allocator,

    /// The configuration for the Zeltonika instance.
    config: *const ZeltonikaConfig,

    /// Initialize a new Zeltonika instance with the given allocator and configuration.
    ///
    /// Args:
    ///
    ///     allocator: The allocator to use for memory allocation.
    ///     config: The configuration for the Zeltonika instance.
    ///
    /// Errors:
    ///
    ///     ZeltonikaError: An error occurred during initialization.
    ///
    /// Returns:
    ///
    ///     A pointer to the newly initialized Zeltonika instance.
    pub fn init(allocator: Allocator, config: *const ZeltonikaConfig) ZeltonikaError!*const Zeltonika {
		return &Zeltonika{
	    	.allocator = allocator,
			.config = config,
		};
	}

	/// Deinitialize the Zeltonika instance.
	pub fn deinit(self: *const Zeltonika) void {
    	_ = self;
    	// self.allocator.deinit();
	}

	/// Encode a single TCP AVL data packet.
	///
	/// Args:
	///
	///     data: The TCP AVL data packet to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the encoded data.
	pub fn encodeTcp(self: *const Zeltonika, data: *const TcpAvlData) ZeltonikaError![]const u8 {
	    _ = self;
	    _ = data;
		return &[_]u8{};
	}

	/// Encode a bulk of TCP AVL data packet.
	///
	/// Args:
	///
	///     data: The array of TCP AVL data packets to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the encoded data.
	pub fn encodeTcpBulk(self: *const Zeltonika, data: []const *const TcpAvlData) ZeltonikaError![]const []const u8 {
    	var result = std.ArrayList([]const u8).init(self.allocator);
	    defer result.deinit();

		for (data) |item| {
			try result.append(self.encodeTcp(item));
		}

        return result.items;
	}

	/// Encode a single TCP AVL data packet asynchronously.
	///
	/// Args:
	///
	///     data: The TCP AVL data packet to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the encoded data.
	pub fn encodeTcpAsync(self: *const Zeltonika, data: *const TcpAvlData) ZeltonikaError![]const u8 {
        _ = self;
        _ = data;
        return &[_]u8{};
	}

	/// Encode a bulk of TCP AVL data packet asynchronously.
	///
	/// Args:
	///
	///     data: The array of TCP AVL data packets to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the encoded data.
	pub fn encodeTcpAsyncBulk(self: *const Zeltonika, data: []const *const TcpAvlData) ZeltonikaError![]const []const u8 {
    	var result = std.ArrayList([]const u8).init(self.allocator);
        defer result.deinit();

        for (data) |item| {
            try result.append(self.encodeTcpAsync(item));
        }

        return result.items;
	}

	/// Encode a single UDP AVL data packet.
	///
	/// Args:
	///
	///     data: The UDP AVL data packet to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the encoded data.
	pub fn encodeUdp(self: *const Zeltonika, data: *const UdpAvlData) ZeltonikaError![]const u8 {
        _ = self;
	    _ = data;
        return &[_]u8{};
	}

	/// Encode a bulk of UDP AVL data packets.
	///
	/// Args:
	///
	///     data: The array of UDP AVL data packets to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the encoded data.
 	pub fn encodeUdpBulk(self: *const Zeltonika, data: []const *const UdpAvlData) ZeltonikaError![]const []const u8 {
        var result = std.ArrayList([]const u8).init(self.allocator);
         defer result.deinit();

         for (data) |item| {
             try result.append(self.encodeUdp(item));
         }

         return result.items;
	}

	/// Encode a single UDP AVL data packet asynchronously.
	///
	/// Args:
	///
	///     data: The UDP AVL data packet to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the encoded data.
	pub fn encodeUdpAsync(self: *const Zeltonika, data: *const UdpAvlData) ZeltonikaError![]const u8 {
	    _ = self;
        _ = data;
        return &[_]u8{};
	}

	/// Encode a bulk of UDP AVL data packets asynchronously.
	///
	/// Args:
	///
	///     data: The array of UDP AVL data packets to encode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during encoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the encoded data.
	pub fn encodeUdpAsyncBulk(self: *const Zeltonika, data: []const *const UdpAvlData) ZeltonikaError![]const []const u8 {
	    var result = std.ArrayList([]const u8).init(self.allocator);
         defer result.deinit();

         for (data) |item| {
             try result.append(self.encodeUdpAsync(item));
         }

         return result.items;
	}

	/// Decode a single TCP AVL data packet asynchronously.
	///
	/// Args:
	///
	///     data: The TCP AVL data packet to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the decoded data.
	pub fn decodeTcp(self: *const Zeltonika, data: []const u8) ZeltonikaError!*const TcpAvlData {
	    _ = self;
    	_ = data;
        return &TcpAvlData {
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
	}

	/// Decode a bulk of TCP AVL data packets asynchronously.
	///
	/// Args:
	///
	///     data: The array of TCP AVL data packets to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the decoded data.
	pub fn decodeTcpBulk(self: *const Zeltonika, data: []const []const u8) ZeltonikaError![]const *const TcpAvlData {
        var result = std.ArrayList(TcpAvlData).init(self.allocator);
        defer result.deinit();

        for (data) |item| {
            try result.append(self.decodeTcp(item));
        }

         return result.items;
	}

	/// Decode a single TCP AVL data packet asynchronously.
	///
	/// Args:
	///
	///     data: The TCP AVL data packet to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the decoded data.
	pub fn decodeTcpAsync(self: *const Zeltonika, data: []const u8) ZeltonikaError!TcpAvlData {
	    _ = self;
        _ = data;
        return .{};
	}

	/// Decode a bulk of TCP AVL data packets asynchronously.
	///
	/// Args:
	///
	///     data: The array of TCP AVL data packets to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the decoded data.
	pub fn decodeTcpAsyncBulk(self: *const Zeltonika, data: []const []const u8) ZeltonikaError![]const *const TcpAvlData {
	    var result = std.ArrayList(TcpAvlData).init(self.allocator);
        defer result.deinit();

        for (data) |item| {
            try result.append(self.decodeTcpAsync(item));
        }

         return result.items;
	}

	/// Decode a single UDP AVL data packet.
	///
	/// Args:
	///
	///     data: The UDP AVL data packet to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the decoded data.
	pub fn decodeUdp(self: *const Zeltonika, data: []const u8) ZeltonikaError!*const UdpAvlData {
	    _ = self;
    	_ = data;
        return &UdpAvlData {
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
	}

	/// Decode a bulk of UDP AVL data packets.
	///
	/// Args:
	///
	///     data: The array of UDP AVL data packets to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the decoded data.
	pub fn decodeUdpBulk(self: *const Zeltonika, data: []const []const u8) ZeltonikaError![]const *const UdpAvlData {
        var result = std.ArrayList(UdpAvlData).init(self.allocator);
        defer result.deinit();

        for (data) |item| {
            try result.append(self.decodeUdp(item));
        }

         return result.items;
	}

	/// Decode a single UDP AVL data packet asynchronously.
	///
	/// Args:
	///
	///     data: The UDP AVL data packet to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     A slice of bytes containing the decoded data.
	pub fn decodeUdpAsync(self: *const Zeltonika, data: []const u8) ZeltonikaError!*const UdpAvlData {
	    _ = self;
        _ = data;
        return .{};
	}

	/// Decode a bulk of UDP AVL data packets asynchronously.
	///
	/// Args:
	///
	///     data: The array of UDP AVL data packets to decode.
	///
	/// Errors:
	///
	///     ZeltonikaError: An error occurred during decoding.
	///
	/// Returns:
	///
	///     An array of slices of bytes containing the decoded data.
	pub fn decodeUdpAsyncBulk(self: *const Zeltonika, data: []const []const u8) ZeltonikaError![]const *const UdpAvlData {
	    var result = std.ArrayList(*const UdpAvlData).init(self.allocator);
        defer result.deinit();

        for (data) |item| {
            try result.append(self.decodeUdpAsync(item));
        }

         return result.items;
	}
};
