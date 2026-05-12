module api


// internal
import public.api.izeltonika { IZeltonika }
import public.api.config.config { ZeltonikaConfig }
import internal.parser.handler.ihandler { IZeltonikaHandler }
import internal.parser.handler.handler { ZeltonikaHandler }
import internal.utils.bytebuffer { ByteBuffer }
import internal.utils.tuple { Tuple }


// Zeltonika is the public API of this library.
//
// ## Async Methods
//
// The following async methods are not implemented yet and will panic if called:
//   - `encode_tcp_async`
//   - `encode_tcp_async_bulk`
//   - `encode_udp_async`
//   - `encode_udp_async_bulk`
//   - `decode_tcp_async`
//   - `decode_tcp_async_bulk`
//   - `decode_udp_async`
//   - `decode_udp_async_bulk`
pub struct Zeltonika {
	config ZeltonikaConfig
	zeltonikaHandler IZeltonikaHandler
}


// new creates a new Zeltonika instance with default config.
//
// # Returns
// A new `Zeltonika` instance.
//
// # Errors
// Returns `ZeltonikaError` if initialization fails.
pub fn Zeltonika.new() Zeltonika {
	config := ZeltonikaConfig{}

	return Zeltonika.new(config)!
}

// new creates a new Zeltonika instance with the given config.
//
// # Arguments
// * `config` - The configuration to use
//
// # Returns
// A new `Zeltonika` instance.
//
// # Errors
// Returns `ZeltonikaError` if initialization fails.
pub fn Zeltonika.new(config ZeltonikaConfig) Zeltonika {
	return Zeltonika {
		config: config
		zeltonikaHandler: ZeltonikaHandler.new()
	}
}

// encode_tcp encodes a single TCP AVL data item to bytes.
//
// # Arguments
// * `data` - The TCP AVL data to encode
//
// # Returns
// Encoded byte array representing the TCP AVL data packet.
//
// # Errors
// Returns `ZeltonikaError` if encoding fails.
pub fn (self &Zeltonika) encode_tcp(data TcpAvlData) ![]u8 {
	return self.encode_tcp_bulk([data])![0]
}

// encode_tcp_bulk encodes multiple TCP AVL data items to bytes.
//
// # Arguments
// * `data` - Array of TCP AVL data to encode
//
// # Returns
// Array of encoded byte arrays representing the TCP AVL data packets.
//
// # Errors
// Returns `ZeltonikaError` if any encoding fails.
pub fn (self &Zeltonika) encode_tcp_bulk(data []TcpAvlData) ![][]u8 {
	mut tuples := []Tuple[mut ByteBuffer, TcpAvlData]{cap: data.len}
	for item in data {
		mut byte_buffer := ByteBuffer.with_capacity(1024)
		tuples << Tuple.new[mut ByteBuffer, TcpAvlData](mut byte_buffer, item)
	}
	self.zeltonikaHandler.encode_tcp_bulk(tuples)!
	mut results := [][]u8{cap: data.len}
	for item in tuples {
		results << item.first.as_bytes()
	}
	return results
}

// encode_tcp_async encodes a single TCP AVL data item to bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - The TCP AVL data to encode
//
// # Returns
// Encoded byte array representing the TCP AVL data packet.
//
// # Errors
// Returns `ZeltonikaError` if encoding fails.
pub fn (self &Zeltonika) encode_tcp_async(data TcpAvlData) ![]u8 {
	return self.encode_tcp_async_bulk([data])![0]
}

// encode_tcp_async_bulk encodes multiple TCP AVL data items to bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - Array of TCP AVL data to encode
//
// # Returns
// Array of encoded byte arrays representing the TCP AVL data packets.
//
// # Errors
// Returns `ZeltonikaError` if any encoding fails.
pub fn (self &Zeltonika) encode_tcp_async_bulk(data []TcpAvlData) ![][]u8 {
	panic('not implemented yet')
}

// encode_udp encodes a single UDP AVL data item to bytes.
//
// # Arguments
// * `data` - The UDP AVL data to encode
//
// # Returns
// Encoded byte array representing the UDP AVL data packet.
//
// # Errors
// Returns `ZeltonikaError` if encoding fails.
pub fn (self &Zeltonika) encode_udp(data UdpAvlData) ![]u8 {
	return self.encode_udp_bulk([data])![0]
}

// encode_udp_bulk encodes multiple UDP AVL data items to bytes.
//
// # Arguments
// * `data` - Array of UDP AVL data to encode
//
// # Returns
// Array of encoded byte arrays representing the UDP AVL data packets.
//
// # Errors
// Returns `ZeltonikaError` if any encoding fails.
pub fn (self &Zeltonika) encode_udp_bulk(data []UdpAvlData) ![][]u8 {
	mut tuples := []Tuple[ByteBuffer, UdpAvlData]{cap: data.len}
	for item in data {
		mut byte_buffer := ByteBuffer.with_capacity(1024)
		tuples << Tuple.new[ByteBuffer, UdpAvlData](byte_buffer, item)
	}
	self.zeltonikaHandler.encode_udp_bulk(tuples)!
	mut results := [][]u8{cap: data.len}
	for item in tuples {
		results << item.first.as_bytes()
	}
	return results
}

// encode_udp_async encodes a single UDP AVL data item to bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - The UDP AVL data to encode
//
// # Returns
// Encoded byte array representing the UDP AVL data packet.
//
// # Errors
// Returns `ZeltonikaError` if encoding fails.
pub fn (self &Zeltonika) encode_udp_async(data UdpAvlData) ![]u8 {
	return self.encode_udp_async_bulk([data])![0]
}

// encode_udp_async_bulk encodes multiple UDP AVL data items to bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - Array of UDP AVL data to encode
//
// # Returns
// Array of encoded byte arrays representing the UDP AVL data packets.
//
// # Errors
// Returns `ZeltonikaError` if any encoding fails.
pub fn (self &Zeltonika) encode_udp_async_bulk(data []UdpAvlData) ![][]u8 {
	panic('not implemented yet')
}

// decode_tcp decodes a single TCP AVL data item from bytes.
//
// # Arguments
// * `data` - The byte array to decode
//
// # Returns
// Decoded `TcpAvlData` struct.
//
// # Errors
// Returns `ZeltonikaError` if decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_tcp(data []u8) !TcpAvlData {
	return self.decode_tcp_bulk([data])![0]
}

// decode_tcp_bulk decodes multiple TCP AVL data items from bytes.
//
// # Arguments
// * `data` - Array of byte arrays to decode
//
// # Returns
// Array of decoded `TcpAvlData` structs.
//
// # Errors
// Returns `ZeltonikaError` if any decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_tcp_bulk(data [][]u8) ![]TcpAvlData {
	mut byte_buffers := []ByteBuffer{cap: data.len}
	for item in data {
		byte_buffers << ByteBuffer.from_bytes(item)
	}
	return self.zeltonikaHandler.decode_tcp_bulk(mut byte_buffers)!
}

// decode_tcp_async decodes a single TCP AVL data item from bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - The byte array to decode
//
// # Returns
// Decoded `TcpAvlData` struct.
//
// # Errors
// Returns `ZeltonikaError` if decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_tcp_async(data []u8) !TcpAvlData {
	return self.decode_tcp_async_bulk([data])![0]
}

// decode_tcp_async_bulk decodes multiple TCP AVL data items from bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - Array of byte arrays to decode
//
// # Returns
// Array of decoded `TcpAvlData` structs.
//
// # Errors
// Returns `ZeltonikaError` if any decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_tcp_async_bulk(data [][]u8) ![]TcpAvlData {
	panic('not implemented yet')
}

// decode_udp decodes a single UDP AVL data item from bytes.
//
// # Arguments
// * `data` - The byte array to decode
//
// # Returns
// Decoded `UdpAvlData` struct.
//
// # Errors
// Returns `ZeltonikaError` if decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_udp(data []u8) !UdpAvlData {
	return self.decode_udp_bulk([data])![0]
}

// decode_udp_bulk decodes multiple UDP AVL data items from bytes.
//
// # Arguments
// * `data` - Array of byte arrays to decode
//
// # Returns
// Array of decoded `UdpAvlData` structs.
//
// # Errors
// Returns `ZeltonikaError` if any decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_udp_bulk(data [][]u8) ![]UdpAvlData {
	mut byte_buffers := []ByteBuffer{cap: data.len}
	for item in data {
		byte_buffers << ByteBuffer.from_bytes(item)
	}
	return self.zeltonikaHandler.decode_udp_bulk(mut byte_buffers)!
}

// decode_udp_async decodes a single UDP AVL data item from bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - The byte array to decode
//
// # Returns
// Decoded `UdpAvlData` struct.
//
// # Errors
// Returns `ZeltonikaError` if decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_udp_async(data []u8) !UdpAvlData {
	return self.decode_udp_async_bulk([data])![0]
}

// decode_udp_async_bulk decodes multiple UDP AVL data items from bytes asynchronously.
// Not implemented yet - will panic.
//
// # Arguments
// * `data` - Array of byte arrays to decode
//
// # Returns
// Array of decoded `UdpAvlData` structs.
//
// # Errors
// Returns `ZeltonikaError` if any decoding fails or data is invalid.
pub fn (self &Zeltonika) decode_udp_async_bulk(data [][]u8) ![]UdpAvlData {
	panic('not implemented yet')
}
