module api


// internal
import public.api.avldata { TcpAvlData, UdpAvlData }


// IZeltonika is the public interface for the
// public API of this library.
//
// This interface provides methods for encoding and decoding
// AVL (Advanced Vehicle Location) data packets for both
// TCP and UDP protocols, as well as async variants for
// improved performance.
//
// Teltonika protocol documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
pub interface IZeltonika {
	// Encodes a single TCP AVL data packet into bytes.
	//
	// Takes a `TcpAvlData` struct and returns the encoded
	// byte array suitable for transmission over TCP.
	//
	// # Arguments
	// * `data` - The TCP AVL data to encode
	//
	// # Returns
	// Encoded byte array representing the TCP AVL data packet.
	//
	// # Errors
	// Returns `ZeltonikaError` if encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_tcp(data TcpAvlData) ![]u8

	// Encodes multiple TCP AVL data packets into bytes.
	//
	// Takes an array of `TcpAvlData` structs and returns
	// an array of encoded byte arrays.
	//
	// # Arguments
	// * `data` - Array of TCP AVL data to encode
	//
	// # Returns
	// Array of encoded byte arrays representing the TCP AVL data packets.
	//
	// # Errors
	// Returns `ZeltonikaError` if any encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_tcp_bulk(data []TcpAvlData) ![][]u8

	// Encodes a single TCP AVL data packet asynchronously.
	//
	// Async variant of `encode_tcp` for non-blocking operation.
	//
	// # Arguments
	// * `data` - The TCP AVL data to encode
	//
	// # Returns
	// Encoded byte array representing the TCP AVL data packet.
	//
	// # Errors
	// Returns `ZeltonikaError` if encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_tcp_async(data TcpAvlData) ![]u8

	// Encodes multiple TCP AVL data packets asynchronously.
	//
	// Async variant of `encode_tcp_bulk` for non-blocking operation.
	//
	// # Arguments
	// * `data` - Array of TCP AVL data to encode
	//
	// # Returns
	// Array of encoded byte arrays representing the TCP AVL data packets.
	//
	// # Errors
	// Returns `ZeltonikaError` if any encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_tcp_async_bulk(data []TcpAvlData) ![][]u8

	// Encodes a single UDP AVL data packet into bytes.
	//
	// Takes a `UdpAvlData` struct and returns the encoded
	// byte array suitable for transmission over UDP.
	//
	// # Arguments
	// * `data` - The UDP AVL data to encode
	//
	// # Returns
	// Encoded byte array representing the UDP AVL data packet.
	//
	// # Errors
	// Returns `ZeltonikaError` if encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_udp(data UdpAvlData) ![]u8

	// Encodes multiple UDP AVL data packets into bytes.
	//
	// Takes an array of `UdpAvlData` structs and returns
	// an array of encoded byte arrays.
	//
	// # Arguments
	// * `data` - Array of UDP AVL data to encode
	//
	// # Returns
	// Array of encoded byte arrays representing the UDP AVL data packets.
	//
	// # Errors
	// Returns `ZeltonikaError` if any encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_udp_bulk(data []UdpAvlData) ![][]u8

	// Encodes a single UDP AVL data packet asynchronously.
	//
	// Async variant of `encode_udp` for non-blocking operation.
	//
	// # Arguments
	// * `data` - The UDP AVL data to encode
	//
	// # Returns
	// Encoded byte array representing the UDP AVL data packet.
	//
	// # Errors
	// Returns `ZeltonikaError` if encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_udp_async(data UdpAvlData) ![]u8

	// Encodes multiple UDP AVL data packets asynchronously.
	//
	// Async variant of `encode_udp_bulk` for non-blocking operation.
	//
	// # Arguments
	// * `data` - Array of UDP AVL data to encode
	//
	// # Returns
	// Array of encoded byte arrays representing the UDP AVL data packets.
	//
	// # Errors
	// Returns `ZeltonikaError` if any encoding fails.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	encode_udp_async_bulk(data []UdpAvlData) ![][]u8

	// Decodes a TCP AVL data packet from bytes.
	//
	// Takes a byte array received over TCP and returns
	// the decoded `TcpAvlData` struct.
	//
	// # Arguments
	// * `data` - The byte array to decode
	//
	// # Returns
	// Decoded `TcpAvlData` struct.
	//
	// # Errors
	// Returns `ZeltonikaError` if decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_tcp(data []u8) !TcpAvlData

	// Decodes multiple TCP AVL data packets from bytes.
	//
	// Takes an array of byte arrays received over TCP and
	// returns an array of decoded `TcpAvlData` structs.
	//
	// # Arguments
	// * `data` - Array of byte arrays to decode
	//
	// # Returns
	// Array of decoded `TcpAvlData` structs.
	//
	// # Errors
	// Returns `ZeltonikaError` if any decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_tcp_bulk(data [][]u8) ![]TcpAvlData

	// Decodes a TCP AVL data packet asynchronously.
	//
	// Async variant of `decode_tcp` for non-blocking operation.
	//
	// # Arguments
	// * `data` - The byte array to decode
	//
	// # Returns
	// Decoded `TcpAvlData` struct.
	//
	// # Errors
	// Returns `ZeltonikaError` if decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_tcp_async(data []u8) !TcpAvlData

	// Decodes multiple TCP AVL data packets asynchronously.
	//
	// Async variant of `decode_tcp_bulk` for non-blocking operation.
	//
	// # Arguments
	// * `data` - Array of byte arrays to decode
	//
	// # Returns
	// Array of decoded `TcpAvlData` structs.
	//
	// # Errors
	// Returns `ZeltonikaError` if any decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_tcp_async_bulk(data [][]u8) ![]TcpAvlData

	// Decodes a UDP AVL data packet from bytes.
	//
	// Takes a byte array received over UDP and returns
	// the decoded `UdpAvlData` struct.
	//
	// # Arguments
	// * `data` - The byte array to decode
	//
	// # Returns
	// Decoded `UdpAvlData` struct.
	//
	// # Errors
	// Returns `ZeltonikaError` if decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_udp(data []u8) !UdpAvlData

	// Decodes multiple UDP AVL data packets from bytes.
	//
	// Takes an array of byte arrays received over UDP and
	// returns an array of decoded `UdpAvlData` structs.
	//
	// # Arguments
	// * `data` - Array of byte arrays to decode
	//
	// # Returns
	// Array of decoded `UdpAvlData` structs.
	//
	// # Errors
	// Returns `ZeltonikaError` if any decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_udp_bulk(data [][]u8) ![]UdpAvlData

	// Decodes a UDP AVL data packet asynchronously.
	//
	// Async variant of `decode_udp` for non-blocking operation.
	//
	// # Arguments
	// * `data` - The byte array to decode
	//
	// # Returns
	// Decoded `UdpAvlData` struct.
	//
	// # Errors
	// Returns `ZeltonikaError` if decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_udp_async(data []u8) !UdpAvlData

	// Decodes multiple UDP AVL data packets asynchronously.
	//
	// Async variant of `decode_udp_bulk` for non-blocking operation.
	//
	// # Arguments
	// * `data` - Array of byte arrays to decode
	//
	// # Returns
	// Array of decoded `UdpAvlData` structs.
	//
	// # Errors
	// Returns `ZeltonikaError` if any decoding fails or data is invalid.
	//
	// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
	decode_udp_async_bulk(data [][]u8) ![]UdpAvlData
}
