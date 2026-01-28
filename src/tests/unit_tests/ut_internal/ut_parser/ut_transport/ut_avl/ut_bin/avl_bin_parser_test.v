module ut_bin


// internal
import public.api.avldata { CodecId }
import internal.parser.transport.avl.bin { AvlBinParser }
import internal.utils.bytebuffer { ByteBuffer }
import tests.helpers.h_internal.h_parser.h_transport.h_avl.h_bin as helpers_avl_bin
import tests.helpers.h_internal.h_parser.h_transport.h_avl.h_io as helpers_avl_io


const no_avl_io_element_parser := helpers_avl_io.NoAvlIoElementParser.new()


fn test__encode__should_write_to_the_buffer_avl_data() {
  avl_bin_parser := AvlBinParser.new_test(no_avl_io_element_parser)

  mut buffer := ByteBuffer.new()

  input := helpers_avl_bin.avl_data()

  avl_bin_parser.encode(mut buffer, input)!

  actual := buffer.as_bytes()
  expected := helpers_avl_bin.byte_array

  assert expected == actual
}

fn test__decode__should_read_the_buffer_avl_data_and_parse_to_avl_data() {
  avl_bin_parser := AvlBinParser.new_test(no_avl_io_element_parser)

  data_to_decode := helpers_avl_bin.byte_array
  mut buffer := ByteBuffer.from_bytes(data_to_decode)
  buffer.reset_position()

  expected := helpers_avl_bin.avl_data()
  actual := avl_bin_parser.decode(mut buffer, CodecId.codec8)!

  assert data_to_decode == buffer.as_bytes()
  assert expected.timestamp == actual.timestamp
  assert expected.priority == actual.priority
  assert expected.gps_element.longitude == actual.gps_element.longitude
  assert expected.gps_element.latitude == actual.gps_element.latitude
  assert expected.gps_element.altitude == actual.gps_element.altitude
  assert expected.gps_element.angle == actual.gps_element.angle
  assert expected.gps_element.satellites == actual.gps_element.satellites
  assert expected.gps_element.speed == actual.gps_element.speed
}
