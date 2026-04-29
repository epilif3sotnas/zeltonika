module handler


// internal
import public.api.avldata { TcpAvlData, UdpAvlData }
import internal.utils.bytebuffer { ByteBuffer }
import internal.utils.tuple { Tuple }


pub interface IZeltonikaHandler {
	encode_udp_bulk(data []Tuple[ByteBuffer, UdpAvlData]) !
	decode_udp_bulk(mut byte_buffers []ByteBuffer) ![]UdpAvlData
	encode_tcp_bulk(data []Tuple[mut ByteBuffer, TcpAvlData]) !
	decode_tcp_bulk(mut byte_buffers []ByteBuffer) ![]TcpAvlData
}
