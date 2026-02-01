module h_bin


// internal
import public.api.avldata { AvlData, CodecId }
import internal.parser.transport.avl.bin { IAvlBinParser }
import internal.utils.bytebuffer { ByteBuffer }


pub struct NoOpAvlBinParser implements IAvlBinParser {}

pub fn NoOpAvlBinParser.new() NoOpAvlBinParser {
	return NoOpAvlBinParser{}
}

pub fn (_ &NoOpAvlBinParser) encode(mut buffer ByteBuffer, avl_data AvlData) ! {}

pub fn (_ &NoOpAvlBinParser) decode(mut buffer ByteBuffer, codec_id CodecId) !AvlData {
  return AvlData{}
}
