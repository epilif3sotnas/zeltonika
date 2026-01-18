module bytebuffer


pub enum ByteBufferTypeError {
  position_out_of_bounds
  not_enough_data
  read_only_buffer
}


pub struct ByteBufferError {
  Error
pub:
  kind ByteBufferTypeError
  err  IError
}

pub fn ByteBufferError.new(kind ByteBufferTypeError) ByteBufferError  {
  return match kind {
    .position_out_of_bounds {
      ByteBufferError {
        kind: kind
        err: PositionOutOfBoundsError.new()
      }
    }
    .not_enough_data {
      ByteBufferError {
        kind: kind
        err: NotEnoughDataError.new()
      }
    }
    .read_only_buffer {
      ByteBufferError {
        kind: kind
        err: ReadOnlyBufferError.new()
      }
    }
  }
}

fn (self &ByteBufferError) msg() string {
  return self.err.msg()
}

fn (self &ByteBufferError) code() int {
  return self.err.code()
}


struct PositionOutOfBoundsError {
  Error
}

fn PositionOutOfBoundsError.new() PositionOutOfBoundsError {
  return PositionOutOfBoundsError{}
}

fn (_ &PositionOutOfBoundsError) msg() string {
  return "New postion is out of bounds"
}


struct NotEnoughDataError {
  Error
}

fn NotEnoughDataError.new() NotEnoughDataError {
  return NotEnoughDataError{}
}

fn (_ &NotEnoughDataError) msg() string {
  return "Not enough data"
}


struct ReadOnlyBufferError {
  Error
}

fn ReadOnlyBufferError.new() ReadOnlyBufferError {
  return ReadOnlyBufferError{}
}

fn (_ &ReadOnlyBufferError) msg() string {
  return "Read only buffer"
}
