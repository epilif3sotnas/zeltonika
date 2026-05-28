module crc


pub interface ICrc {
  calculate([]u8) u16
  is_valid([]u8, u16) bool
}
