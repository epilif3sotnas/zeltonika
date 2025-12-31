module utils


fn test__new__should_return_an_empty_byte_buffer() {
  buffer := ByteBuffer.new()

	assert buffer.size() == 0
	assert buffer.capacity() == 0
	assert buffer.position() == 0
	assert buffer.is_read_only() == false
}

fn test__from_bytes__should_return_a_byte_buffer_with_data_from_param() {
	input := 'Hello, World!'.bytes()

	buffer := ByteBuffer.from_bytes(input)

	assert buffer.size() == usize(input.len)
	assert buffer.capacity() == usize(input.len)
	assert buffer.position() == usize(input.len)
	assert buffer.is_read_only() == false
}

fn test__with_capacity__should_return_empty_byte_buffer_with_capacity_100() {
  capacity := usize(100)

  buffer := ByteBuffer.with_capacity(capacity)

  assert buffer.size() == 0
  assert buffer.capacity() == capacity
  assert buffer.position() == 0
  assert buffer.is_read_only() == false
}

fn test__clear__should_clear_the_data_that_was_on_the_buffer() {
  input := 'Hello, World!'.bytes()

	mut buffer := ByteBuffer.from_bytes(input)

	assert buffer.size() == usize(input.len)
	assert buffer.capacity() == usize(input.len)
	assert buffer.position() == usize(input.len)
	assert buffer.is_read_only() == false

	buffer.clear()

	assert buffer.size() == 0
	assert buffer.capacity() == usize(input.len)
	assert buffer.position() == 0
	assert buffer.is_read_only() == false
}

fn test__reset_position__should_return_position_zero() {
	input := [u8(0x01), 0x02, 0x03, 0x04]!

	mut buffer := ByteBuffer.new()
	buffer.put(input)!

	assert buffer.position() == usize(input.len)

	buffer.reset_position()
	assert buffer.position() == 0
}

fn test__reset_position_last__should_go_to_last_position() {
	input := [u8(0x01), 0x02, 0x03]!

	mut buffer := ByteBuffer.new()
	buffer.put(input)!

	assert buffer.position() == usize(input.len)

	buffer.set_new_position(1)!

	pos_before_reset := buffer.position()
	buffer.reset_position_last()

	expected := usize(3)
	actual := buffer.position()

	assert pos_before_reset != expected
	assert expected == actual
}

fn test__reset_position_last__should_stay_zero_when_empty_then_go_to_last() {
	mut buffer := ByteBuffer.new()

	assert buffer.position() == 0
	buffer.reset_position_last()
	assert buffer.position() == 0

	input := [u8(0x01), 0x02, 0x03]!
	buffer.put(input)!

	buffer.reset_position_last()
	assert buffer.position() == usize(input.len)
}

fn test__set_new_position__should_change_position() {
	mut buffer := ByteBuffer.new()

	input_write := [u8(0x01), 0x02, 0x03]!
	buffer.put(input_write)!

	new_position := usize(1)
	buffer.set_new_position(new_position)!

	assert buffer.position() == usize(new_position)
}

fn test__set_new_position__should_return_out_of_bounds_error() {
	mut buffer := ByteBuffer.new()

	input_write := [u8(0x01), 0x02, 0x03]!
	buffer.put(input_write)!

	buffer.set_new_position(10) or {
		assert err is ByteBufferError
		byte_buffer_error := err as ByteBufferError
		assert byte_buffer_error.err is PositionOutOfBoundsError
		return
	}
	assert false
}

fn test__set_read_only__should_make_buffer_read_only() {
	mut buffer := ByteBuffer.new()

	buffer.set_read_only()

	assert buffer.is_read_only() == true
}

fn test__as_bytes__should_return_array() {
	expected := [u8(0x01), 0x02, 0x03]!

	buffer := ByteBuffer.from_bytes(expected[..])
	actual := buffer.as_bytes()

	assert expected.len == actual.len
	assert expected[..] == actual
	assert buffer.size() == usize(expected.len)
	assert buffer.capacity() == usize(expected.len)
	assert buffer.position() == usize(expected.len)
	assert buffer.is_read_only() == false
}

fn test__from_position__should_return_subset() {
	input := [u8(0x01), 0x02, 0x03, 0x04]
	mut buffer := ByteBuffer.from_bytes(input)

	buffer.set_new_position(2)!

	expected := [u8(0x03), 0x04]
	actual := buffer.from_position()

	assert expected.len == actual.len
	assert expected == actual
}

fn test__to_position__should_return_subset() {
  input := [u8(0x01), 0x02, 0x03, 0x04]
	mut buffer := ByteBuffer.from_bytes(input)

	buffer.set_new_position(2)!

	expected := [u8(0x01), 0x02, 0x03]
	actual := buffer.to_position()

	assert expected.len == actual.len
	assert expected == actual
}

@[packed]
struct TestStruct {
	a1 u16
	a2 i16
	a3 bool
	a4 f32 // V has f32/f64; encoding.binary will map to that
}

fn test__get__should_return_values_without_error() {
	mut buffer := ByteBuffer.new()

	input := [u8(0x01), 0x02, 0x03, 0x04, 0x01, 0x40, 0x49, 0x00, 0x00, 0x01, 0x02]!
	buffer.put(input)!
	buffer.reset_position()

	expected_value_u16 := u16(0x0102)
	actual_value_u16 := buffer.get[u16]()!

	mut expected_pos := usize(2)

	assert expected_value_u16 == actual_value_u16
	assert expected_pos == buffer.position()

	expected_value_i16 := i16(0x0304)
	actual_value_i16 := buffer.get[i16]()!

	expected_pos = 4

	assert expected_value_i16 == actual_value_i16
	assert expected_pos == buffer.position()

	expected_value_bool := true
	actual_value_bool := buffer.get[bool]()!

	expected_pos = 5

	assert expected_value_bool == actual_value_bool
	assert expected_pos == buffer.position()

	expected_value_f32 := f32(3.140625)
	actual_value_f32 := buffer.get[f32]()!

	expected_pos = 9

	assert expected_value_f32 == actual_value_f32
	assert expected_pos == buffer.position()

	expected_value_fixed_array := [u8(1), 2]!
	actual_value_fixed_array := buffer.get[[2]u8]()!

	expected_pos = 11

	assert expected_value_fixed_array == actual_value_fixed_array
	assert expected_pos == buffer.position()
}

fn test__get__should_return_struct_without_error() {
	mut buffer := ByteBuffer.new()
	data := [u8(0x01), 0x02, 0x03, 0x04, 0x01, 0x40, 0x49, 0x00, 0x00]!
	buffer.put(data)!
	buffer.reset_position()

	expected := TestStruct {
		a1: 0x0102
		a2: 0x0304
		a3: true
		a4: f32(3.140625)
	}
	expected_pos := usize(data.len)
	actual := buffer.get[TestStruct]()!

	assert expected == actual
	assert expected_pos == buffer.position()
}

@[packed]
struct TestStruct2 {
	a1 bool
	a2 TestStruct
}

fn test__get__should_return_nested_struct_without_error() {
	mut buffer := ByteBuffer.new()

	value := TestStruct2{
		a1: false
		a2: TestStruct{
			a1: 0x0102
			a2: 0x0304
			a3: true
			a4: f32(3.140625)
		}
	}
	data := [u8(0x00), 0x01, 0x02, 0x03, 0x04, 0x01, 0x40, 0x49, 0x00, 0x00]!
	buffer.put(data)!
	buffer.reset_position()

	expected_pos := buffer.size()
	actual := buffer.get[TestStruct2]()!


	assert value.a1 == actual.a1
	assert value.a2.a1 == actual.a2.a1
	assert value.a2.a2 == actual.a2.a2
	assert value.a2.a3 == actual.a2.a3
	assert value.a2.a4 == actual.a2.a4
	assert expected_pos == buffer.position()
}

fn test__get__should_return_not_enough_data_error() {
	mut buffer := ByteBuffer.new()

	small := [u8(0x01), 0x02]!
	buffer.put(small)!
	buffer.reset_position()

	buffer.get[TestStruct]() or {
		assert err is ByteBufferError
		byte_buffer_error := err as ByteBufferError
		assert byte_buffer_error.err is NotEnoughDataError
		return
	}
	assert false
}

fn test__put__should_add_bytes_without_error() {
	mut buffer := ByteBuffer.new()

	test_struct := TestStruct {
		a1: 0x0102
		a2: 0x0304
		a3: true
		a4: f32(3.140625)
	}
	buffer.put(test_struct)!

	expected := [u8(0x01), 0x02, 0x03, 0x04, 0x01, 0x40, 0x49, 0x00, 0x00]
	actual := buffer.as_bytes()

	assert expected.len == actual.len
	assert expected == actual
	assert buffer.size() == usize(actual.len)
}

fn test__put__should_return_read_only_error() {
	mut buffer := ByteBuffer.new()
	buffer.set_read_only()

	buffer.put[u8](0x01) or {
		assert err is ByteBufferError
		byte_buffer_error := err as ByteBufferError
		assert byte_buffer_error.err is ReadOnlyBufferError
		return
	}
	assert false
}
