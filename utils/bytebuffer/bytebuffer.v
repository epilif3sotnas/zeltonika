module bytebuffer


// std
import encoding.binary


pub struct ByteBuffer {
  encoding_config binary.EncodeConfig = binary.EncodeConfig {
    buffer_len: 2048
    big_endian: true
  }
  decoding_config binary.DecodeConfig = binary.DecodeConfig {
    buffer_len: 2048
    big_endian: true
  }
mut:
	data      []u8
	pos       usize
	read_only bool
}

pub fn ByteBuffer.new() ByteBuffer {
	return ByteBuffer{}
}

pub fn ByteBuffer.from_bytes(bytes []u8) ByteBuffer {
	return ByteBuffer {
		data: bytes.clone()
		pos:  usize(bytes.len)
	}
}

pub fn ByteBuffer.with_capacity(cap usize) ByteBuffer {
	return ByteBuffer {
		data: []u8 { cap: int(cap) }
	}
}

pub fn (mut bb ByteBuffer) clear() {
	bb.data.clear()
	bb.pos = 0
}

pub fn (bb &ByteBuffer) capacity() usize {
	return usize(bb.data.cap)
}

pub fn (bb &ByteBuffer) position() usize {
	return bb.pos
}

pub fn (mut bb ByteBuffer) reset_position() {
	bb.pos = 0
}

pub fn (mut bb ByteBuffer) reset_position_last() {
  bb.pos = usize(bb.data.len)
}

pub fn (mut bb ByteBuffer) set_new_position(new_pos usize) ! {
	if new_pos > bb.data.len {
		return ByteBufferError.new(.position_out_of_bounds)
	}

	bb.pos = new_pos
}

pub fn (bb &ByteBuffer) is_read_only() bool {
	return bb.read_only
}

pub fn (mut bb ByteBuffer) set_read_only() {
	bb.read_only = true
}

pub fn (bb &ByteBuffer) size() usize {
	return usize(bb.data.len)
}

pub fn (bb &ByteBuffer) as_bytes() []u8 {
	return bb.data
}

pub fn (bb &ByteBuffer) from_position() []u8 {
	return bb.data[bb.pos..]
}

pub fn (bb &ByteBuffer) to_position() []u8 {
	return bb.data[..bb.pos + 1]
}

// This function only supports primitive types,
// fixed arrays with u8s, and packed structs.
//
// Note: If this passed types other than the stated here
// a error is returned or in some cases undefined behaviour
// can occur mainly when unsupported types are inside
// supported.
pub fn (mut bb ByteBuffer) get[T]() !T {
	size := bb.size_of[T]()!
	if usize(bb.data.len) - bb.pos < size {
	  return ByteBufferError.new(.not_enough_data)
	}

	$if T is $string || T is $map || T is $array_dynamic {
    return ByteBufferError.new(.not_supported_type)
  }

  mut t_impl := T{}

  $if T is $array_fixed {
		mut arr := []u8{}
		arr << bb.data[bb.pos..bb.pos + size]

		// prepend size of array to be able to use encoding.binary module
		arr.prepend(binary.encode_binary(arr.len, bb.encoding_config)!)

		for idx, value in binary.decode_binary[[]u8](arr, bb.decoding_config)! {
		  t_impl[idx] = value
		}
	} $else {
		t_impl = binary.decode_binary[T](bb.data[bb.pos..bb.pos + size], bb.decoding_config)!
	}

	bb.pos += size
	return t_impl
}

// This function only supports primitive types,
// fixed arrays with u8s, and packed structs.
//
// Note: If this passed types other than the stated here
// a error is returned or in some cases undefined behaviour
// can occur mainly when unsupported types are inside
// supported.
pub fn (mut bb ByteBuffer) put[T](value T) ! {
	if bb.read_only {
		return ByteBufferError.new(.read_only_buffer)
	}

  $if T is $string || T is $map || T is $array_dynamic {
    return ByteBufferError.new(.not_supported_type)
	}

	mut bytes := []u8{}
	$if T is $array_fixed {
		bytes = value[..].clone()
	} $else {
	  bytes = binary.encode_binary(value, bb.encoding_config)!
	}

	bb.data.insert(int(bb.pos), bytes)
	bb.pos += bb.size_of[T]()!
}

// This function only supports primitive types,
// fixed arrays with types supported by this function,
// and packed structs.
//
// Note: If this passed types other than the stated here
// a error is returned or in some cases undefined behaviour
// can occur mainly when unsupported types are inside
// supported.
fn (bb &ByteBuffer) size_of[T]() !usize {
  $if T is $string || T is $map || T is $array_dynamic {
    return ByteBufferError.new(.not_supported_type)
  }

  return usize(sizeof(T))
}

pub fn (bb &ByteBuffer) print_debug() {
	println('Buffer Content: ${bb.data.hex()}')
	println('Buffer Size: ${bb.data.len}')
	println('Position: ${bb.pos}')
	println('Read Only: ${bb.read_only}')
}
