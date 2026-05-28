module main


// std
import encoding.hex

// external
import zeltonika.public.api { Zeltonika }
import zeltonika.public.api.avldata { TcpAvlData, AvlDataPacketHeader, AvlDataArray, AvlData, Crc16, TcpAvlResponse, CodecId, Priority, GpsElement, AvlIoElement }


fn main() {
	zeltonika := Zeltonika.new()

	mut n1_elements := map[u16][]u8{}
    n1_elements[0x15] = [u8(0x03)]
    n1_elements[0x01] = [u8(0x01)]

    mut n2_elements := map[u16][]u8{}
    n2_elements[0x42] = [u8(0x5E), 0x0F]

    mut n4_elements := map[u16][]u8{}
    n4_elements[0xF1] = [u8(0x00), 0x00, 0x60, 0x1A]

    mut n8_elements := map[u16][]u8{}
    n8_elements[0x4E] = [u8(0x00), 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]

    data_tcp := TcpAvlData {
        avl_data_packet_header: AvlDataPacketHeader {
            zero_bytes: 0x00_00_00_00
            data_field_length: 0x00_00_00_36
        }
        avl_data_array: AvlDataArray {
            codec_id: .codec8
            data: [
                AvlData {
                    timestamp: 0x00_00_01_6B_40_D8_EA_30
                   	priority: .high
                   	gps_element: GpsElement {
                       	longitude: 0.00
                        latitude: 0.00
                        altitude: 0
                        angle: 0
                        satellites: 0
                        speed: 0
            	    }
                   	io_element: AvlIoElement {
                        codec_id: .codec8
                  		event_io_id: 0x01
                  		number_of_total_io: 0x05
                  		n1_elements: n1_elements
                  		n2_elements: n2_elements
                  		n4_elements: n4_elements
                  		n8_elements: n8_elements
                    }
                },
            ]
        }
        crc_16: Crc16 {
            value: 0x00_00_C7_CF
        }
        response: TcpAvlResponse {
            response: 0x00_00_00_01
        }
    }

	encoded_tcp := zeltonika.encode_tcp(data_tcp) or {
		eprintln('Failed to encode TCP data: ${err}')
		return
	}

	encoded_hex := hex.encode(encoded_tcp)
	println('Encoded TCP Hex string: ${encoded_hex}')
}
