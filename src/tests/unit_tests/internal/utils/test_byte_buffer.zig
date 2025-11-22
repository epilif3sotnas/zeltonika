// std
const std = @import("std");
const testing = std.testing;

// internal
const ByteBuffer = @import("../../../../internal/utils/ByteBuffer.zig").ByteBuffer;
const ByteBufferError = ByteBuffer.ByteBufferError;


test "init should return an empty byte buffer" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    try testing.expectEqual(0, buffer.size());
    try testing.expectEqual(0, buffer.arrayCapacity());
    try testing.expectEqual(0, buffer.position());
    try testing.expectEqual(false, buffer.isReadOnly());
}

test "initBuffer should return an byte buffer with the data received in buffer param" {
    const allocator = std.testing.allocator;

    const buffer_input = "Hello, World!";

    var buffer = try ByteBuffer.initBuffer(allocator, buffer_input);
    defer buffer.deinit();

    try testing.expectEqual(buffer_input.len, buffer.size());
    try testing.expectEqual(buffer_input.len, buffer.arrayCapacity());
    try testing.expectEqual(buffer_input.len - 1, buffer.position());
    try testing.expectEqual(false, buffer.isReadOnly());
}

test "initCapacity should return an empty byte buffer with a capacity of 100" {
    const allocator = std.testing.allocator;

    const capacity = 100;

    var buffer = try ByteBuffer.initCapacity(allocator, capacity);
    defer buffer.deinit();

    try testing.expectEqual(0, buffer.size());
    try testing.expectEqual(capacity, buffer.arrayCapacity());
    try testing.expectEqual(0, buffer.position());
    try testing.expectEqual(false, buffer.isReadOnly());
}

test "resetPosition should return the position of ByteBuffer as 0" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input_write = &[_]u8 { 0x01, 0x02, 0x03 };
    try buffer.put(input_write);
    buffer.resetPosition();

    const expected = 0;
    const actual = buffer.position();

    try testing.expectEqual(expected, actual);
}

test "setNewPosition should return change the ByteBuffer to new position" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input_write = &[_]u8 { 0x01, 0x02, 0x03 };
    try buffer.put(input_write);
    try buffer.setNewPosition(1);

    const expected = 1;
    const actual = buffer.position();

    try testing.expectEqual(expected, actual);
}

test "setNewPosition should return an error of out of bounds" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const input_write = &[_]u8 { 0x01, 0x02, 0x03 };
    try buffer.put(input_write);

    const expected = ByteBufferError.PositionOutOfBounds;
    const actual = buffer.setNewPosition(10);

    try testing.expectError(expected, actual);
}

test "setReadOnly should return an read only ByteBuffer" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    buffer.setReadOnly();

    const expected = true;
    const actual = buffer.isReadOnly();

    try testing.expectEqual(expected, actual);
}

test "array should return the byte buffer's array" {
    const allocator = std.testing.allocator;

    var buffer = try ByteBuffer.initCapacity(allocator, 3);
    defer buffer.deinit();

    const expected = &[_]u8 { 0x01, 0x02, 0x03 };

    try buffer.put(expected);
    const actual = buffer.array();

    try testing.expectEqualSlices(u8, expected, actual);

    try testing.expectEqual(expected.len, buffer.size());
    try testing.expectEqual(expected.len, buffer.arrayCapacity());
    try testing.expectEqual(expected.len, buffer.position());
    try testing.expectEqual(false, buffer.isReadOnly());
}

test "arrayFromPosition should return the byte buffer's array subset" {
    const allocator = std.testing.allocator;

    var buffer = try ByteBuffer.initCapacity(allocator, 3);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x01, 0x02, 0x03, 0x04 };
    try buffer.put(buffer_data);
    try buffer.setNewPosition(2);

    const expected = &[_]u8 { 0x03, 0x04 };
    const actual = buffer.arrayFromPosition();

    try testing.expectEqualSlices(u8, expected, actual);
}

test "arrayToPosition should return the byte buffer's array subset" {
    const allocator = std.testing.allocator;

    var buffer = try ByteBuffer.initCapacity(allocator, 3);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x01, 0x02, 0x03, 0x04 };
    try buffer.put(buffer_data);
    try buffer.setNewPosition(2);

    const expected = &[_]u8 { 0x01, 0x02, 0x03 };
    const actual = buffer.arrayToPosition();

    try testing.expectEqualSlices(u8, expected, actual);
}

test "get should return the data without any error" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x01, 0x02, 0x03, 0x04, 0x01, 0x42, 0x48 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected_value_u16 = 0x0102;
    const actual_value_u16 = try buffer.get(u16);

    var expected_pos: usize = 2;

    try testing.expectEqual(expected_value_u16, actual_value_u16);
    try testing.expectEqual(expected_pos, buffer.position());


    const expected_value_i16 = 0x0304;
    const actual_value_i16 = try buffer.get(i16);

    expected_pos = 4;

    try testing.expectEqual(expected_value_i16, actual_value_i16);
    try testing.expectEqual(expected_pos, buffer.position());


    const expected_value_bool = true;
    const actual_value_bool = try buffer.get(bool);

    expected_pos = 5;

    try testing.expectEqual(expected_value_bool, actual_value_bool);
    try testing.expectEqual(expected_pos, buffer.position());

    const expected_value_f16: f16 = 3.140625;
    const actual_value_f16 = try buffer.get(f16);

    expected_pos = 7;

    try testing.expectEqual(expected_value_f16, actual_value_f16);
    try testing.expectEqual(expected_pos, buffer.position());
}

const TestStruct = struct {
    a1: u16,
    a2: i16,
    a3: bool,
    a4: f16,
};

test "get should return a struct without any error" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x01, 0x02, 0x03, 0x04, 0x01, 0x42, 0x48 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected: TestStruct = .{
        .a1 = 0x0102,
        .a2 = 0x0304,
        .a3 = true,
        .a4 = 3.140625,
    };
    const expected_pos = 7;
    const actual = try buffer.get(TestStruct);

    try testing.expectEqual(expected, actual);
    try testing.expectEqual(expected_pos, buffer.position());
}

const TestStruct_2 = struct {
    a1: bool,
    a2: TestStruct,
};

test "get should return a struct inside struct without any error" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x00, 0x01, 0x02, 0x03, 0x04, 0x01, 0x42, 0x48 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected: TestStruct_2 = .{
        .a1 = false,
        .a2 = .{
            .a1 = 0x0102,
            .a2 = 0x0304,
            .a3 = true,
            .a4 = 3.140625,
        }
    };
    const expected_pos = 8;
    const actual = try buffer.get(TestStruct_2);

    try testing.expectEqual(expected, actual);
    try testing.expectEqual(expected_pos, buffer.position());
}

test "get should return a NotEnoughData error when the buffer does not have enough data to read T" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x01, 0x02, 0x03, 0x04, 0x01, 0x42 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected = ByteBufferError.NotEnoughData;
    const actual = buffer.get(TestStruct);

    try testing.expectError(expected, actual);
}

test "get should return an InvalidIntegerType error when the T type is not power of 2 bytes (integers)" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x01, 0x02, 0x03, 0x04, 0x01, 0x42 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected = ByteBufferError.InvalidIntegerType;
    const actual = buffer.get(u10);

    try testing.expectError(expected, actual);
}

test "get should return an ByteNotSupported error when the byte is not 0 or 1 on bool read" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x42 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected = ByteBufferError.ByteNotSupported;
    const actual = buffer.get(bool);

    try testing.expectError(expected, actual);
}

test "get should return an NotSupportedType error when the type is not supported" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data = &[_]u8 { 0x42 };
    try buffer.put(buffer_data);
    buffer.resetPosition();

    const expected = ByteBufferError.NotSupportedType;
    const actual = buffer.get(?u8);

    try testing.expectError(expected, actual);
}

const TestStructPut = struct {
    a1: u16,
    a2: i32,
    a3: f16,
    a4: *const [2]u8,
    a5: bool,
};

test "put should add bytes to the ByteBuffer without any error" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const test_struct = TestStructPut {
        .a1 = 0x0102,
        .a2 = 0x03040506,
        .a3 = 3.140625,
        .a4 = &[_]u8 { 0x09, 0x0a },
        .a5 = true,
    };
    try buffer.put(test_struct);

    const expected = &[_]u8 {
        0x01, 0x02, 0x03, 0x04, 0x05, 0x06,
        0x42, 0x48, 0x09, 0x0a, 0x01,
    };
    const actual = buffer.array();

    const expected_len = expected.len;
    const actual_len = buffer.size();

    try testing.expectEqualSlices(u8, expected, actual);
    try testing.expectEqual(expected_len, actual_len);
}

const TestStructPut_2 = struct {
    a1: u32,
    a2: TestStructPut,
    a3: bool,
};

test "put should add bytes with nested structs to the ByteBuffer without error" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const test_struct = TestStructPut_2 {
        .a1 = 0x01020304,
        .a2 = TestStructPut {
            .a1 = 0x0506,
            .a2 = 0x0708090a,
            .a3 = 3.140625,
            .a4 = &[_]u8 { 0x0b, 0x0c },
            .a5 = true,
        },
        .a3 = false,
    };
    try buffer.put(test_struct);

    const expected = &[_]u8 {
        0x01, 0x02, 0x03, 0x04,
        0x05, 0x06, 0x07, 0x08, 0x09, 0x0a,
        0x42, 0x48, 0x0b, 0x0c, 0x01, 0x00,
    };
    const actual = buffer.array();

    const expected_len = expected.len;
    const actual_len = buffer.size();

    try testing.expectEqualSlices(u8, expected, actual);
    try testing.expectEqual(expected_len, actual_len);
}

test "put should return an ReadOnlyBuffer error when the the buffer is set as read only" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();
    buffer.setReadOnly();

    const buffer_data: u8 = 0x01;

    const expected = ByteBufferError.ReadOnlyBuffer;
    const actual = buffer.put(buffer_data);

    try testing.expectError(expected, actual);
}

test "put should return an InvalidIntegerType error when the T type is not power of 2 bytes (integers)" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data: u2 = 0x01;

    const expected = ByteBufferError.InvalidIntegerType;
    const actual = buffer.put(buffer_data);

    try testing.expectError(expected, actual);
}

test "put should return an notsupportedtype error when the type is not supported" {
    const allocator = std.testing.allocator;

    var buffer = ByteBuffer.init(allocator);
    defer buffer.deinit();

    const buffer_data: ?u8 = 0x01;

    const expected = ByteBufferError.NotSupportedType;
    const actual = buffer.put(buffer_data);

    try testing.expectError(expected, actual);
}
