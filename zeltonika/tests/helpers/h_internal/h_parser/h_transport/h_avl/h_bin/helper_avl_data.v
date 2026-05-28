module h_bin


// internal
import public.api.avldata { AvlData, GpsElement, AvlIoElement }


pub const byte_array := [
  u8(0x00), 0x00, 0x01, 0x6B, 0x40, 0xD8,
  0xEA, 0x30, 0x01, 0xFF, 0xEC, 0x8B, 0x88,
  0x1E, 0xB3, 0x60, 0xC8, 0x02, 0xFD, 0x00,
  0x84, 0x02, 0x00, 0x7D
]

pub fn avl_data() AvlData {
  return AvlData {
    timestamp: 0x0000016B40D8EA30
  	priority: .high
  	gps_element: GpsElement {
     	longitude: -0.1275
      latitude: 51.50722
      altitude: 765
      angle: 132
      satellites: 2
      speed: 125
  	}
  	io_element: AvlIoElement{}
  }
}
