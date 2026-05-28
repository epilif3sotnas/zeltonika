module h_io


// internal
import public.api.avldata { AvlIoElement, CodecId, Generation }
import internal.parser.transport.avl.io { IAvlIoElementParser }
import internal.utils.bytebuffer { ByteBuffer }


pub struct NoOpAvlIoElementParser implements IAvlIoElementParser {}

pub fn NoOpAvlIoElementParser.new() NoOpAvlIoElementParser {
	return NoOpAvlIoElementParser{}
}

pub fn (_ &NoOpAvlIoElementParser) encode(avl_io_element AvlIoElement, mut buffer ByteBuffer) ! {}

pub fn (_ &NoOpAvlIoElementParser) decode(mut buffer ByteBuffer, codec_id CodecId) !AvlIoElement {
  return AvlIoElement{}
}
