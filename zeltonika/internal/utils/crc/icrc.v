module crc


pub interface ICrc[T] {
  final() T
  hash([]u8) T
mut:
  update([]u8)
}
