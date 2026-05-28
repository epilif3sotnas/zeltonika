module errors


// ZeltonikaError Zeltonika errors are defined here. These errors
// are the public errors that the Public API can return.
pub struct ZeltonikaError {
  Error
pub:
    user_msg ?string
    cause IError
}

pub fn ZeltonikaError.new(user_msg ?string, cause IError) ZeltonikaError  {
    return ZeltonikaError {
        user_msg: user_msg,
        cause: cause,
    }
}

pub fn (self &ZeltonikaError) msg() string {
    mut error_msg := "ZeltonikaError -> error when interacting with zeltonika library"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    error_msg += "\nCaused by: ${self.cause}"

    return error_msg
}
