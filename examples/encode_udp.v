module main


// std
import encoding.hex

// external
import zeltonika.public.api { Zeltonika }
import zeltonika.public.api.avldata { UdpAvlData, UdpChannelHeader, AvlPacketHeader, AvlDataArray, AvlData, UdpAvlResponse, CodecId, Priority, GpsElement, AvlIoElement }


fn main() {
	zeltonika := Zeltonika.new()

	mut n1_elements := map[u16][]u8{}
    n1_elements[0x15] = [u8(0x03)]
    n1_elements[0x01] = [u8(0x01)]

    mut n2_elements := map[u16][]u8{}
    n2_elements[0x42] = [u8(0x5D), 0xBC]

    data_udp := UdpAvlData {
        udp_channel_header: UdpChannelHeader {
            length: 0x00_3D
            packet_id: 0xCA_FE
            not_usable_byte: 0x01
        }
        avl_packet_header: AvlPacketHeader {
            avl_packet_id: 0x05
            imei_length: 0x00_0F
            imei: [u8(0x33), 0x35, 0x32, 0x30, 0x39, 0x33, 0x30, 0x38, 0x36, 0x34, 0x30, 0x33, 0x36, 0x35, 0x35]
        }
        avl_data_array: AvlDataArray {
            codec_id: .codec8
            data: [
                AvlData {
                    timestamp: 0x00_00_01_6B_4F_81_5B_30
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
                  		number_of_total_io: 0x03
                  		n1_elements: n1_elements
                  		n2_elements: n2_elements
                    }
                },
            ]
        }
        response: UdpAvlResponse {
            length: 0x00_3D
            packet_id: 0xCA_FE
            not_usable_byte: 0x01
            avl_packet_id: 0x05
            num_accepted_data: 0x01
        }
    }

	encoded_udp := zeltonika.encode_udp(data_udp) or {
		eprintln('Failed to encode UDP data: ${err}')
		return
	}

	encoded_hex := hex.encode(encoded_udp)
	println('Encoded UDP Hex string: ${encoded_hex}')
}
