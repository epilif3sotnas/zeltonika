module h_avldata


// std
import encoding.hex

// internal
import public.api.avldata { TcpAvlData, AvlDataPacketHeader, TcpAvlResponse, Crc16, UdpAvlData, UdpChannelHeader, AvlPacketHeader, UdpAvlResponse, AvlDataArray, AvlData, GpsElement, AvlIoElement }


pub const tcp_data_byte_array_codec8 := hex.decode('000000000000003608010000016B40D8EA30010000000000000000000000000000000105021503010101425E0F01F10000601A014E0000000000000000010000C7CF')!

pub fn tcp_data_codec8() TcpAvlData {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x15] = [u8(0x03)]
	n1_elements[0x01] = [u8(0x01)]

  mut n2_elements := map[u16][]u8{}
	n2_elements[0x42] = [u8(0x5E), 0x0F]

  mut n4_elements := map[u16][]u8{}
	n4_elements[0xF1] = [u8(0x00), 0x00, 0x60, 0x1A]

  mut n8_elements := map[u16][]u8{}
	n8_elements[0x4E] = [u8(0x00), 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]

  return TcpAvlData {
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
}

pub const udp_data_byte_array_codec8 := hex.decode('003DCAFE0105000F33353230393330383634303336353508010000016B4F815B30010000000000000000000000000000000103021503010101425DBC000001')!

pub fn udp_data_codec8() UdpAvlData {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x15] = [u8(0x03)]
	n1_elements[0x01] = [u8(0x01)]

  mut n2_elements := map[u16][]u8{}
	n2_elements[0x42] = [u8(0x5D), 0xBC]

  return UdpAvlData {
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
}
