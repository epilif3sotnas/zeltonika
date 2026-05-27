module bytebuffer


pub struct PositionOutOfBoundsError {
    Error
    new_pos usize
    max_pos usize
pub:
    user_msg ?string
    cause ?IError
}

pub fn PositionOutOfBoundsError.new(user_msg ?string, cause ?IError, new_pos usize, max_pos usize) PositionOutOfBoundsError {
    return PositionOutOfBoundsError {
        user_msg: user_msg,
        cause: cause,
        new_pos: new_pos,
        max_pos: max_pos,
    }
}

pub fn (self &PositionOutOfBoundsError) msg() string {
    mut error_msg := "PositionOutOfBoundsError -> new position ${self.new_pos} is out of bounds with a max value of ${self.max_pos}"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}


pub struct NotEnoughDataError {
    Error
pub:
    user_msg ?string
    cause ?IError
}

pub fn NotEnoughDataError.new(user_msg ?string, cause ?IError) NotEnoughDataError {
    return NotEnoughDataError {
        user_msg: user_msg,
        cause: cause,
    }
}

pub fn (self &NotEnoughDataError) msg() string {
    mut error_msg := "NotEnoughDataError -> ByteBuffer does not have enough data to read"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}


pub struct ReadOnlyBufferError {
    Error
pub:
    user_msg ?string
    cause ?IError
}

pub fn ReadOnlyBufferError.new(user_msg ?string, cause ?IError) ReadOnlyBufferError {
    return ReadOnlyBufferError {
        user_msg: user_msg,
        cause: cause,
    }
}

pub fn (self &ReadOnlyBufferError) msg() string {
    mut error_msg := "ReadOnlyBufferError -> failing when trying to write to a read only ByteBuffer"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}


pub enum OperationSupportTypeError {
    decoding
    encoding
    neither
}

pub struct NotSupportedTypeError {
    Error
    type_error string
    operation_type OperationSupportTypeError
pub:
    user_msg ?string
    cause ?IError
}

pub fn NotSupportedTypeError.new(user_msg ?string, cause ?IError, type_error string, operation_type OperationSupportTypeError) NotSupportedTypeError {
    return NotSupportedTypeError {
        user_msg: user_msg,
        cause: cause,
        type_error: type_error,
        operation_type: operation_type
    }
}

pub fn (self &NotSupportedTypeError) msg() string {
    mut error_msg := "NotSupportedTypeError -> ByteBuffer does not support ${self.type_error}"
        + "${if self.operation_type == OperationSupportTypeError.neither { "" } else { " when ${self.operation_type}" }}"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}


pub struct FromToEqualError {
    Error
pub:
    user_msg ?string
    cause ?IError
}

pub fn FromToEqualError.new(user_msg ?string, cause ?IError) FromToEqualError {
    return FromToEqualError {
        user_msg: user_msg,
        cause: cause,
    }
}

pub fn (self &FromToEqualError) msg() string {
    mut error_msg := "FromToEqualError -> 'from' and 'to' args have the same value"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}


pub struct FromBiggerThanToError {
    Error
    from usize
    to usize
pub:
    user_msg ?string
    cause ?IError
}

pub fn FromBiggerThanToError.new(user_msg ?string, cause ?IError, from usize, to usize) FromBiggerThanToError {
    return FromBiggerThanToError {
        user_msg: user_msg,
        cause: cause,
        from: from,
        to: to,
    }
}

pub fn (self &FromBiggerThanToError) msg() string {
    mut error_msg := "FromBiggerThanToError -> 'from' is bigger than 'to' {from=${self.from}, to=${self.to}}"

    if self.user_msg != none {
        error_msg += "\n\tmessage -> '${self.user_msg}'"
    }

    if self.cause != none {
        error_msg += "\nCaused by: ${self.cause}"
    }

    return error_msg
}
