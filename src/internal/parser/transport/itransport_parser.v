module transport


// internal
import public.api.avldata { TcpAvlData, UdpAvlData }
import internal.utils.bytebuffer { ByteBuffer }


pub interface ITransportParser {
	encode_udp(mut byte_buffer ByteBuffer, udp_avl_data UdpAvlData) !
	decode_udp(mut byte_buffer ByteBuffer) !UdpAvlData
mut:
	encode_tcp(mut byte_buffer ByteBuffer, tcp_avl_data TcpAvlData) !
	decode_tcp(mut byte_buffer ByteBuffer) !TcpAvlData
}
