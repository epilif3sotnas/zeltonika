module crc


// std
import math.bits as bits_utils


// TODO: Add implements of interface ICrc
// pub struct Crc[T] implements ICrc[T] {
pub struct Crc[T] {
  algorithm   Algorithm[T]
  bits u32 = sizeof(T) * 8
mut:
  crc_value    u64
  table       [256]u64
}

pub fn Crc.new[T](algorithm Algorithm[T]) Crc[T] {
  mut crc := Crc[T]{ algorithm: algorithm }
  crc.init_lookup_table()
  return crc
}

pub fn (mut self Crc[T]) init() {
  self.crc_value = if self.algorithm.reflect_input {
      self.bit_reverse(u64(self.algorithm.initial))
  } else {
      u64(self.algorithm.initial)
  }
}

fn (mut self Crc[T]) init_lookup_table() {
  poly := if self.algorithm.reflect_input {
    self.bit_reverse(u64(self.algorithm.polynomial))
  } else {
    u64(self.algorithm.polynomial)
  }

  for i in 0 .. 256 {
    mut crc := u64(i)

    if self.algorithm.reflect_input {
      for _ in 0 .. 8 {
          if crc & 1 != 0 {
              crc = ((crc >> 1) ^ poly)
          } else {
              crc = (crc >> 1)
          }
      }
    } else {
      crc <<= u64(self.bits - 8)
      for _ in 0 .. 8 {
        if crc & (u64(1) << u64(self.bits - 1)) != 0 {
            crc = ((crc << 1) ^ poly)
        } else {
            crc = (crc << 1)
        }
      }
    }
    self.table[i] = crc
  }
}

pub fn (mut self Crc[T]) update(data []u8) {
 	for byte in data {
		idx := if self.algorithm.reflect_input {
			u8(self.crc_value ^ u64(byte))
		} else {
			u8((self.crc_value >> (self.bits - 8)) ^ u64(byte))
		}

		self.crc_value = self.table[idx] ^ if self.algorithm.reflect_input {
			self.crc_value >> 8
		} else {
			self.crc_value << 8
		}
	}
}

pub fn (self Crc[T]) final() T {
  mut result := self.crc_value

  if self.algorithm.reflect_input != self.algorithm.reflect_output {
    result = self.bit_reverse(result)
  }

  return T(result ^ u64(self.algorithm.xor_output))
}

pub fn (mut self Crc[T]) hash(data []u8) T {
  self.init()
	self.update(data)
	return self.final()
}

fn (self &Crc[T]) bit_reverse(x u64) u64 {
  mut res := u64(0)

  $if T is u8 {
    res = bits_utils.reverse_8(T(x))
  } $else $if T is u16 {
    res = bits_utils.reverse_16(T(x))
  } $else $if T is u32 {
    res = bits_utils.reverse_32(T(x))
  } $else {
    res = bits_utils.reverse_64(T(x))
  }

  return res
}
