module tuple


pub struct Tuple[T1, T2] {
	value_1 T1 @[required]
	value_2 T2 @[required]
}


pub fn Tuple.new[T1, T2](value1 T1, value2 T2) Tuple[T1, T2] {
  return Tuple {
    value1: value1
    value2: value2
  }
}
