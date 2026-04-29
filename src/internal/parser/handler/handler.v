module handler


// internal
import public.api.avldata { TcpAvlData, UdpAvlData }
import internal.parser.transport { ITransportParser }
import internal.utils.tuple { Tuple }


pub struct ZeltonikaHandler implements IZeltonikaHandler {
  transport_parser ITransportParser
}


pub fn ZeltonikaHandler.new() ZeltonikaHandler {
  return ZeltonikaHandler.new_test()
}

pub fn ZeltonikaHandler.new_test(transport_parser ITransportParser) ZeltonikaHandler {
  return ZeltonikaHandler {
    transport_parser: transport_parser
  }
}

pub fn (self &ZeltonikaHandler) encode_udp_bulk(data []Tuple[ByteBuffer, UdpAvlData]) ! {
	for mut item in data {
		mut byte_buffer := item.a
		udp_avl_data := item.b
		self.transport_parser.encode_udp(mut byte_buffer, udp_avl_data)!
	}
}

pub fn (self &ZeltonikaHandler) decode_udp_bulk(mut byte_buffers []ByteBuffer) ![]UdpAvlData {
	mut results := []UdpAvlData{ cap: byte_buffers.len }

	for mut byte_buffer in byte_buffers {
		udp_avl_data := self.transport_parser.decode_udp(mut byte_buffer)!
		results << udp_avl_data
	}

	return results
}

pub fn (self &ZeltonikaHandler) encode_tcp_bulk(data []Tuple[mut ByteBuffer, TcpAvlData]) ! {
	for mut item in data {
		self.transport_parser.encode_tcp(mut item.a, item.b)!
	}
}

pub fn (self &ZeltonikaHandler) decode_tcp_bulk(mut byte_buffers []ByteBuffer) ![]TcpAvlData {
	mut results := []TcpAvlData{ cap: byte_buffers.len }

	for mut byte_buffer in byte_buffers {
		tcp_avl_data := self.transport_parser.decode_tcp(mut byte_buffer)!
		results << tcp_avl_data
	}

	return results
}
