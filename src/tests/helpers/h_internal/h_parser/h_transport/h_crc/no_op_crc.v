module h_crc


// internal
import internal.parser.transport.crc { ICrc }


pub struct NoOpCrc implements ICrc {}

pub fn NoOpCrc.new() NoOpCrc {
	return NoOpCrc{}
}

pub fn (_ &NoOpCrc) calculate(data []u8) u16 {
  return 0x13
}

pub fn (_ &NoOpCrc) is_valid(data []u8, crc_value u16) bool {
  return true
}
