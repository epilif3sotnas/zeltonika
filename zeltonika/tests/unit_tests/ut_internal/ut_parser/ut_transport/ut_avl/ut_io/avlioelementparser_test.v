module ut_io


// internal
import public.api.avldata { CodecId }
import internal.parser.transport.avl.io { AvlIoElementParser }
import internal.utils.bytebuffer { ByteBuffer }
import tests.helpers.h_internal.h_parser.h_transport.h_avl.h_io as helpers_avl_io


fn test__new__should_init() {
  avl_io_element_parser := AvlIoElementParser.new()
}

fn test__encode__should_write_to_the_byte_buffer_a_valid_codec_8_byte_array() {
  avl_io_element_parser := AvlIoElementParser.new()

  mut buffer := ByteBuffer.new()

  input := helpers_avl_io.avl_io_element_codec_8()

  avl_io_element_parser.encode(input, mut buffer)!

  actual := buffer.as_bytes()
  expected := helpers_avl_io.byte_array_codec_8

  assert expected == actual
}

fn test__encode__should_write_to_the_byte_buffer_a_valid_codec_8e_byte_array() {
  avl_io_element_parser := AvlIoElementParser.new()

  mut buffer := ByteBuffer.new()

  input := helpers_avl_io.avl_io_element_codec_8e()

  avl_io_element_parser.encode(input, mut buffer)!

  actual := buffer.as_bytes()
  expected := helpers_avl_io.byte_array_codec_8e

  assert expected == actual
}

fn test__encode__should_write_to_the_byte_buffer_a_valid_codec_16_byte_array() {
  avl_io_element_parser := AvlIoElementParser.new()

  mut buffer := ByteBuffer.new()

  input := helpers_avl_io.avl_io_element_codec_16()

  avl_io_element_parser.encode(input, mut buffer)!

  actual := buffer.as_bytes()
  expected := helpers_avl_io.byte_array_codec_16

  assert expected == actual
}

fn test__decode__should_read_from_byte_buffer_a_valid_codec_8_byte_array() {
  avl_io_element_parser := AvlIoElementParser.new()

  data_to_decode := helpers_avl_io.byte_array_codec_8
  mut buffer := ByteBuffer.from_bytes(data_to_decode)
  buffer.reset_position()

  expected := helpers_avl_io.avl_io_element_codec_8()
  actual := avl_io_element_parser.decode(mut buffer, CodecId.codec8)!

  assert data_to_decode == buffer.as_bytes()
  assert expected.codec_id == actual.codec_id
  assert expected.event_io_id == actual.event_io_id
  assert expected.number_of_total_io == actual.number_of_total_io
  assert expected.n1_elements.len == actual.n1_elements.len
  assert expected.n1_elements.keys() == actual.n1_elements.keys()
  assert expected.n1_elements.values() == actual.n1_elements.values()
  assert expected.n2_elements.len == actual.n2_elements.len
  assert expected.n2_elements.keys() == actual.n2_elements.keys()
  assert expected.n2_elements.values() == actual.n2_elements.values()
  assert expected.n4_elements.len == actual.n4_elements.len
  assert expected.n4_elements.keys() == actual.n4_elements.keys()
  assert expected.n4_elements.values() == actual.n4_elements.values()
  assert expected.n8_elements.len == actual.n8_elements.len
  assert expected.n8_elements.keys() == actual.n8_elements.keys()
  assert expected.n8_elements.values() == actual.n8_elements.values()
}

fn test__decode__should_read_from_the_byte_buffer_a_valid_codec_8e_byte_array() {
  avl_io_element_parser := AvlIoElementParser.new()

  data_to_decode := helpers_avl_io.byte_array_codec_8e
  mut buffer := ByteBuffer.from_bytes(data_to_decode)
  buffer.reset_position()

  expected := helpers_avl_io.avl_io_element_codec_8e()
  actual := avl_io_element_parser.decode(mut buffer, CodecId.codec8e)!

  assert data_to_decode == buffer.as_bytes()
  assert expected.codec_id == actual.codec_id
  assert expected.event_io_id == actual.event_io_id
  assert expected.number_of_total_io == actual.number_of_total_io
  assert expected.n1_elements.len == actual.n1_elements.len
  assert expected.n1_elements.keys() == actual.n1_elements.keys()
  assert expected.n1_elements.values() == actual.n1_elements.values()
  assert expected.n2_elements.len == actual.n2_elements.len
  assert expected.n2_elements.keys() == actual.n2_elements.keys()
  assert expected.n2_elements.values() == actual.n2_elements.values()
  assert expected.n4_elements.len == actual.n4_elements.len
  assert expected.n4_elements.keys() == actual.n4_elements.keys()
  assert expected.n4_elements.values() == actual.n4_elements.values()
  assert expected.n8_elements.len == actual.n8_elements.len
  assert expected.n8_elements.keys() == actual.n8_elements.keys()
  assert expected.n8_elements.values() == actual.n8_elements.values()
  assert expected.nx_elements.len == actual.nx_elements.len
  assert expected.nx_elements.keys() == actual.nx_elements.keys()
  assert expected.nx_elements.values() == actual.nx_elements.values()
}

fn test__decode__should_read_from_the_byte_buffer_a_valid_codec_16_byte_array() {
  avl_io_element_parser := AvlIoElementParser.new()

  data_to_decode := helpers_avl_io.byte_array_codec_16
  mut buffer := ByteBuffer.from_bytes(data_to_decode)
  buffer.reset_position()

  expected := helpers_avl_io.avl_io_element_codec_16()
  actual := avl_io_element_parser.decode(mut buffer, CodecId.codec16)!

  assert data_to_decode == buffer.as_bytes()
  assert expected.codec_id == actual.codec_id
  assert expected.event_io_id == actual.event_io_id
  assert expected.number_of_total_io == actual.number_of_total_io
  assert expected.n1_elements.len == actual.n1_elements.len
  assert expected.n1_elements.keys() == actual.n1_elements.keys()
  assert expected.n1_elements.values() == actual.n1_elements.values()
  assert expected.n2_elements.len == actual.n2_elements.len
  assert expected.n2_elements.keys() == actual.n2_elements.keys()
  assert expected.n2_elements.values() == actual.n2_elements.values()
  assert expected.n4_elements.len == actual.n4_elements.len
  assert expected.n4_elements.keys() == actual.n4_elements.keys()
  assert expected.n4_elements.values() == actual.n4_elements.values()
  assert expected.n8_elements.len == actual.n8_elements.len
  assert expected.n8_elements.keys() == actual.n8_elements.keys()
  assert expected.n8_elements.values() == actual.n8_elements.values()
}
