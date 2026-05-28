module h_avldata


// std
import encoding.hex

// internal
import public.api.avldata { TcpAvlData, AvlDataPacketHeader, TcpAvlResponse, Crc16, UdpAvlData, UdpChannelHeader, AvlPacketHeader, UdpAvlResponse, AvlDataArray, AvlData, GpsElement, AvlIoElement }


pub const tcp_data_byte_array_codec16 := hex.decode('000000000000005F10020000016BDBC7833000000000000000000000000000000000000B05040200010000030002000B00270042563A00000000016BDBC7871800000000000000000000000000000000000B05040200010000030002000B00260042563A00000200005FB3')!

pub fn tcp_data_codec16() TcpAvlData {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x00_01] = [u8(0x00)]
	n1_elements[0x00_03] = [u8(0x00)]


	mut n2_elements_first := map[u16][]u8{}
  n2_elements_first[0x00_0B] = [u8(0x00), 0x27]
  n2_elements_first[0x00_42] = [u8(0x56), 0x3A]

  mut n2_elements_second := map[u16][]u8{}
	n2_elements_second[0x00_0B] = [u8(0x00), 0x26]
	n2_elements_second[0x00_42] = [u8(0x56), 0x3A]

  return TcpAvlData {
    avl_data_packet_header: AvlDataPacketHeader {
      zero_bytes: 0x00_00_00_00
      data_field_length: 0x00_00_00_5F
    }
    avl_data_array: AvlDataArray {
      codec_id: .codec16
      data: [
        AvlData {
          timestamp: 0x00_00_01_6B_DB_C7_83_30
        	priority: .low
        	gps_element: GpsElement {
           	longitude: 0.00
            latitude: 0.00
            altitude: 0
            angle: 0
            satellites: 0
            speed: 0
        	}
        	io_element: AvlIoElement {
            codec_id: .codec16
        		event_io_id: 0x00_0B
        		number_of_total_io: 0x04
            generation_type: .on_change
        		n1_elements: n1_elements
        		n2_elements: n2_elements_first
         }
        },
        AvlData {
          timestamp: 0x00_00_01_6B_DB_C7_87_18
        	priority: .low
        	gps_element: GpsElement {
           	longitude: 0.00
            latitude: 0.00
            altitude: 0
            angle: 0
            satellites: 0
            speed: 0
        	}
        	io_element: AvlIoElement {
            codec_id: .codec16
        		event_io_id: 0x00_0B
        		number_of_total_io: 0x04
            generation_type: .on_change
        		n1_elements: n1_elements
        		n2_elements: n2_elements_second
         }
        }
      ]
    }
    crc_16: Crc16 {
      value: 0x00_00_5F_B3
    }
    response: TcpAvlResponse {
      response: 0x00_00_00_02
    }
  }
}

pub const udp_data_byte_array_codec16 := hex.decode('015BCAFE0101000F33353230393430383532333135393210010000015117E40FE80000000000000000000000000000000000EF05050400010000030000B40000EF01010042111A000001')!

pub fn udp_data_codec16() UdpAvlData {
  mut n1_elements := map[u16][]u8{}
	n1_elements[0x00_01] = [u8(0x00)]
	n1_elements[0x00_03] = [u8(0x00)]
	n1_elements[0x00_B4] = [u8(0x00)]
	n1_elements[0x00_EF] = [u8(0x01)]

  mut n2_elements := map[u16][]u8{}
	n2_elements[0x00_42] = [u8(0x11), 0x1A]

  return UdpAvlData {
    udp_channel_header: UdpChannelHeader {
      length: 0x01_5B
      packet_id: 0xCA_FE
      not_usable_byte: 0x01
    }
    avl_packet_header: AvlPacketHeader {
      avl_packet_id: 0x01
      imei_length: 0x00_0F
      imei: [u8(0x33), 0x35, 0x32, 0x30, 0x39, 0x34, 0x30, 0x38, 0x35, 0x32, 0x33, 0x31, 0x35, 0x39, 0x32]
    }
    avl_data_array: AvlDataArray {
      codec_id: .codec16
      data: [
        AvlData {
          timestamp: 0x00_00_01_51_17_E4_0F_E8
        	priority: .low
        	gps_element: GpsElement {
           	longitude: 0.00
            latitude: 0.00
            altitude: 0
            angle: 0
            satellites: 0
            speed: 0
        	}
        	io_element: AvlIoElement {
            codec_id: .codec16
        		event_io_id: 0x00_EF
        		number_of_total_io: 0x05
            generation_type: .on_change
        		n1_elements: n1_elements
        		n2_elements: n2_elements
         }
        },
      ]
    }
    response: UdpAvlResponse {
      length: 0x01_5B
      packet_id: 0xCA_FE
      not_usable_byte: 0x01
      avl_packet_id: 0x01
      num_accepted_data: 0x01
    }
  }
}
