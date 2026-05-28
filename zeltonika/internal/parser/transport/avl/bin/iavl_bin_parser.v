module bin


// internal
import public.api.avldata { AvlData, CodecId }
import internal.utils.bytebuffer { ByteBuffer }


pub interface IAvlBinParser {
  encode(mut buffer ByteBuffer, avl_data AvlData) !
  decode(mut buffer ByteBuffer, codec_id CodecId) !AvlData
}
