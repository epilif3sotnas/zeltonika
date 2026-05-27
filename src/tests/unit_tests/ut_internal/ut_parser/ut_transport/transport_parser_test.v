module ut_transport


// internal
import internal.utils.bytebuffer { ByteBuffer }
import internal.parser.transport { TransportParser }
import internal.parser.transport.errors { CrcError, AvlPacketSizeError, AvlPacketSizeLimitType }
import tests.helpers.h_internal.h_parser.h_transport as helpers_transport
import tests.helpers.h_internal.h_parser.h_transport.h_avl.h_bin as helpers_avl_bin
import tests.helpers.h_internal.h_parser.h_transport.h_crc as helpers_crc


const no_op_bin_parser := helpers_avl_bin.NoOpAvlBinParser.new()
const no_op_crc := helpers_crc.NoOpCrc.new()


fn test__new__should_init() {
  transport_parser := TransportParser.new()
}

fn test__encode_tcp__should_write_to_the_buffer_tcp_avl_data() {
  transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

  mut buffer := ByteBuffer.new()

  input := helpers_transport.tcp_data()

  transport_parser.encode_tcp(mut buffer, input)!

  actual := buffer.as_bytes()
  expected := helpers_transport.tcp_data_byte_array

  assert expected == actual
}

fn test__encode_udp__should_write_to_the_buffer_udp_avl_data() {
  transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

  mut buffer := ByteBuffer.new()

  input := helpers_transport.udp_data()

  transport_parser.encode_udp(mut buffer, input)!

  actual := buffer.as_bytes()
  expected := helpers_transport.udp_data_byte_array

  assert expected == actual
}

fn test__decode_tcp__should_read_from_the_buffer_a_tcp_avl_data() {
  transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

  data_to_decode := helpers_transport.tcp_data_byte_array_filled
  mut buffer := ByteBuffer.from_bytes(data_to_decode)
  buffer.reset_position()

  expected := helpers_transport.tcp_data()
  actual := transport_parser.decode_tcp(mut buffer)!

  assert data_to_decode == buffer.as_bytes()
  assert expected == actual
}

fn test__decode_tcp__should_return_a_crc_error() {
    transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

    mut data_to_decode := helpers_transport.tcp_data_byte_array_filled.clone()
    // Modifying the crc value to trigger mismatch
    data_to_decode[14] = data_to_decode[14] ^ 0xFF
    mut buffer := ByteBuffer.from_bytes(data_to_decode)
    buffer.reset_position()

    actual := transport_parser.decode_tcp(mut buffer) or {
        assert err is CrcError
        return
    }

    assert false
}

fn test__decode_tcp__should_return_a_min_avl_packet_size_error() {
    transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

    data_to_decode := [u8(0x00), 0x00, 0x12, 0x23]
    mut buffer := ByteBuffer.from_bytes(data_to_decode)
    buffer.reset_position()

    actual := transport_parser.decode_tcp(mut buffer) or {
        assert err is AvlPacketSizeError
        assert (err as AvlPacketSizeError).avl_packet_size_limit_type == .min
        return
    }

    assert false
}

fn test__decode_tcp__should_return_a_max_avl_packet_size_error() {
    transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

    data_to_decode := [1500]u8{}[..]
    mut buffer := ByteBuffer.from_bytes(data_to_decode)
    buffer.reset_position()

    actual := transport_parser.decode_tcp(mut buffer) or {
        assert err is AvlPacketSizeError
        assert (err as AvlPacketSizeError).avl_packet_size_limit_type == .max
        return
    }

    assert false
}

fn test__decode_udp__should_read_from_the_buffer_a_udp_avl_data() {
  transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

  data_to_decode := helpers_transport.udp_data_byte_array_filled
  mut buffer := ByteBuffer.from_bytes(data_to_decode)
  buffer.reset_position()

  expected := helpers_transport.udp_data()
  actual := transport_parser.decode_udp(mut buffer)!

  assert data_to_decode == buffer.as_bytes()
  assert expected == actual
}

fn test__decode_udp__should_return_a_min_avl_packet_size_error() {
    transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

    data_to_decode := [u8(0x00), 0x00, 0x12, 0x23]
    mut buffer := ByteBuffer.from_bytes(data_to_decode)
    buffer.reset_position()

    actual := transport_parser.decode_udp(mut buffer) or {
        assert err is AvlPacketSizeError
        assert (err as AvlPacketSizeError).avl_packet_size_limit_type == .min
        return
    }

    assert false
}

fn test__decode_udp__should_return_a_max_avl_packet_size_error() {
    transport_parser := TransportParser.new_test(no_op_bin_parser, no_op_crc)

    data_to_decode := [1500]u8{}[..]
    mut buffer := ByteBuffer.from_bytes(data_to_decode)
    buffer.reset_position()

    actual := transport_parser.decode_udp(mut buffer) or {
        assert err is AvlPacketSizeError
        assert (err as AvlPacketSizeError).avl_packet_size_limit_type == .max
        return
    }

    assert false
}
