// std
const std = @import("std");


const TELTONIKA_PRECISION = 10_000_000;


pub fn convertCoordinateToTeltonikaFormat(coordinate: f64) i32 {
    return @as(i32, @intFromFloat(@round(coordinate * TELTONIKA_PRECISION)));
}

pub fn convertTeltonikaFormatToFloat(coordinate: i32) f64 {
    return @as(f64, @floatFromInt(coordinate)) / @as(f64, @floatFromInt(TELTONIKA_PRECISION));
}
