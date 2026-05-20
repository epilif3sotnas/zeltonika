module handler


// internal
import public.api.avldata { TcpAvlData, UdpAvlData }
import internal.parser.transport { ITransportParser, TransportParser }
import internal.utils.bytebuffer { ByteBuffer }
import internal.utils.tuple { Tuple }


pub struct ZeltonikaHandler implements IZeltonikaHandler {
  transport_parser ITransportParser
}


pub fn ZeltonikaHandler.new() ZeltonikaHandler {
  return ZeltonikaHandler.new_test(
    TransportParser.new(),
  )
}

pub fn ZeltonikaHandler.new_test(transport_parser ITransportParser) ZeltonikaHandler {
  return ZeltonikaHandler {
    transport_parser: transport_parser,
  }
}

pub fn (self &ZeltonikaHandler) encode_udp_bulk(mut data []Tuple) ! {
	for mut item in data {
		self.transport_parser.encode_udp(mut item.first, item.second as UdpAvlData)!
	}
}

pub fn (self &ZeltonikaHandler) decode_udp_bulk(mut byte_buffers []ByteBuffer) ![]UdpAvlData {
	mut results := []UdpAvlData{ cap: byte_buffers.len }

	for mut byte_buffer in byte_buffers {
	  byte_buffer.reset_position()
		udp_avl_data := self.transport_parser.decode_udp(mut byte_buffer)!
		results << udp_avl_data
	}

	return results
}

pub fn (self &ZeltonikaHandler) encode_tcp_bulk(mut data []Tuple) ! {
	for mut item in data {
		self.transport_parser.encode_tcp(mut item.first, item.second as TcpAvlData)!
	}
}

pub fn (self &ZeltonikaHandler) decode_tcp_bulk(mut byte_buffers []ByteBuffer) ![]TcpAvlData {
	mut results := []TcpAvlData{ cap: byte_buffers.len }

	for mut byte_buffer in byte_buffers {
    byte_buffer.reset_position()
		tcp_avl_data := self.transport_parser.decode_tcp(mut byte_buffer)!
		results << tcp_avl_data
	}

	return results
}
