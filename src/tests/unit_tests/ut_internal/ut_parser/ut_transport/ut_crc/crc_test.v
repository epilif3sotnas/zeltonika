module ut_crc


// std
import encoding.hex
import internal.parser.transport.crc { Crc }


fn test__new__should_return_the_crc() {
  crc_instance := Crc.new()
}

fn test__calculate__should_return_valid_generated_crc_teltonika() {
	mut crc_instance := Crc.new()

	data_hex := "08010000016b40d8ea30010000000000000000000000000000000105021503010101425e0f01f10000601a014e000000000000000001"
	input := hex.decode(data_hex)!

	expected := u32(0x0000c7cf)
	actual := crc_instance.calculate(input)

	assert expected == actual
}

fn test__calculate__should_return_algorithm_initial() {
  mut crc_instance := Crc.new()

	expected := u32(0x0000)
	actual := crc_instance.calculate([])
	assert expected == actual
}

fn test__is_valid__should_return_true_for_valid_crc_teltonika_and_valid_crc_value() {
  mut crc_instance := Crc.new()

	data_hex := "08010000016b40d8ea30010000000000000000000000000000000105021503010101425e0f01f10000601a014e000000000000000001"
	input := hex.decode(data_hex)!

	expected := u16(0xc7cf)
	actual := crc_instance.is_valid(input, expected)
	assert actual
}

fn test_is_valid_should_return_false_for_invalid_crc16_ibm_and_different_crc_value() {
  mut crc_instance := Crc.new()

	data_hex := "08010000016b40d8ea30010000000000000000000000000000000105021503010101425e0f01f10000601a014e000000000000000001"
	input := hex.decode(data_hex)!

	expected := u16(0x0000)
	actual := crc_instance.is_valid(input, expected)
	assert !actual
}
