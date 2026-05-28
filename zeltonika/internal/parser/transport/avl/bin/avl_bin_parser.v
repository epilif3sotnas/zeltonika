module bin


// internal
import public.api.avldata { AvlData, CodecId, Priority, GpsElement }
import internal.utils.bytebuffer { ByteBuffer }
import internal.utils.coordinatemath as coordinate_math
import internal.parser.transport.avl.bin.models { AvlBinData, GpsBinElement }
import internal.parser.transport.avl.io { IAvlIoElementParser, AvlIoElementParser }


pub struct AvlBinParser implements IAvlBinParser {
  avl_io_element_parser IAvlIoElementParser
}

pub fn AvlBinParser.new() AvlBinParser {
  return AvlBinParser.new_test(AvlIoElementParser.new())
}

pub fn AvlBinParser.new_test(avl_io_element_parser IAvlIoElementParser) AvlBinParser {
  return AvlBinParser {
    avl_io_element_parser: avl_io_element_parser,
  }
}

pub fn (self &AvlBinParser) encode(mut buffer ByteBuffer, avl_data AvlData) ! {
  avl_bin_data := AvlBinData {
    timestamp: avl_data.timestamp
    priority: u8(avl_data.priority)
    gps_element: GpsBinElement {
      longitude: coordinate_math.convert_coordinate_to_teltonika_format(avl_data.gps_element.longitude)
      latitude: coordinate_math.convert_coordinate_to_teltonika_format(avl_data.gps_element.latitude)
      altitude: avl_data.gps_element.altitude
      angle: avl_data.gps_element.angle
      satellites: avl_data.gps_element.satellites
      speed: avl_data.gps_element.speed
    }
  }

  buffer.put(avl_bin_data)!
  self.avl_io_element_parser.encode(avl_data.io_element, mut buffer)!
}

pub fn (self &AvlBinParser) decode(mut buffer ByteBuffer, codec_id CodecId) !AvlData {
  avl_data := buffer.get[AvlBinData]()!
  avl_io_element := self.avl_io_element_parser.decode(mut buffer, codec_id)!

  return AvlData {
    timestamp: avl_data.timestamp
    priority: Priority.from(avl_data.priority)!
    gps_element: GpsElement {
      longitude: coordinate_math.convert_teltonika_format_to_float(avl_data.gps_element.longitude)
      latitude: coordinate_math.convert_teltonika_format_to_float(avl_data.gps_element.latitude)
      altitude: avl_data.gps_element.altitude
      angle: avl_data.gps_element.angle
      satellites: avl_data.gps_element.satellites
      speed: avl_data.gps_element.speed
    }
    io_element: avl_io_element
  }
}
