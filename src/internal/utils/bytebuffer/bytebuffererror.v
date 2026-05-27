module bytebuffer


pub struct ByteBufferError {
    Error
pub:
    user_msg ?string
    cause IError
}

pub fn ByteBufferError.new(user_msg ?string, cause IError) ByteBufferError  {
    return ByteBufferError {
        user_msg: user_msg,
        cause: cause,
    }
}

pub fn (self &ByteBufferError) msg() string {
    mut error_msg := "ByteBufferError -> error when performing an operation in ByteBuffer"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    error_msg += "\nCaused by: ${self.cause}"

    return error_msg
}
