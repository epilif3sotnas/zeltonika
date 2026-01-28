module h_io


// internal
import public.api.avldata { AvlIoElement, CodecId, Generation }
import internal.parser.transport.avl.io { IAvlIoElementParser }
import internal.utils.bytebuffer { ByteBuffer }


pub struct NoAvlIoElementParser implements IAvlIoElementParser {}

pub fn NoAvlIoElementParser.new() NoAvlIoElementParser {
	return NoAvlIoElementParser{}
}

pub fn (_ &NoAvlIoElementParser) encode(avl_io_element AvlIoElement, mut buffer ByteBuffer) ! {}

pub fn (_ &NoAvlIoElementParser) decode(mut buffer ByteBuffer, codec_id CodecId) !AvlIoElement {
  return AvlIoElement{}
}
