module avldata


// CodecId represents the codec identifier with its value associated
// defined by the Teltonika codec documentation.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub enum CodecId as u8 {
	codec8    = 0x08
	codec8e   = 0x8e
	codec16   = 0x10
}

// AvlDataArray represents an array of AVL data.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub struct AvlDataArray {

pub:
	// codec_id is the codec identifier for the AVL data array.
	codec_id CodecId

	// data is the array of AVL data elements.
	data     []AvlData
}

// Priority defines AVL data priority.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub enum Priority as u8 {
	low   = 0
	high  = 1
	panic = 2
}

// AvlData represents an AVL data element.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub struct AvlData {

pub:
	// timestamp is the UNIX timestamp in milliseconds.
	timestamp   u64

	// priority is the priority of the AVL data element.
	priority    Priority

	// gps_element is the GPS element of the AVL data element.
	gps_element GpsElement

	// io_element is the I/O element of the AVL data element.
	io_element  AvlIoElement
}

// GpsElement represents all the fields that the GPS element contains.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub struct GpsElement {

pub:
	// longitude of the GPS element.
	longitude  f64

	// latitude of the GPS element.
	latitude   f64

	// altitude of the GPS element.
	altitude   i16

	// angle of the GPS element.
	angle      u16

	// satellites is the number of satellites used.
	satellites u8

	// speed is the speed in km/h.
	speed      u16
}

// Generation defines the generation type of the AVL IO element,
// which is only present in Codec 16.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub enum Generation as u8 {
	on_exit     = 0
	on_entrance = 1
	on_both     = 2
	reserved    = 3
	hysteresis  = 4
	on_change   = 5
	eventual    = 6
	periodical  = 7
}

// AvlIoElement represents the I/O element of the AVL data element.
// It includes common fields across all codecs, and codec-specific ones.
//
// Teltonika codec documentation: https://wiki.teltonika-gps.com/view/Codec
pub struct AvlIoElement {

pub:
	// codec_id is the codec identifier for the I/O element.
	codec_id           CodecId

	// event_io_id identifies the event that triggered the record.
	event_io_id        u16

	// number_of_total_io defines total I/O elements present.
	number_of_total_io u16

	// generation_type is used only by Codec 16.
	generation_type    ?Generation

pub mut:
	// n1_elements represents I/O elements with 1-byte values.
	n1_elements map[u16][1]u8

	// n2_elements represents I/O elements with 2-byte values.
	n2_elements map[u16][2]u8

	// n4_elements represents I/O elements with 4-byte values.
	n4_elements map[u16][4]u8

	// n8_elements represents I/O elements with 8-byte values.
	n8_elements map[u16][8]u8

	// nx_elements represents I/O elements with variable-length values.
	nx_elements map[u16][]u8
}
