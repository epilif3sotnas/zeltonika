module crc


pub struct Algorithm[T] {
	polynomial        T
	initial           T
	reflect_input     bool
	reflect_output    bool
	xor_output        T
}

pub fn Algorithm.new[T](
  polynomial T,
  initial T,
  reflect_input bool,
  reflect_output bool,
  xor_output T,
) Algorithm[T] {
  return Algorithm[T] {
    polynomial: polynomial,
    initial: initial,
    reflect_input: reflect_input,
    reflect_output: reflect_output,
    xor_output: xor_output,
  }
}
