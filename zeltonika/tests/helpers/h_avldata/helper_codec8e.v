module h_avldata


// std
import encoding.hex

// internal
import public.api.avldata { TcpAvlData, AvlDataPacketHeader, TcpAvlResponse, Crc16, UdpAvlData, UdpChannelHeader, AvlPacketHeader, UdpAvlResponse, AvlDataArray, AvlData, GpsElement, AvlIoElement }


pub const tcp_data_byte_array_codec8e := hex.decode('000000000000004A8E010000016B412CEE000100000000000000000000000000000000010005000100010100010011001D00010010015E2C880002000B000000003544C87A000E000000001DD7E06A00000100002994')!

pub fn tcp_data_codec8e() TcpAvlData {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x00_01] = [u8(0x01)]

  mut n2_elements := map[u16][]u8{}
	n2_elements[0x00_11] = [u8(0x00), 0x1D]

  mut n4_elements := map[u16][]u8{}
	n4_elements[0x00_10] = [u8(0x01), 0x5E, 0x2C, 0x88]

  mut n8_elements := map[u16][]u8{}
	n8_elements[0x00_0B] = [u8(0x00), 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A]
	n8_elements[0x00_0E] = [u8(0x00), 0x00, 0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A]

  return TcpAvlData {
    avl_data_packet_header: AvlDataPacketHeader {
      zero_bytes: 0x00_00_00_00
      data_field_length: 0x00_00_00_4A
    }
    avl_data_array: AvlDataArray {
      codec_id: .codec8e
      data: [
        AvlData {
          timestamp: 0x00_00_01_6B_41_2C_EE_00
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
            codec_id: .codec8e
        		event_io_id: 0x00_01
        		number_of_total_io: 0x00_05
        		n1_elements: n1_elements
        		n2_elements: n2_elements
        		n4_elements: n4_elements
        		n8_elements: n8_elements
         }
        },
      ]
    }
    crc_16: Crc16 {
      value: 0x00_00_29_94
    }
    response: TcpAvlResponse {
      response: 0x00_00_00_01
    }
  }
}

pub const udp_data_byte_array_codec8e := hex.decode('005FCAFE0107000F3335323039333038363430333635358E010000016B4F831C680100000000000000000000000000000000010005000100010100010011009D00010010015E2C880002000B000000003544C87A000E000000001DD7E06A000001')!

pub fn udp_data_codec8e() UdpAvlData {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x00_01] = [u8(0x01)]

  mut n2_elements := map[u16][]u8{}
	n2_elements[0x00_11] = [u8(0x00), 0x9D]

  mut n4_elements := map[u16][]u8{}
	n4_elements[0x00_10] = [u8(0x01), 0x5E, 0x2C, 0x88]

  mut n8_elements := map[u16][]u8{}
	n8_elements[0x00_0B] = [u8(0x00), 0x00, 0x00, 0x00, 0x35, 0x44, 0xC8, 0x7A]
	n8_elements[0x00_0E] = [u8(0x00), 0x00, 0x00, 0x00, 0x1D, 0xD7, 0xE0, 0x6A]

  return UdpAvlData {
    udp_channel_header: UdpChannelHeader {
      length: 0x00_5F
      packet_id: 0xCA_FE
      not_usable_byte: 0x01
    }
    avl_packet_header: AvlPacketHeader {
      avl_packet_id: 0x07
      imei_length: 0x00_0F
      imei: [u8(0x33), 0x35, 0x32, 0x30, 0x39, 0x33, 0x30, 0x38, 0x36, 0x34, 0x30, 0x33, 0x36, 0x35, 0x35]
    }
    avl_data_array: AvlDataArray {
      codec_id: .codec8e
      data: [
        AvlData {
          timestamp: 0x00_00_01_6B_4F_83_1C_68
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
            codec_id: .codec8e
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
    response: UdpAvlResponse {
      length: 0x00_5F
      packet_id: 0xCA_FE
      not_usable_byte: 0x01
      avl_packet_id: 0x07
      num_accepted_data: 0x01
    }
  }
}
