module io


// internal
import api.avldata { AvlIoElement, CodecId, Generation }
import utils.bytebuffer { ByteBuffer }
import utils.arrays as utils_arrays
import parser.transport.avl.io.models { AvlIoCodec8, AvlIoCodec8e, AvlIoCodec16 }


enum AvlIoElementBytes {
  element1
  element2
  element4
  element8
  elementn
}

type AvlIo = AvlIoCodec8 | AvlIoCodec8e | AvlIoCodec16


struct AvlIoElementParser implements IAvlIoElementParser {}

pub fn AvlIoElementParser.new() AvlIoElementParser {
	return AvlIoElementParser{}
}

pub fn (self &AvlIoElementParser) encode(avl_io_element AvlIoElement, mut buffer ByteBuffer) ! {
	match avl_io_element.codec_id {
		.codec8 {
			avl_io := AvlIo(AvlIoCodec8 {
				event_io_id: u8(avl_io_element.event_io_id)
				number_of_total_io: u8(avl_io_element.number_of_total_io)
			})
			self.encode_codec8(avl_io_element, avl_io, mut buffer)!
		}
		.codec8e {
			avl_io := AvlIo(AvlIoCodec8e {
				event_io_id: u16(avl_io_element.event_io_id)
				number_of_total_io: u16(avl_io_element.number_of_total_io)
			})
			self.encode_codec8e(avl_io_element, avl_io, mut buffer)!
		}
		.codec16 {
			avl_io := AvlIo(AvlIoCodec16 {
				event_io_id: u8(avl_io_element.event_io_id)
				number_of_total_io: u8(avl_io_element.number_of_total_io)
				// TODO: Change the generation_type to get the .? when feature landed in V
				generation_type: u8(avl_io_element.generation_type or { panic("THIS SHOULD BE CHANGED GENERATION") })
			})
			self.encode_codec16(avl_io_element, avl_io, mut buffer)!
		}
	}
}

fn (self &AvlIoElementParser) encode_codec8(avl_io_element AvlIoElement, avl_io AvlIo, mut buffer ByteBuffer) ! {
	self.encode_io_element_common(avl_io, mut buffer)!
	self.encode_n_io_elements[u8, u8](avl_io_element.n1_elements, mut buffer, .element1)!
	self.encode_n_io_elements[u8, u8](avl_io_element.n2_elements, mut buffer, .element2)!
	self.encode_n_io_elements[u8, u8](avl_io_element.n4_elements, mut buffer, .element4)!
	self.encode_n_io_elements[u8, u8](avl_io_element.n8_elements, mut buffer, .element8)!
}

fn (self &AvlIoElementParser) encode_codec8e(avl_io_element AvlIoElement, avl_io AvlIo, mut buffer ByteBuffer) ! {
	self.encode_io_element_common(avl_io, mut buffer)!
	self.encode_n_io_elements[u16, u16](avl_io_element.n1_elements, mut buffer, .element1)!
	self.encode_n_io_elements[u16, u16](avl_io_element.n2_elements, mut buffer, .element2)!
	self.encode_n_io_elements[u16, u16](avl_io_element.n4_elements, mut buffer, .element4)!
	self.encode_n_io_elements[u16, u16](avl_io_element.n8_elements, mut buffer, .element8)!
	self.encode_n_io_elements[u16, u16](avl_io_element.nx_elements, mut buffer, .elementn)!
}

fn (self &AvlIoElementParser) encode_codec16(avl_io_element AvlIoElement, avl_io AvlIo, mut buffer ByteBuffer) ! {
	self.encode_io_element_common(avl_io, mut buffer)!
	self.encode_n_io_elements[u8, u16](avl_io_element.n1_elements, mut buffer, .element1)!
	self.encode_n_io_elements[u8, u16](avl_io_element.n2_elements, mut buffer, .element2)!
	self.encode_n_io_elements[u8, u16](avl_io_element.n4_elements, mut buffer, .element4)!
	self.encode_n_io_elements[u8, u16](avl_io_element.n8_elements, mut buffer, .element8)!
}

fn (_ &AvlIoElementParser) encode_io_element_common(avl_io AvlIo, mut buffer ByteBuffer) ! {
	match avl_io {
		AvlIoCodec8 { buffer.put(avl_io)! }
		AvlIoCodec8e { buffer.put(avl_io)! }
		AvlIoCodec16 { buffer.put(avl_io)! }
	}
}

fn (_ &AvlIoElementParser) encode_n_io_elements[N, K](
  avl_n_element map[u16][]u8,
  mut buffer ByteBuffer,
  avl_io_element AvlIoElementBytes
) ! {
  buffer.put(N(avl_n_element.len))!

  if avl_n_element.len == 0 {
    return
  }

  for k, v in avl_n_element {
    buffer.put(K(k))!

   	match avl_io_element {
   	  .element1 { buffer.put(utils_arrays.array_to_fixed_1[u8](v))! }
   	  .element2 { buffer.put(utils_arrays.array_to_fixed_2[u8](v))! }
   	  .element4 { buffer.put(utils_arrays.array_to_fixed_4[u8](v))! }
   	  .element8 { buffer.put(utils_arrays.array_to_fixed_8[u8](v))! }
      .elementn {
        buffer.put(u16(v.len))!
        buffer.put(v)!
      }
  	}
  }
}

fn (self &AvlIoElementParser) decode(
	mut buffer ByteBuffer,
	codec_id CodecId,
) !AvlIoElement {
  io_element_common := self.decode_io_element_common(mut buffer, codec_id)!

  return match codec_id {
   	.codec8 {
   	  AvlIoElement {
   			codec_id: codec_id
   			event_io_id: (io_element_common as AvlIoCodec8).event_io_id
   			number_of_total_io: (io_element_common as AvlIoCodec8).number_of_total_io
   			n1_elements: self.decode_n_io_element(mut buffer, 1, false, true, true)!
   			n2_elements: self.decode_n_io_element(mut buffer, 2, false, true, true)!
   			n4_elements: self.decode_n_io_element(mut buffer, 4, false, true, true)!
   			n8_elements: self.decode_n_io_element(mut buffer, 8, false, true, true)!
  		}
   	}
   	.codec8e {
     	AvlIoElement {
    		codec_id: codec_id
    		event_io_id: (io_element_common as AvlIoCodec8e).event_io_id
    		number_of_total_io: (io_element_common as AvlIoCodec8e).number_of_total_io
    		n1_elements: self.decode_n_io_element(mut buffer, 1, false, false, false)!
    		n2_elements: self.decode_n_io_element(mut buffer, 2, false, false, false)!
    		n4_elements: self.decode_n_io_element(mut buffer, 4, false, false, false)!
    		n8_elements: self.decode_n_io_element(mut buffer, 8, false, false, false)!
    		nx_elements: self.decode_n_io_element(mut buffer, 0, true, false, false)!
     	}
   	}
   	.codec16 {
     	AvlIoElement {
    		codec_id: codec_id
    		event_io_id: (io_element_common as AvlIoCodec16).event_io_id
    		number_of_total_io: (io_element_common as AvlIoCodec16).number_of_total_io
    		generation_type: Generation.from((io_element_common as AvlIoCodec16).generation_type)!
    		n1_elements: self.decode_n_io_element(mut buffer, 1, false, true, false)!
    		n2_elements: self.decode_n_io_element(mut buffer, 2, false, true, false)!
    		n4_elements: self.decode_n_io_element(mut buffer, 4, false, true, false)!
    		n8_elements: self.decode_n_io_element(mut buffer, 8, false, true, false)!
     	}
   	}
  }
}

fn (_ &AvlIoElementParser) decode_io_element_common(
	mut buffer ByteBuffer,
	codec_id CodecId,
) !AvlIo {
  return match codec_id {
  	.codec8     { AvlIo(buffer.get[AvlIoCodec8]()!) }
  	.codec8e    { AvlIo(buffer.get[AvlIoCodec8e]()!) }
  	.codec16    { AvlIo(buffer.get[AvlIoCodec16]()!) }
  }
}

fn (_ &AvlIoElementParser) decode_n_io_element(
	mut buffer ByteBuffer,
	size usize,
	dynamic bool,
	is_n_u8 bool,
	is_k_u8 bool,
) !map[u16][]u8 {
  mut n_io_elements := map[u16][]u8{}
  n_elements := if is_n_u8 {
    usize(buffer.get[u8]()!)
  } else {
    usize(buffer.get[u16]()!)
  }

  if n_elements == 0 {
  	return n_io_elements
  }

  for _ in 0 .. n_elements {
  	key := if is_k_u8 {
  	  u16(buffer.get[u8]()!)
  	} else {
  	  buffer.get[u16]()!
  	}

  	mut bytes := []u8{}

  	if dynamic {
  	  length := buffer.get[u16]()!

  		for _ in 0 .. length {
  		  bytes << buffer.get[u8]()!
  		}

  		n_io_elements[u16(key)] = bytes
  	} else {
  		for _ in 0 .. size {
  		  bytes << buffer.get[u8]()!
  		}
  	}

  	n_io_elements[key] = bytes
  }

  return n_io_elements
}
