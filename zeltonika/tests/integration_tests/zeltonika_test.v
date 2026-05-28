module integration_tests


// internal
import public.api { Zeltonika }
import public.api.avldata { AvlData, AvlDataArray, AvlIoElement, CodecId, GpsElement, Priority, AvlDataPacketHeader, TcpAvlData, TcpAvlResponse, Crc16, AvlPacketHeader, UdpAvlData, UdpAvlResponse, UdpChannelHeader }
import public.api.config { ZeltonikaConfig }
import public.api.errors as zeltonika_errors { ZeltonikaError }
import internal.parser.transport.errors as transport_errors { AvlPacketSizeError, CrcError }
import internal.utils.bytebuffer { ByteBufferError, NotEnoughDataError }
import tests.helpers.h_avldata as helpers_avldata


// ============================================================================
// Codec8 tests - happy path
// ============================================================================

fn test__encode_tcp__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.tcp_data_byte_array_codec8
	actual := zeltonika_lib.encode_tcp(helpers_avldata.tcp_data_codec8())!

	assert actual == expected
}

fn test__encode_tcp_bulk__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.tcp_data_byte_array_codec8, helpers_avldata.tcp_data_byte_array_codec8]
	actual := zeltonika_lib.encode_tcp_bulk([helpers_avldata.tcp_data_codec8(), helpers_avldata.tcp_data_codec8()])!

	assert actual == expected
}

fn test__decode_tcp__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.tcp_data_codec8()
	actual := zeltonika_lib.decode_tcp(helpers_avldata.tcp_data_byte_array_codec8)!

	assert actual == expected
}

fn test__decode_tcp_bulk__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.tcp_data_codec8(), helpers_avldata.tcp_data_codec8()]
	actual := zeltonika_lib.decode_tcp_bulk([helpers_avldata.tcp_data_byte_array_codec8, helpers_avldata.tcp_data_byte_array_codec8])!

	assert actual == expected
}

fn test__encode_udp__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.udp_data_byte_array_codec8
	actual := zeltonika_lib.encode_udp(helpers_avldata.udp_data_codec8())!

	assert actual == expected
}

fn test__encode_udp_bulk__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.udp_data_byte_array_codec8, helpers_avldata.udp_data_byte_array_codec8]
	actual := zeltonika_lib.encode_udp_bulk([helpers_avldata.udp_data_codec8(), helpers_avldata.udp_data_codec8()])!

	assert actual == expected
}

fn test__decode_udp__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.udp_data_codec8()
	actual := zeltonika_lib.decode_udp(helpers_avldata.udp_data_byte_array_codec8)!

	assert actual == expected
}

fn test__decode_udp_bulk__codec8__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.udp_data_codec8(), helpers_avldata.udp_data_codec8()]
	actual := zeltonika_lib.decode_udp_bulk([helpers_avldata.udp_data_byte_array_codec8, helpers_avldata.udp_data_byte_array_codec8])!

	assert actual == expected
}

// ============================================================================
// Codec8e tests - happy path
// ============================================================================

fn test__encode_tcp__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.tcp_data_byte_array_codec8e
	actual := zeltonika_lib.encode_tcp(helpers_avldata.tcp_data_codec8e())!

	assert actual == expected
}

fn test__encode_tcp_bulk__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.tcp_data_byte_array_codec8e, helpers_avldata.tcp_data_byte_array_codec8e]
	actual := zeltonika_lib.encode_tcp_bulk([helpers_avldata.tcp_data_codec8e(), helpers_avldata.tcp_data_codec8e()])!

	assert actual == expected
}

fn test__decode_tcp__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.tcp_data_codec8e()
	actual := zeltonika_lib.decode_tcp(helpers_avldata.tcp_data_byte_array_codec8e)!

	assert actual == expected
}

fn test__decode_tcp_bulk__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.tcp_data_codec8e(), helpers_avldata.tcp_data_codec8e()]
	actual := zeltonika_lib.decode_tcp_bulk([helpers_avldata.tcp_data_byte_array_codec8e, helpers_avldata.tcp_data_byte_array_codec8e])!

	assert actual == expected
}

fn test__encode_udp__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.udp_data_byte_array_codec8e
	actual := zeltonika_lib.encode_udp(helpers_avldata.udp_data_codec8e())!

	assert actual == expected
}

fn test__encode_udp_bulk__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.udp_data_byte_array_codec8e, helpers_avldata.udp_data_byte_array_codec8e]
	actual := zeltonika_lib.encode_udp_bulk([helpers_avldata.udp_data_codec8e(), helpers_avldata.udp_data_codec8e()])!

	assert actual == expected
}

fn test__decode_udp__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.udp_data_codec8e()
	actual := zeltonika_lib.decode_udp(helpers_avldata.udp_data_byte_array_codec8e)!

	assert actual == expected
}

fn test__decode_udp_bulk__codec8e__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.udp_data_codec8e(), helpers_avldata.udp_data_codec8e()]
	actual := zeltonika_lib.decode_udp_bulk([helpers_avldata.udp_data_byte_array_codec8e, helpers_avldata.udp_data_byte_array_codec8e])!

	assert actual == expected
}

// ============================================================================
// Codec16 tests - happy path
// ============================================================================

fn test__encode_tcp__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.tcp_data_byte_array_codec16
	actual := zeltonika_lib.encode_tcp(helpers_avldata.tcp_data_codec16())!

	assert actual == expected
}

fn test__encode_tcp_bulk__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.tcp_data_byte_array_codec16, helpers_avldata.tcp_data_byte_array_codec16]
	actual := zeltonika_lib.encode_tcp_bulk([helpers_avldata.tcp_data_codec16(), helpers_avldata.tcp_data_codec16()])!

	assert actual == expected
}

fn test__decode_tcp__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.tcp_data_codec16()
	actual := zeltonika_lib.decode_tcp(helpers_avldata.tcp_data_byte_array_codec16)!

	assert actual == expected
}

fn test__decode_tcp_bulk__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.tcp_data_codec16(), helpers_avldata.tcp_data_codec16()]
	actual := zeltonika_lib.decode_tcp_bulk([helpers_avldata.tcp_data_byte_array_codec16, helpers_avldata.tcp_data_byte_array_codec16])!

	assert actual == expected
}

fn test__encode_udp__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.udp_data_byte_array_codec16
	actual := zeltonika_lib.encode_udp(helpers_avldata.udp_data_codec16())!

	assert actual == expected
}

fn test__encode_udp_bulk__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.udp_data_byte_array_codec16, helpers_avldata.udp_data_byte_array_codec16]
	actual := zeltonika_lib.encode_udp_bulk([helpers_avldata.udp_data_codec16(), helpers_avldata.udp_data_codec16()])!

	assert actual == expected
}

fn test__decode_udp__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := helpers_avldata.udp_data_codec16()
	actual := zeltonika_lib.decode_udp(helpers_avldata.udp_data_byte_array_codec16)!

	assert actual == expected
}

fn test__decode_udp_bulk__codec16__with_real_data() {
	zeltonika_lib := Zeltonika.new()

	expected := [helpers_avldata.udp_data_codec16(), helpers_avldata.udp_data_codec16()]
	actual := zeltonika_lib.decode_udp_bulk([helpers_avldata.udp_data_byte_array_codec16, helpers_avldata.udp_data_byte_array_codec16])!

	assert actual == expected
}

// ============================================================================
// Error handling tests
// ============================================================================

fn test__decode_tcp__should_return_a_crc_error() {
   	zeltonika_lib := Zeltonika.new()

    mut data_to_decode := helpers_avldata.tcp_data_byte_array_codec8.clone()
    // Modifying the crc value to trigger mismatch
    data_to_decode[data_to_decode.len - 1] = data_to_decode[data_to_decode.len - 1] ^ 0xFF

   	zeltonika_lib.decode_tcp(data_to_decode) or {
  		assert err is ZeltonikaError
  		assert (err as ZeltonikaError).cause is CrcError
  		return
   	}

   	assert false
}

fn test__decode_tcp_bulk__should_return_a_crc_error() {
   	zeltonika_lib := Zeltonika.new()

    mut data_to_decode := [
        helpers_avldata.tcp_data_byte_array_codec8.clone(),
        helpers_avldata.tcp_data_byte_array_codec8.clone(),
    ]
    // Modifying the crc value to trigger mismatch
    data_to_decode[0][data_to_decode[0].len - 1] = data_to_decode[0][data_to_decode[0].len - 1] ^ 0xFF
    data_to_decode[1][data_to_decode[1].len - 1] = data_to_decode[1][data_to_decode[1].len - 1] ^ 0xFF

   	zeltonika_lib.decode_tcp_bulk(data_to_decode) or {
  		assert err is ZeltonikaError
  		assert (err as ZeltonikaError).cause is CrcError
  		return
   	}

   	assert false
}

fn test__decode_tcp__should_with_avl_packet_size_error_min() {
	z := Zeltonika.new()

	small_payload := [u8(1),2,3,4,5]

	z.decode_tcp(small_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_tcp_bulk__should_with_avl_packet_size_error_min() {
	z := Zeltonika.new()

	small_payload := [
    	[u8(1),2,3,4,5],
    	[u8(1),2,3,4,5],
	]

	z.decode_tcp_bulk(small_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_udp__should_with_avl_packet_size_error_min() {
	z := Zeltonika.new()

	small_payload := [u8(1),2,3,4,5]

	z.decode_udp(small_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_udp_bulk__should_with_avl_packet_size_error_min() {
	z := Zeltonika.new()

	small_payload := [
    	[u8(1),2,3,4,5],
    	[u8(1),2,3,4,5],
	]

	z.decode_udp_bulk(small_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_tcp__should_with_avl_packet_size_error_max() {
	z := Zeltonika.new()

	large_payload := [2000]u8{}[..]

	z.decode_tcp(large_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_tcp_bulk__should_with_avl_packet_size_error_max() {
	z := Zeltonika.new()

	large_payload := [
    	[2000]u8{}[..],
    	[2000]u8{}[..],
	]

	z.decode_tcp_bulk(large_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_udp__should_with_avl_packet_size_error_max() {
	z := Zeltonika.new()

	large_payload := [2000]u8{}[..]

	z.decode_udp(large_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_udp_bulk__should_with_avl_packet_size_error_max() {
	z := Zeltonika.new()

	large_payload := [
    	[2000]u8{}[..],
    	[2000]u8{}[..],
	]

	z.decode_udp_bulk(large_payload) or {
		assert err is ZeltonikaError
		assert (err as ZeltonikaError).cause is AvlPacketSizeError
		return
	}
	assert false
}

fn test__decode_tcp__should_return_a_not_enough_data_error() {
   	zeltonika_lib := Zeltonika.new()

    mut data_to_decode := helpers_avldata.tcp_data_byte_array_codec8.clone()
    // remove last element to trigger not enought data error
    data_to_decode.pop()

   	zeltonika_lib.decode_tcp(data_to_decode) or {
  		assert err is ZeltonikaError
  		assert (err as ZeltonikaError).cause is ByteBufferError
  		assert ((err as ZeltonikaError).cause as ByteBufferError).cause is NotEnoughDataError
  		return
   	}

   	assert false
}

fn test__decode_tcp_bulk__should_return_a_not_enough_data_error() {
   	zeltonika_lib := Zeltonika.new()

    mut element := helpers_avldata.tcp_data_byte_array_codec8.clone()
    // remove last element to trigger not enought data error
    element.pop()
    mut data_to_decode := [
        element.clone(),
        element.clone(),
    ]

   	zeltonika_lib.decode_tcp_bulk(data_to_decode) or {
  		assert err is ZeltonikaError
  		assert (err as ZeltonikaError).cause is ByteBufferError
  		assert ((err as ZeltonikaError).cause as ByteBufferError).cause is NotEnoughDataError
  		return
   	}

   	assert false
}

fn test__decode_udp__should_return_a_not_enough_data_error() {
   	zeltonika_lib := Zeltonika.new()

    mut data_to_decode := helpers_avldata.udp_data_byte_array_codec8.clone()
    // remove last element to trigger not enought data error
    data_to_decode.pop()

   	zeltonika_lib.decode_udp(data_to_decode) or {
  		assert err is ZeltonikaError
  		assert (err as ZeltonikaError).cause is ByteBufferError
  		assert ((err as ZeltonikaError).cause as ByteBufferError).cause is NotEnoughDataError
  		return
   	}

   	assert false
}

fn test__decode_udp_bulk__should_return_a_not_enough_data_error() {
   	zeltonika_lib := Zeltonika.new()

    mut element := helpers_avldata.udp_data_byte_array_codec8.clone()
    // remove last element to trigger not enought data error
    element.pop()
    mut data_to_decode := [
        element.clone(),
        element.clone(),
    ]

   	zeltonika_lib.decode_udp_bulk(data_to_decode) or {
  		assert err is ZeltonikaError
  		assert (err as ZeltonikaError).cause is ByteBufferError
  		assert ((err as ZeltonikaError).cause as ByteBufferError).cause is NotEnoughDataError
  		return
   	}

   	assert false
}
