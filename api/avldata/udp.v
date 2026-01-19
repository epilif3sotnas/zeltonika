module avldata


// UdpAvlData represents the data contained when
// the UDP AVL data packet is received plus the response
// that should be returned to the device in the response field.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:11]
pub struct UdpAvlData {

pub:
	// udp_channel_header contains the UDP channel header.
	udp_channel_header UdpChannelHeader

	// avl_packet_header contains the AVL packet header.
	avl_packet_header  AvlPacketHeader

	// avl_data_array contains the AVL data array.
	avl_data_array     AvlDataArray

	// response contains the response to be sent back to the device.
	response ?UdpAvlResponse = none
}

// UdpChannelHeader represents the data contained in
// the packet received via UDP protocol.
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:11]
pub struct UdpChannelHeader {

pub:
	// length is the length of the packet received.
	length u16

	// packet_id is the packet identifier of the packet received.
	packet_id u16

	// not_usable_byte is a not used byte from the UDP header.
	not_usable_byte u8
}

// AvlPacketHeader represents the header of a UDP AVL data packet.
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:11]
pub struct AvlPacketHeader {

pub:
	// avl_packet_id is the AVL packet identifier.
	avl_packet_id u8

	// imei_length is the IMEI length used to parse the IMEI.
	imei_length   u16

	// imei is the International Mobile Equipment Identity.
	imei          []u8
}

// UdpAvlResponse represents the response to be sent back to the device
// for the given data.
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec [web:11]
pub struct UdpAvlResponse {

pub:
	// length is the length of the packet received.
	length u16

	// packet_id is the packet identifier of the packet received.
	packet_id u16

	// not_usable_byte is a not used byte from the UDP header.
	not_usable_byte u8

	// avl_packet_id is the AVL packet identifier.
	avl_packet_id u8

	// num_accepted_data is the number of accepted AVL data elements.
	num_accepted_data u8
}
