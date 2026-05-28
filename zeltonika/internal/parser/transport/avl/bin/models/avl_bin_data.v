module models


@[packed]
pub struct AvlBinData {
pub:
  timestamp     u64
  priority      u8
  gps_element   GpsBinElement
}
