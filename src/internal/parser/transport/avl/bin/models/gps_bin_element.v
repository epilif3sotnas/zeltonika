module models


@[packed]
pub struct GpsBinElement {
pub:
  longitude   i32
  latitude    i32
  altitude    i16
  angle       u16
  satellites  u8
  speed       u16
}
