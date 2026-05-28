module handler


// internal
import public.api.avldata { TcpAvlData, UdpAvlData }
import internal.utils.bytebuffer { ByteBuffer }
import internal.utils.tuple { Tuple }


pub interface IZeltonikaHandler {
	encode_udp_bulk(mut data []Tuple) !
	decode_udp_bulk(mut byte_buffers []ByteBuffer) ![]UdpAvlData
	encode_tcp_bulk(mut data []Tuple) !
	decode_tcp_bulk(mut byte_buffers []ByteBuffer) ![]TcpAvlData
}
