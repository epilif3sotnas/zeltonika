module tuple


// internal
import internal.utils.bytebuffer { ByteBuffer }
import public.api.avldata { UdpAvlData, TcpAvlData }


type AvlData = UdpAvlData | TcpAvlData

// NOTE: This struct was originally written as a generic[T, U] struct.
// However, the V compiler has a bug where generic Tuple types used in arrays
// (e.g., []Tuple[ByteBuffer, TcpAvlData]) fail to compile with:
// "undefined symbol 'src__internal__utils__tuple__Tuple__static__new_T_...'"
// This is a known V compiler issue with generic type instantiation at the C level.
// To workaround this bug, we use concrete types (ByteBuffer and interface{})
// instead of generics. Using interface{} allows the struct to hold any data type
// while avoiding the compiler bug.
pub struct Tuple {
pub:
	second  AvlData @[required]
pub mut:
	first   ByteBuffer @[required]
}


// new creates a new Tuple instance with the given buffer and data.
// The data parameter is of type interface{} to workaround the V compiler bug
// with generic types in arrays.
pub fn Tuple.new(mut value1 ByteBuffer, value2 AvlData) Tuple {
  return Tuple {
    first: value1,
    second: value2,
  }
}
