module h_transport


// internal
import public.api.avldata { TcpAvlData, AvlDataPacketHeader, TcpAvlResponse, Crc16, UdpAvlData, UdpChannelHeader, AvlPacketHeader, UdpAvlResponse, AvlDataArray }


pub const tcp_data_byte_array := [
  u8(0x00), 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x36,
  0x08, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x13,
]

pub fn tcp_data() TcpAvlData {
  return TcpAvlData {
    avl_data_packet_header: AvlDataPacketHeader {
      zero_bytes: 0x00
      data_field_length: 0x36
    }
    avl_data_array: AvlDataArray{
      codec_id: .codec8
    }
    crc_16: Crc16 {
      value: 0x13
    }
    response: TcpAvlResponse {
      response: 0x00_00_00_01
    }
  }
}

pub const udp_data_byte_array := [
  u8(0x00), 0x3d, 0xca, 0xfe, 0x00,
  0x05, 0x00, 0x0f, 0x33, 0x35, 0x32,
  0x30, 0x39, 0x33, 0x30, 0x38, 0x36,
  0x34, 0x30, 0x33, 0x36, 0x35, 0x35,
  0x08, 0x00, 0x00,
]

pub fn udp_data() UdpAvlData {
  return UdpAvlData {
    udp_channel_header: UdpChannelHeader {
      length: 0x003d
      packet_id: 0xcafe
      not_usable_byte: 0x00
    }
    avl_packet_header: AvlPacketHeader {
      avl_packet_id: 0x05
      imei_length: 0x0f
      imei: [u8(0x33), 0x35, 0x32, 0x30, 0x39, 0x33, 0x30, 0x38, 0x36, 0x34, 0x30, 0x33, 0x36, 0x35, 0x35]
    }
    avl_data_array: AvlDataArray {
      codec_id: .codec8
    }
    response: UdpAvlResponse {
      length: 0x003d
      packet_id: 0xcafe
      not_usable_byte: 0x00
      avl_packet_id: 0x05
      num_accepted_data: 0x00
    }
  }
}
