module crc


interface ICrc[T] {
  final() T
mut:
  update([]u8)
  hash([]u8) T
}
