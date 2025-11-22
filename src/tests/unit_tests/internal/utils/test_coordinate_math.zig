// std
const std = @import("std");
const testing = std.testing;

// internal
const coordinate_math = @import("../../../../internal/utils/coordinate_math.zig");


test "coordinate_math.convertCoordinateToTeltonikaFormat should return valid teltonika coordinate format" {
    const input_latitude = 51.50722;
    const input_longitude = -0.1275;

    const expected_latitude = 515072200;
    const actual_latitude = coordinate_math.convertCoordinateToTeltonikaFormat(input_latitude);

    try testing.expectEqual(expected_latitude, actual_latitude);

    const expected_longitude = -1275000;
    const actual_longitude = coordinate_math.convertCoordinateToTeltonikaFormat(input_longitude);

    try testing.expectEqual(expected_longitude, actual_longitude);
}

test "coordinate_math.convertTeltonikaFormatToFloat should return valid f64 value" {
    const input_latitude = 515072200;
    const input_longitude = -1275000;

    const expected_latitude = 51.50722;
    const actual_latitude = coordinate_math.convertTeltonikaFormatToFloat(input_latitude);

    try testing.expectEqual(expected_latitude, actual_latitude);

    const expected_longitude = -0.1275;
    const actual_longitude = coordinate_math.convertTeltonikaFormatToFloat(input_longitude);

    try testing.expectEqual(expected_longitude, actual_longitude);
}
