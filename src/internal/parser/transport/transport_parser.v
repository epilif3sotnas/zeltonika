module transport


// internal
import public.api.avldata { TcpAvlData, AvlDataPacketHeader TcpAvlResponse, Crc16, UdpAvlData, UdpChannelHeader, AvlPacketHeader, UdpAvlResponse, AvlData, AvlDataArray, CodecId }
import internal.parser.transport.avl.bin { IAvlBinParser, AvlBinParser }
import internal.parser.transport.crc { ICrc, Crc }
import internal.utils.bytebuffer { ByteBuffer }
import internal.parser.transport.models { AvlDataPacketHeaderPacked, UdpChannelHeaderPacked, AvlPacketHeaderPacked, Crc16Packed }


pub struct TransportParser implements ITransportParser {
	avl_bin_parser IAvlBinParser
mut:
	crc ICrc
}

pub fn TransportParser.new() TransportParser {
  return TransportParser.new_test(
    AvlBinParser.new(),
    Crc.new(),
  )
}

pub fn TransportParser.new_test(avl_bin_parser IAvlBinParser, crc_obj ICrc) TransportParser {
  return TransportParser {
    avl_bin_parser: avl_bin_parser
    crc: crc_obj
  }
}

pub fn (mut self TransportParser) encode_tcp(mut byte_buffer ByteBuffer, tcp_avl_data TcpAvlData) ! {
  byte_buffer.put(
    AvlDataPacketHeaderPacked {
      zero_bytes: tcp_avl_data.avl_data_packet_header.zero_bytes
     	data_field_length: tcp_avl_data.avl_data_packet_header.data_field_length
    }
  )!

  byte_buffer.put(u8(tcp_avl_data.avl_data_array.codec_id))!
  crc_start_pos := usize(byte_buffer.position() - 1)

  self.encode_avl_data_array(mut byte_buffer, tcp_avl_data.avl_data_array)!
  byte_buffer.set_new_position(crc_start_pos)!

  crc_value := self.crc.calculate(byte_buffer.from_position())

  byte_buffer.reset_position_last()
  byte_buffer.put(u32(crc_value))!
}

pub fn (self &TransportParser) encode_udp(mut byte_buffer ByteBuffer, udp_avl_data UdpAvlData) ! {
  byte_buffer.put(
    UdpChannelHeaderPacked {
      length: udp_avl_data.udp_channel_header.length
     	packet_id: udp_avl_data.udp_channel_header.packet_id
     	not_usable_byte: udp_avl_data.udp_channel_header.not_usable_byte
    }
  )!

  byte_buffer.put(
    AvlPacketHeaderPacked {
      avl_packet_id: udp_avl_data.avl_packet_header.avl_packet_id
     	imei_length: udp_avl_data.avl_packet_header.imei_length
    }
  )!

  byte_buffer.put(udp_avl_data.avl_packet_header.imei)!

  byte_buffer.put(u8(udp_avl_data.avl_data_array.codec_id))!
  self.encode_avl_data_array(mut byte_buffer, udp_avl_data.avl_data_array)!

}

fn (self &TransportParser) encode_avl_data_array(mut byte_buffer ByteBuffer, avl_data_array AvlDataArray) ! {
  byte_buffer.put(u8(avl_data_array.data.len))!

  for avl_data in avl_data_array.data {
    self.avl_bin_parser.encode(mut byte_buffer, avl_data)!
  }

  byte_buffer.put(u8(avl_data_array.data.len))!
}

pub fn (mut self TransportParser) decode_tcp(mut byte_buffer ByteBuffer) !TcpAvlData {
  avl_data_packed_header := byte_buffer.get[AvlDataPacketHeaderPacked]()!
  codec_id := CodecId.from(byte_buffer.get[u8]()!)!

  crc_start_pos := usize(byte_buffer.position() - 1)

  avl_data_array := self.decode_avl_data_array(mut byte_buffer, codec_id)!
  avl_data_num_elements := byte_buffer.get[u8]()!

  crc_value := byte_buffer.get[Crc16Packed]()!

  byte_buffer.set_new_position(crc_start_pos)!
  crc_calculated := self.crc.calculate(byte_buffer.from_position())
  byte_buffer.reset_position_last()

  // TODO: Check if CRC is valid
  is_crc_valid := crc_value.value == crc_calculated

  return TcpAvlData {
    avl_data_packet_header: AvlDataPacketHeader {
      zero_bytes: avl_data_packed_header.zero_bytes
     	data_field_length: avl_data_packed_header.data_field_length
    }
  	avl_data_array: avl_data_array
  	crc_16: Crc16 {
      value: crc_value.value
    }
  	response: TcpAvlResponse {
      response: avl_data_num_elements
    }
  }
}

pub fn (self &TransportParser) decode_udp(mut byte_buffer ByteBuffer) !UdpAvlData {
  udp_channel_header := byte_buffer.get[UdpChannelHeaderPacked]()!
  avl_packed_header := byte_buffer.get[AvlPacketHeaderPacked]()!

  mut imei := []u8{}

  for _ in 0 .. avl_packed_header.imei_length {
    imei << byte_buffer.get[u8]()!
  }

  codec_id := CodecId.from(byte_buffer.get[u8]()!)!
  avl_data_array := self.decode_avl_data_array(mut byte_buffer, codec_id)!

  // Ignore 2 Avl Data Number of Elements
  _ := byte_buffer.get[u8]()!

  return UdpAvlData {
    udp_channel_header: UdpChannelHeader {
      length: udp_channel_header.length
     	packet_id: udp_channel_header.packet_id
     	not_usable_byte: udp_channel_header.not_usable_byte
    }
  	avl_packet_header: AvlPacketHeader {
      avl_packet_id: avl_packed_header.avl_packet_id
     	imei_length: avl_packed_header. imei_length
     	imei: imei
    }
  	avl_data_array: avl_data_array
  	response: UdpAvlResponse {
      length: udp_channel_header.length
    	packet_id: udp_channel_header.packet_id
    	not_usable_byte: udp_channel_header.not_usable_byte
      avl_packet_id: avl_packed_header.avl_packet_id
     	num_accepted_data: u8(avl_data_array.data.len)
   }
  }
}

fn (self &TransportParser) decode_avl_data_array(mut byte_buffer ByteBuffer, codec_id CodecId) !AvlDataArray {
  avl_data_num_elements := byte_buffer.get[u8]()!

  mut avl_data_elements := []AvlData{}

  for _ in 0 .. avl_data_num_elements {
    avl_data_elements << self.avl_bin_parser.decode(mut byte_buffer, codec_id)!
  }

  return AvlDataArray {
    codec_id: codec_id
    data: avl_data_elements
  }
}
