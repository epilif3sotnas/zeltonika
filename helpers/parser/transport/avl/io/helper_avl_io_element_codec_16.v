module io


// internal
import api.avldata { AvlIoElement }


pub const byte_array_codec_16 := [u8(0x00), 0x0B, 0x05, 0x04,
  0x02, 0x00, 0x01, 0x00, 0x00, 0x03, 0x00, 0x02, 0x00, 0x0B,
  0x00, 0x26, 0x00, 0x42, 0x56, 0x3A, 0x00, 0x00]

pub fn avl_io_element_codec_16() AvlIoElement {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x0001] = [u8(0x00)]
	n1_elements[0x0003] = [u8(0x00)]

  mut n2_elements := map[u16][]u8{}
	n2_elements[0x000b] = [u8(0x00), 0x26]
	n2_elements[0x0042] = [u8(0x56), 0x3a]

	return AvlIoElement {
		codec_id: .codec16
		event_io_id: 0x000b
		number_of_total_io: 0x04
		generation_type: .on_change
		n1_elements: n1_elements
		n2_elements: n2_elements
		n4_elements: map[u16][]u8{}
		n8_elements: map[u16][]u8{}
	}
}
