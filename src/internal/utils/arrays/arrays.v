module arrays


pub fn array_to_fixed_1[T](values []T) [1]T {
  mut array_converted := [1]T{}

  for idx, value in values {
    if idx == 1 {
      break
    }

    array_converted[idx] = value
  }

  return array_converted
}

pub fn array_to_fixed_2[T](values []T) [2]T {
  mut array_converted := [2]T{}

  for idx, value in values {
    if idx == 2 {
      break
    }

    array_converted[idx] = value
  }

  return array_converted
}

pub fn array_to_fixed_4[T](values []T) [4]T {
  mut array_converted := [4]T{}

  for idx, value in values {
    if idx == 4 {
      break
    }

    array_converted[idx] = value
  }

  return array_converted
}

pub fn array_to_fixed_8[T](values []T) [8]T {
  mut array_converted := [8]T{}

  for idx, value in values {
    if idx == 8 {
      break
    }

    array_converted[idx] = value
  }

  return array_converted
}
