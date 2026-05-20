module integration_tests


// internal
import public.api { Zeltonika }
import public.api.avldata { AvlData, AvlDataArray, AvlIoElement, CodecId, GpsElement, Priority, AvlDataPacketHeader, TcpAvlData, TcpAvlResponse, Crc16, AvlPacketHeader, UdpAvlData, UdpAvlResponse, UdpChannelHeader }
import public.api.config { ZeltonikaConfig }
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

// // ============================================================================
// // Error handling tests
// // ============================================================================

// fn test__decode_tcp__should_fail_on_corrupted_data() {
// 	z := Zeltonika.new()

// 	// Valid encoded data
// 	tcp_data := create_sample_tcp_avl_data()
// 	mut encoded := z.encode_tcp(tcp_data)!

// 	// Corrupt a byte in the middle
// 	encoded[10] ^= 0xFF

// 	decoded := z.decode_tcp(encoded) or {
// 		assert true // Expected to fail
// 		return
// 	}
// 	assert false // Should not reach here
// }

// fn test__decode_udp__should_fail_on_corrupted_data() {
// 	z := Zeltonika.new()

// 	// Valid encoded data
// 	udp_data := create_sample_udp_avl_data()
// 	mut encoded := z.encode_udp(udp_data)!

// 	// Corrupt a byte in the middle
// 	encoded[15] ^= 0xFF

// 	decoded := z.decode_udp(encoded) or {
// 		assert true // Expected to fail
// 		return
// 	}
// 	assert false // Should not reach here
// }

// fn test__decode_tcp__should_fail_on_empty_data() {
// 	z := Zeltonika.new()

// 	empty_data := []u8{}

// 	decoded := z.decode_tcp(empty_data) or {
// 		assert true // Expected to fail
// 		return
// 	}
// 	assert false // Should not reach here
// }

// fn test__decode_udp__should_fail_on_empty_data() {
// 	z := Zeltonika.new()

// 	empty_data := []u8{}

// 	decoded := z.decode_udp(empty_data) or {
// 		assert true // Expected to fail
// 		return
// 	}
// 	assert false // Should not reach here
// }
