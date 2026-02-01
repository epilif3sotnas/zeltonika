module models


@[packed]
pub struct UdpChannelHeaderPacked {
pub:
	length u16
	packet_id u16
	not_usable_byte u8
}

@[packed]
pub struct AvlPacketHeaderPacked {
pub:
	avl_packet_id u8
	imei_length   u16
}
