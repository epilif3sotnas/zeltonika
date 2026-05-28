module io


// internal
import public.api.avldata { AvlIoElement, CodecId }
import internal.utils.bytebuffer { ByteBuffer }


pub interface IAvlIoElementParser {
  encode(avl_io_element AvlIoElement, mut byte_buffer ByteBuffer) !
  decode(mut byte_buffer ByteBuffer, coded_id CodecId) !AvlIoElement
}
