module models


@[packed]
pub struct AvlDataPacketHeaderPacked {
pub:
	zero_bytes u32
	data_field_length u32
}

@[packed]
pub struct Crc16Packed {
pub:
	value u32
}
