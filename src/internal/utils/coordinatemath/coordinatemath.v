module coordinatemath


// std
import math


const teltonika_precision := u32(10_000_000);


pub fn convert_coordinate_to_teltonika_format(coordinate f64) i32 {
    return i32(math.round(coordinate * teltonika_precision))
}

pub fn convert_teltonika_format_to_float(coordinate i32) f64 {
  return f64(coordinate) / f64(teltonika_precision)
}
