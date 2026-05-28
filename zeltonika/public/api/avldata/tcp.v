module avldata


// TcpAvlData represents the data contained when
// the TCP AVL data packet is received plus the response
// that should be returned to the device in the response field.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
pub struct TcpAvlData {

pub:
	// avl_data_packet_header represents the header of a TCP data packet.
	avl_data_packet_header AvlDataPacketHeader

	// avl_data_array represents the array of AVL data.
	avl_data_array         AvlDataArray

	// crc_16 is the CRC16 checksum of the data.
	crc_16 ?Crc16

	// response contains the response to be sent back to the device.
	response ?TcpAvlResponse
}

// AvlDataPacketHeader represents the header of a TCP data packet.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
pub struct AvlDataPacketHeader {

pub:
	// zero_bytes represents 4 bytes with value zero.
	zero_bytes u32

	// data_field_length is the length of the data field.
	data_field_length u32
}

// Crc16 represents the CRC16 checksum of the data.
// It is calculated from the Codec ID to the Second Number of Data.
// For calculation we are using CRC-16/IBM. [web:2]
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
pub struct Crc16 {

pub:
	// value is the CRC16 checksum of the data.
	value u32
}

// TcpAvlResponse represents the response to be sent back to the device
// for the given data.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:2]
pub struct TcpAvlResponse {

pub:
	// response is the number of received AVL data.
	response u32
}
