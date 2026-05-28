module errors


pub struct CrcError {
    Error
    crc_calculated  u16
    crc_received    u16
pub:
    user_msg        ?string
    cause           ?IError
}

pub fn CrcError.new(user_msg ?string, cause ?IError, crc_calculated u16, crc_received u16) CrcError {
    return CrcError {
        user_msg: user_msg,
        cause: cause,
        crc_calculated: crc_calculated,
        crc_received: crc_received,
    }
}

pub fn (self &CrcError) msg() string {
    mut error_msg := "CrcError -> CRC mismatched (calculated:${self.crc_calculated:04x}, received:${self.crc_received:04x})"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}


pub enum AvlPacketSizeLimitType {
    min
    max
}

pub struct AvlPacketSizeError {
    Error
    limit_size                  usize
    bytes_received              usize
pub:
    user_msg                    ?string
    cause                       ?IError
    avl_packet_size_limit_type  AvlPacketSizeLimitType
}

pub fn AvlPacketSizeError.new(
    user_msg ?string,
    cause ?IError,
    avl_packet_size_limit_type AvlPacketSizeLimitType,
    bytes_received usize,
    limit_size usize,
) AvlPacketSizeError {
    return AvlPacketSizeError {
        user_msg: user_msg,
        cause: cause,
        avl_packet_size_limit_type: avl_packet_size_limit_type,
        bytes_received: bytes_received,
        limit_size: limit_size,
    }
}

pub fn (self &AvlPacketSizeError) msg() string {
    mut error_msg := "AvlPacketSizeError -> ${self.avl_packet_size_limit_type} limit not complaint with"
        + " ${self.bytes_received} bytes received but ${self.avl_packet_size_limit_type} limit is ${self.limit_size} bytes"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}
