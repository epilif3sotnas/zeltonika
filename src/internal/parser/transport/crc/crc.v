module crc


// internal
import internal.utils.crc as crc_util


pub struct Crc implements ICrc {
mut:
  crc_teltonika crc_util.Crc[u16] = crc_util.crc16_arc()
}

pub fn Crc.new() Crc {
	return Crc{}
}

pub fn (mut self Crc) calculate(data []u8) u16 {
  return self.crc_teltonika.hash(data)
}

pub fn (mut self Crc) is_valid(data []u8, crc u16) bool {
	return crc == self.calculate(data)
}
