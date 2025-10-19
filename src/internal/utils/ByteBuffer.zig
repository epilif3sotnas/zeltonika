// std
const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;
const Size = std.builtin.Type.Pointer.Size;


pub const ByteBufferError = error{
    PositionOutOfBounds,
    NotEnoughData,
    NotSupportedType,
    InvalidIntegerType,
    InvalidFloatType,
    ByteNotSupported,
};


pub const ByteBuffer = @This();


_array: ArrayList(u8),
_allocator: Allocator,
_pos: usize = 0,
_read_only: bool = false,


pub fn init(allocator: Allocator) ByteBuffer {
    return .{
        ._array = .empty,
        ._allocator = allocator,
    };
}

pub fn initBuffer(allocator: Allocator, buffer: []const u8) Allocator.Error!ByteBuffer {
    var _buffer = try ArrayList(u8).initCapacity(allocator, buffer.len);
    try _buffer.appendSlice(allocator, buffer);

    return .{
        ._array = _buffer,
        ._allocator = allocator,
        ._pos = buffer.len - 1,
    };
}

pub fn initCapacity(allocator: Allocator, capacity: usize) Allocator.Error!ByteBuffer {
    return .{
        ._array = try .initCapacity(allocator, capacity),
        ._allocator = allocator,
    };
}

pub fn deinit(self: *ByteBuffer) void {
    self._array.deinit(self._allocator);
}

pub fn arrayCapacity(self: *ByteBuffer) usize {
    return self._array.capacity;
}

pub fn position(self: *ByteBuffer) usize {
    return self._pos;
}

pub fn resetPosition(self: *ByteBuffer) void {
    self._pos = 0;
}

pub fn setNewPosition(self: *ByteBuffer, new_position: usize) !void {
    if (new_position >= self._array.items.len) {
        return error.PositionOutOfBounds;
    }

    self._pos = new_position;
}

pub fn isReadOnly(self: *ByteBuffer) bool {
    return self._read_only;
}

pub fn setReadOnly(self: *ByteBuffer) void {
    self._read_only = true;
}

pub fn size(self: *ByteBuffer) usize {
    return self._array.items.len;
}

pub fn array(self: *ByteBuffer) []const u8 {
    return self._array.items;
}

pub fn arrayFromPosition(self: *ByteBuffer) []const u8 {
    return self._array.items[self._pos..];
}

pub fn arrayToPosition(self: *ByteBuffer) []const u8 {
    return self._array.items[0..self._pos + 1];
}

pub fn get(self: *ByteBuffer, comptime T: type) !T {
    if (self._array.items.len - self._pos < self.sizeOf(T)) {
        return ByteBufferError.NotEnoughData;
    }

    return switch (@typeInfo(T)) {
        .int => |info| {
            if (info.bits != 8 * @sizeOf(T)) {
                return ByteBufferError.InvalidIntegerType;
            }

            const bytes = self._array.items[self._pos..self._pos + @sizeOf(T)][0..@sizeOf(T)];
            self._pos += @sizeOf(T);
            return std.mem.readInt(T, bytes, .big);
        },
        .float => |info| {
            if (info.bits != 8 * @sizeOf(T)) {
                return ByteBufferError.InvalidFloatType;
            }

            const bytes = self._array.items[self._pos..self._pos + @sizeOf(T)][0..@sizeOf(T)];
            const value = switch (info.bits) {
                16 => std.mem.readInt(u16, bytes, .big),
                32 => std.mem.readInt(u32, bytes, .big),
                64 => std.mem.readInt(u64, bytes, .big),
                else => return ByteBufferError.InvalidFloatType,
            };

            self._pos += @sizeOf(T);
            return @bitCast(value);
        },
        .bool => {
            const byte = self._array.items[self._pos];

            if (byte >= 0x02) {
                return ByteBufferError.ByteNotSupported;
            }

            self._pos += @sizeOf(T);
            return if (byte == 0x01) true else false;
        },
        .array => |info| {
            var tmp_buffer: T = undefined;

            var idx: usize = 0;
            while (idx < info.len) : (idx += 1) {
                const item = try self.get(info.child);
                tmp_buffer[idx] = item;
            }

            return tmp_buffer;
        },
        .@"enum" => |info| {
            return @enumFromInt(try self.get(info.tag_type));
        },
        .@"struct" => {
             var result: T = undefined;

            inline for (@typeInfo(T).@"struct".fields) |field| {
                 @field(result, field.name) = try self.get(field.type);
            }

            return result;
        },
        else => return ByteBufferError.NotSupportedType,
    };
}

fn sizeOf(self: *ByteBuffer, comptime T: type) usize {
    return bytes: {
        var total: usize = 0;

        switch (@typeInfo(T)) {
            .int, .float, .bool => total += @sizeOf(T),
            .@"struct" => |info| {
                inline for (info.fields) |field| {
                    total += self.sizeOf(field.type);
                }
            },
            else => {},
        }

        break :bytes total;
    };
}

pub fn put(self: *ByteBuffer, value: anytype) !void {
    const T = @TypeOf(value);

    switch (@typeInfo(T)) {
        .int => |info| {
            if (info.bits != 8 * @sizeOf(T)) {
                return ByteBufferError.InvalidIntegerType;
            }

            var value_slices: [@sizeOf(T)]u8 = @bitCast(value);
            std.mem.reverse(u8, &value_slices);
            try self._array.insertSlice(self._allocator, self._pos, &value_slices);
            self._pos += @sizeOf(T);
        },
        .float => |info| {
            if (info.bits != 8 * @sizeOf(T)) {
                return ByteBufferError.InvalidFloatType;
            }

            var value_slices: [@sizeOf(T)]u8 = @bitCast(value);
            std.mem.reverse(u8, &value_slices);
            try self._array.insertSlice(self._allocator, self._pos, &value_slices);
            self._pos += @sizeOf(T);
        },
        .bool => {
            const value_slices = if (value) [_]u8{0x01} else [_]u8{0x00};
            try self._array.insertSlice(self._allocator, self._pos, &value_slices);
            self._pos += @sizeOf(T);
        },
        .array => {
            for (value[0..]) |item| {
                try self.put(item);
            }
        },
        .@"enum" => {
            try self.put(@intFromEnum(value));
        },
        .pointer => |info| {
            if (info.size == Size.slice) {
                try self.put(value);
                return;
            }

            try self.put(value.*);
        },
        .@"struct" => |info| {
            inline for (info.fields) |field| {
                try self.put(@field(value, field.name));
            }
        },
        else => return ByteBufferError.NotSupportedType,
    }
}

pub fn print(self: *ByteBuffer) void {
    std.debug.print("Buffer Content: {any}\nBuffer Size: {any}\nPosition: {any}\nRead Only: {any}\n\n", .{ self._array.items, self._array.items.len, self._pos, self._read_only });
}
