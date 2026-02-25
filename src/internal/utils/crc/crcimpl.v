module crc


// std
import math.bits as bits_utils


// TODO: Add implements of interface ICrc
// pub struct Crc[T] implements ICrc[T] {
pub struct Crc[T] {
  algorithm   Algorithm[T]
  bits u32 = sizeof(T) * 8
  table       [256]u64
mut:
  crc_value    u64
}

pub fn Crc.new[T](algorithm Algorithm[T]) Crc[T] {
  lookup_table := init_lookup_table[T](algorithm)
  mut crc := Crc[T]{ algorithm: algorithm, table: lookup_table }
  return crc
}

pub fn (mut self Crc[T]) init() {
  self.crc_value = if self.algorithm.reflect_input {
      bit_reverse[T](u64(self.algorithm.initial))
  } else {
      u64(self.algorithm.initial)
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

pub fn (self &Crc[T]) final() T {
  mut result := self.crc_value

  if self.algorithm.reflect_input != self.algorithm.reflect_output {
    result = bit_reverse[T](result)
  }

  return T(result ^ u64(self.algorithm.xor_output))
}

pub fn (self &Crc[T]) hash(data []u8) T {
  mut crc := Crc.new[T](self.algorithm)
  crc.init()
  crc.update(data)
  return crc.final()
}

fn init_lookup_table[T](algorithm Algorithm[T]) [256]u64 {
  mut lookup_table := [256]u64{}
  bits := sizeof(T) * 8

  poly := if algorithm.reflect_input {
    bit_reverse[T](u64(algorithm.polynomial))
  } else {
    u64(algorithm.polynomial)
  }

  for i in 0 .. 256 {
    mut crc := u64(i)

    if algorithm.reflect_input {
      for _ in 0 .. 8 {
          if crc & 1 != 0 {
              crc = ((crc >> 1) ^ poly)
          } else {
              crc = (crc >> 1)
          }
      }
    } else {
      crc <<= u64(bits - 8)
      for _ in 0 .. 8 {
        if crc & (u64(1) << u64(bits - 1)) != 0 {
            crc = ((crc << 1) ^ poly)
        } else {
            crc = (crc << 1)
        }
      }
    }
    lookup_table[i] = crc
  }

  return lookup_table
}

fn bit_reverse[T](x u64) u64 {
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
