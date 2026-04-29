module tuple


pub struct Tuple[T1, T2] {
	first T1 @[required]
	second T2 @[required]
}


pub fn Tuple.new[T1, T2](value1 T1, value2 T2) Tuple[T1, T2] {
  return Tuple {
    first: value1
    second: value2
  }
}
